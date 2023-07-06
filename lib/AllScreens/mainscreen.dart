import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  static const String idScreen = "mainScreen";

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
      ),
    );
  }
}

