import 'package:flutter/material.dart';

class FundHomeScreen extends StatelessWidget {
  const FundHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: const Center(
        child: Text(
          'Fund Home Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
