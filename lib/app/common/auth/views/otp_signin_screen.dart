import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';

class OtpSigningScreen extends StatefulWidget {
  OtpSigningScreen({super.key, this.email});
  final String? email;

  @override
  State<OtpSigningScreen> createState() => _OtpSigningScreenState();
}

class _OtpSigningScreenState extends State<OtpSigningScreen> {
  final _emailController = TextEditingController();

  @override
  void initState() {
    if (widget.email != null) {
      _emailController.text = widget.email!;
      context.read<AuthCubit>().sendOtp(
            email: _emailController.text,
          );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: BgGradient(
        child: SafeArea(
          child: Padding(
            padding: context.paddingHorz,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    AppImages.otp3,
                    height: context.minSize * 0.7,
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
                            color: context.colorScheme.onBackground
                                .withOpacity(0.7),
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
                      ]),
                  25.heightBox,
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      state.mapOrNull(
                        otpSendFailure: (state) {
                          context.showErrorMessage(message: state.message);
                        },
                        otpSendSuccess: (state) {
                          context.push(CommonRoutes.otpVerify,
                              extra: _emailController.text);
                        },
                      );
                    },
                    builder: (context, state) => state.maybeMap(
                        otpSendLoading: (state) => Center(
                              child: CircularProgressIndicator(
                                color: context.colorScheme.onBackground,
                              ),
                            ),
                        orElse: () => FilledButton(
                              onPressed: () {
                                if (_emailController.text.isNotEmpty)
                                  context.read<AuthCubit>().sendOtp(
                                        email: _emailController.text,
                                      );
                                else
                                  context.showErrorMessage(
                                      message: 'Please enter your email');
                              },
                              style: FilledButton.styleFrom(),
                              child: Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    'Get OTP',
                                  ),
                                ),
                              ),
                            )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
