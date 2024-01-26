import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/common/common.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      context.go(SignInScreen.routeName);
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
          const CircularProgressIndicator(
            color: Colors.white,
          ),
        ],
      )),
    );
  }
}
