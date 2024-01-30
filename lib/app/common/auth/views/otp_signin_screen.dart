import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';

class OtpSigningScreen extends StatelessWidget {
  OtpSigningScreen({super.key});

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
          child: Column(
            children: [
              Image.asset(
                AppImages.otp3,
                height: 300,
              ),
              25.heightBox,
              Text(
                'Passwordless Sign In',
                style: context.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w800,
                  color: context.colorScheme.onBackground,
                ),

              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  10.heightBox,
                  Text(
                    'Enter your email address to receive a One-Time Password (OTP) for authentication',
                    textAlign: TextAlign.center,
                    style: context.bodyMedium!.copyWith(
                      color: context.colorScheme.onBackground.withOpacity(0.7),
                    ),
                  ),
                  30.heightBox,
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

                  100.heightBox,
                ],
              ),
              const Spacer(),
              FilledButton(
                onPressed: () {
                  context.push(CommonRoutes.emailOtp);
                },
                style: FilledButton.styleFrom(),
                child: const Text(
                  'Get OTP',
                ).toCenter().paddingSymmetric(vertical: 10),
              ),
            ],
          ).paddingAll(15),

        ),
      ),
    );
  }
}
