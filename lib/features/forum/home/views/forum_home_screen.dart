import 'package:flutter/material.dart';

class ForumHomeScreen extends StatelessWidget {
  const ForumHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Forum Home Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
