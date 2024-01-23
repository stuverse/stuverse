import 'package:flutter/material.dart';
import 'package:stuverse/app/app.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgGradient(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.logo,
            width: 250,
          ),
          const SizedBox(
            height: 20,
          ),
          const CircularProgressIndicator(
            color: Colors.white,
          ),
        ],
      )),
    );
  }
}

class BgGradient extends StatelessWidget {
  const BgGradient({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // 100%
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: AppTheme.backgroundGradient,
      ),
      child: child,
    );
  }
}
