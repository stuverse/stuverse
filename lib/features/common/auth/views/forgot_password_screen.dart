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
              Text('Otp Verification',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(
                height: 20,
              ),
              Text(
                'We will send an One Time Password on this email',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w100,
                      fontFamily: 'Poppins',
                    ),
              ),
              SizedBox(
                height: 50,
              ),
              Text('Enter Email',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(
                height: 20,
              ),
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
              FilledButton(
                onPressed: () {},
                child: Center(
                  child: Text(
                    'Get OTP',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ]),
          ),
        ))));
  }
}
