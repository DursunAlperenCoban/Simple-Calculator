// main.dart

import 'package:flutter/material.dart';
import 'package:calculator/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment 1',
      theme: ThemeData(
        primarySwatch: Colors.green,
        canvasColor: Colors.green.shade50,
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}