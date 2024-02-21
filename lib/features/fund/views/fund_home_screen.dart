import 'package:flutter/material.dart';

class FundHomeScreen extends StatelessWidget {
  const FundHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fund'),
      ),
      body: const Center(
        child: Text('Fund Home Screen'),
      ),
    );
  }
}
