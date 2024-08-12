import 'package:flutter/material.dart';
import 'secondpage.dart'; // Import the SecondScreen

class PalindromeCheckerPage extends StatefulWidget {
  const PalindromeCheckerPage({super.key});

  @override
  State<PalindromeCheckerPage> createState() => _PalindromeCheckerPageState();
}

class _PalindromeCheckerPageState extends State<PalindromeCheckerPage> {
  final _nameController = TextEditingController();
  final _sentenceController = TextEditingController();

  // Method to check if a sentence is a palindrome
  bool isPalindrome(String text) {
    text = text.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    return text == text.split('').reversed.join('');
  }

  // Method to check if the sentence is palindrome and show the result in a dialog
  void _checkPalindrome() {
    final sentence = _sentenceController.text;
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

  // Method to navigate to the SecondScreen with the entered name
  void _navigateToSecondScreen() {
    final enteredName = _nameController.text;

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SecondScreen(name: enteredName); // Navigate to SecondScreen
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
                // Input text for name
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
                // Input text for sentence
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
                const SizedBox(height: 16.0),
                // Check button
                ElevatedButton(
                  onPressed: _checkPalindrome,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                  ),
                  child: const Text('Check'),
                ),
                const SizedBox(height: 8.0),
                // Next button
                ElevatedButton(
                  onPressed: _navigateToSecondScreen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
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
