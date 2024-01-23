import 'package:flutter/material.dart';
import 'package:stuverse/app/app.dart';

import '../widgets/bg_greadient.dart';

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
