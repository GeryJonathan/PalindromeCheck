import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart'; 
import 'splashscreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color.fromARGB(255, 0, 64, 255),
        ),
      ),
      home: const SplashScreenWrapper(),
    );
  }
}
