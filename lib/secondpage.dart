import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'thirdpage.dart'; // Import the ThirdScreen

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

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
              'Hello, ${appState.name}!',
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 16.0),
            if (appState.selectedUserAvatar != null)
              CircleAvatar(
                backgroundImage: NetworkImage(appState.selectedUserAvatar!),
                radius: 40,
              ),
            if (appState.selectedUserAvatar != null) const SizedBox(height: 16.0),
            Text(
              appState.selectedUserName != null
                  ? 'Selected User: ${appState.selectedUserName}'
                  : 'No User Selected',
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            if (appState.selectedUserEmail != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Email: ${appState.selectedUserEmail}',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThirdScreen()),
                );

                if (result != null) {
                  appState.setSelectedUser(result);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Choose a User'),
            ),
          ],
        ),
      ),
    );
  }
}
