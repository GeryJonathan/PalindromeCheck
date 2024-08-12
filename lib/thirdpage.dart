import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List _users = [];
  int _page = 1;
  bool _isLoading = false;
  bool _isLastPage = false;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers({bool isRefresh = false}) async {
    if (_isLoading || _isLastPage) return;

    if (isRefresh) {
      _page = 1;
      _isLastPage = false;
      _users.clear();
    }

    setState(() {
      _isLoading = true;
    });

    final response = await http.get(
      Uri.parse('https://reqres.in/api/users?page=$_page&per_page=10'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List fetchedUsers = data['data'];

      setState(() {
        if (isRefresh) {
          _users = fetchedUsers;
        } else {
          _users.addAll(fetchedUsers);
        }
        _isLastPage = fetchedUsers.length < 10;
        _page++;
      });
    } else {
      throw Exception('Failed to load users');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _selectUser(Map<String, String> user) {
    Navigator.pop(context, user);
  }

  Future<void> _onRefresh() async {
    await _fetchUsers(isRefresh: true);
  }

  void _nextPage() {
    if (!_isLastPage && !_isLoading) {
      _fetchUsers();
    }
  }

  void _previousPage() {
    if (_page > 2 && !_isLoading) {
      setState(() {
        _page -= 2; 
      });
      _fetchUsers(isRefresh: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Third Screen - Select User',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: _users.isEmpty && !_isLoading
                  ? const Center(
                      child: Text(
                        'No users available. Pull to refresh.',
                        style: TextStyle(color: Colors.black54),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView.builder(
                        itemCount: _users.length + (_isLastPage ? 0 : 1),
                        itemBuilder: (context, index) {
                          if (index == _users.length) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final user = _users[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user['avatar']),
                            ),
                            title: Text(
                              '${user['first_name']} ${user['last_name']}',
                              style: const TextStyle(color: Colors.black),
                            ),
                            subtitle: Text(
                              user['email'],
                              style: const TextStyle(color: Colors.black54),
                            ),
                            onTap: () => _selectUser({
                              'name':
                                  '${user['first_name']} ${user['last_name']}',
                              'email': user['email'],
                              'avatar': user['avatar'],
                            }),
                          );
                        },
                      ),
                    ),
            ),
            if (_users.isNotEmpty && !_isLastPage)
              ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Next'),
              ),
          ],
        ),
      ),
    );
  }
}
