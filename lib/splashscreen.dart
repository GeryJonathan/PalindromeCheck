import 'dart:async';
import 'package:flutter/material.dart';
import 'package:palindromememe_project/firstpage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          'assets/images/logo.png',
          width: 300,
          height: 200,
        ),
        const Text(
          'Cause why not?',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ]),
    ));
  }
}

class PalindromeApp extends StatelessWidget {
  const PalindromeApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PalindroMeme',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const SplashScreenWrapper(),
    );
  }
}

class SplashScreenWrapper extends StatefulWidget {
  const SplashScreenWrapper({Key? key}) : super(key: key);

  @override
  State<SplashScreenWrapper> createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const PalindromeCheckerPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
