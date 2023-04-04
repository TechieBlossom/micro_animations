import 'package:flutter/material.dart';
import 'package:micro_animations/one_football/home_screen.dart';

void main() {
  runApp(const MicroAnimationsApp());
}

class MicroAnimationsApp extends StatelessWidget {
  const MicroAnimationsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
