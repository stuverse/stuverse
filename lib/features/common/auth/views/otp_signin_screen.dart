import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/common/auth/views/email_otp_screen.dart';

import '../../core/widgets/bg_gradient.dart';

class OtpSigningScreen extends StatelessWidget {
  OtpSigningScreen({super.key});
  static const String routeName = '/otp-signin';
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BgGradient(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Image.asset(
                  AppImages.otp3,
                  height: 300,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Passwordless Sign In',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Enter your email address to receive a One-Time Password (OTP) for authentication',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.7),
                        ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  LabeledFormInput(
                    label: 'Email',
                    isRequired: true,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your email',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ]),
                Spacer(),
                FilledButton(
                  onPressed: () {
                    context.push(EmailOtpScreen.routeName);
                  },
                  style: FilledButton.styleFrom(),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Get OTP',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
