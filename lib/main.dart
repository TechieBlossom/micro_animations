import 'package:flutter/material.dart';
import 'package:micro_animations/home_screen.dart';

void main() {
  runApp(const MicroAnimationsApp());
}

class MicroAnimationsApp extends StatelessWidget {
  const MicroAnimationsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
