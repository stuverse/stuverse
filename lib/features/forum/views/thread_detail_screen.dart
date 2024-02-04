import 'package:flutter/material.dart';
import 'package:stuverse/app/app.dart';

class ThreadDetailScreen extends StatelessWidget {
  const ThreadDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thread Detail"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: BgGradient(
        child: Center(
          child: Text("Thread Detail Screen"),
        ),
      ),
    );
  }
}
