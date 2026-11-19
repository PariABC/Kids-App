import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Ensure this matches your actual home screen file

void main() {
  runApp(const PariKidsApp());
}

class PariKidsApp extends StatelessWidget {
  const PariKidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pari Kids',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
