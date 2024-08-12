import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'secondpage.dart'; 

class PalindromeCheckerPage extends StatefulWidget {
  const PalindromeCheckerPage({super.key});

  @override
  State<PalindromeCheckerPage> createState() => _PalindromeCheckerPageState();
}

class _PalindromeCheckerPageState extends State<PalindromeCheckerPage> {
  final _nameController = TextEditingController();
  final _sentenceController = TextEditingController();

  bool isPalindrome(String text) {
    text = text.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    return text == text.split('').reversed.join('');
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Input Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _checkPalindrome() {
    if (_nameController.text.isEmpty) {
      _showAlert('Please enter your name.');
      return;
    }

    final sentence = _sentenceController.text;
    if (sentence.isEmpty) {
      _showAlert('Please enter a sentence to check.');
      return;
    }

    final isPalindromeResult = isPalindrome(sentence);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isPalindromeResult ? 'Palindrome' : 'Not Palindrome'),
        content: Text(
            '"$sentence" is ${isPalindromeResult ? '' : 'not '}a palindrome.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _navigateToSecondScreen() {
    if (_nameController.text.isEmpty) {
      _showAlert('Please enter your name.');
      return;
    }

    final appState = Provider.of<AppState>(context, listen: false);
    appState.setName(_nameController.text);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const SecondScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palindrome Checker'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: SizedBox.expand(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.indigo],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                  height: 220,
                ),
                const SizedBox(height: 32.0),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _sentenceController,
                  decoration: InputDecoration(
                    hintText: 'Enter a sentence to check palindrome',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: _checkPalindrome,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Check'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _navigateToSecondScreen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
