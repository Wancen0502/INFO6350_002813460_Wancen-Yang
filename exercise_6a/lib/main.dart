import 'package:exercise_6a/IndexPage.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Demo',
      theme: ThemeData.light(),
      home: IndexPage(),
    );
  }
}
