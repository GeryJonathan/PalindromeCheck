import 'package:flutter/material.dart';
import 'thirdpage.dart'; // Import the ThirdScreen

class SecondScreen extends StatefulWidget {
  final String name;

  const SecondScreen({super.key, required this.name});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String? _selectedUserName;
  String? _selectedUserEmail;
  String? _selectedUserAvatar;

  // Navigate to ThirdScreen and update the name, email, and avatar based on the selected user
  void _navigateToThirdScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ThirdScreen()),
    );

    if (result != null) {
      setState(() {
        _selectedUserName = result['name'];
        _selectedUserEmail = result['email'];
        _selectedUserAvatar = result['avatar'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Second Screen',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Hello, ${widget.name}!',
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 16.0),
            if (_selectedUserAvatar != null)
              CircleAvatar(
                backgroundImage: NetworkImage(_selectedUserAvatar!),
                radius: 40,
              ),
            if (_selectedUserAvatar != null) const SizedBox(height: 16.0),
            Text(
              _selectedUserName != null
                  ? 'Selected User: $_selectedUserName'
                  : 'No User Selected',
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            if (_selectedUserEmail != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Email: $_selectedUserEmail',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _navigateToThirdScreen,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 24),
              ),
              child: const Text('Choose a User'),
            ),
          ],
        ),
      ),
    );
  }
}
