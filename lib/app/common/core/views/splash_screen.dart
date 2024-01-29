import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      context.go(CommonRoutes.onBoarding);
    });
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
          CircularProgressIndicator(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ],
      )),
    );
  }
}
