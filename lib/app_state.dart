import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  String _name = '';
  String? _selectedUserName;
  String? _selectedUserEmail;
  String? _selectedUserAvatar;

  String get name => _name;
  String? get selectedUserName => _selectedUserName;
  String? get selectedUserEmail => _selectedUserEmail;
  String? get selectedUserAvatar => _selectedUserAvatar;

  void setName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void setSelectedUser(Map<String, String> user) {
    _selectedUserName = user['name'];
    _selectedUserEmail = user['email'];
    _selectedUserAvatar = user['avatar'];
    notifyListeners();
  }
}
