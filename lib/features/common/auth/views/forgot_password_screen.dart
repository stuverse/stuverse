import 'package:flutter/material.dart';

import '../../core/widgets/bg_gradient.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  static const String routeName = '/forgot-password';
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: BgGradient(
            child: SafeArea(
                child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Image.asset(
                'assets/common/otp3.png',
                height: 250,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Otp Verification',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onTertiaryContainer),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.blue), //apply style to all
                      children: [
                    TextSpan(
                      text: 'We will send you an',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins',
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                    TextSpan(
                      text: ' One Time Password',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'roboto',
                          fontSize: 18),
                    ),
                    TextSpan(
                      text: ' On this Email',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                          color: Theme.of(context).colorScheme.onSecondary),
                    )
                  ])),
              SizedBox(
                height: 50,
              ),
              Text('Enter Email',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 15)),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Get OTP',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ))));
  }
}
