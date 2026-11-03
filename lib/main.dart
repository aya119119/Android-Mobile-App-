import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'theme.dart';

void main() => runApp(const AhaApp());

class AhaApp extends StatelessWidget {
  const AhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aha!',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const HomeScreen(),
    );
  }
}
