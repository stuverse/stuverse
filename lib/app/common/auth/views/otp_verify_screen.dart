import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/app/common/auth/widgets/otp_field.dart';

class OtpVerifyScreen extends StatefulWidget {
  OtpVerifyScreen({super.key, required this.email});
  final String email;

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController1 = TextEditingController();
  final _otpController2 = TextEditingController();
  final _otpController3 = TextEditingController();
  final _otpController4 = TextEditingController();

  String otp = '';

  Timer? _resendTimer;
  int _resendDuration = 30;
  int _resendCountdown = 30;

  @override
  void initState() {
    super.initState();
    startResendTimer();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    super.dispose();
  }

  void startResendTimer() {
    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
        } else {
          _resendTimer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    void onOtpFieldChanged(String value) {
      if (value.length == 1) {
        FocusScope.of(context).nextFocus();
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Email OTP'),
        elevation: 0,
      ),
      body: BgGradient(
        child: SafeArea(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: context.paddingHorz,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Verification Code",
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "We have sent the code verification to",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.6),
                            ),
                          ),
                          5.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.email,
                                style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              TextButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: Text(
                                  "Change Email?",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OtpField(
                                  otpController: _otpController1,
                              ),
                              20.widthBox,
                              OtpField(
                                  otpController: _otpController2,
                              ),
                              20.widthBox,
                              OtpField(
                                  otpController: _otpController3,
                              ),
                              20.widthBox,
                              OtpField(
                                  otpController: _otpController4,
                                  isLastField: true,
                              ),

                            ],
                          ),
                          20.heightBox,
                          Text(
                            _resendCountdown > 0
                                ? "Resend in $_resendCountdown"
                                : "",
                            style: context.labelMedium!.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.7)),
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        state.mapOrNull(
                          otpVerifyFailure: (state) {
                            context.showErrorMessage(message: state.message);
                          },
                        );
                      },
                      builder: (context, state) {
                        return state.maybeMap(
                          otpVerifyLoading: (state) => Center(
                            child: CircularProgressIndicator(
                              color: context.colorScheme.onBackground,
                            ),
                          ),
                          orElse: () => Row(
                            children: [
                              ElevatedButton(
                                onPressed: _resendCountdown > 0
                                    ? null
                                    : () {
                                        context.read<AuthCubit>().sendOtp(
                                              email: widget.email,
                                              isResend: true,
                                            );
                                        setState(() {
                                          _resendCountdown = _resendDuration;
                                          startResendTimer();
                                        });
                                      },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                       vertical: 10),
                                  child: Text(
                                    "Resend",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ).expanded(),
                              10.widthBox,
                              FilledButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      otp = _otpController1.text +
                                          _otpController2.text +
                                          _otpController3.text +
                                          _otpController4.text;
                                      context.read<AuthCubit>().verifyOtp(
                                            email: widget.email,
                                            otp: otp,
                                          );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                         vertical: 10),
                                    child: Text(
                                      "Confirm",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                    ),
                                  ),
                                  style: FilledButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )).expanded(),
                            ],
                          ),
                        );
                      },
                    ),
                    10.heightBox,
                  ],
                ),
              )),
        ),
      ),
    );
  }

  String? validateOtpField(value) {
    if (value!.isEmpty) {
      return "Please enter the OTP";
    }
    try {
      int.parse(value);
    } catch (e) {
      return "Please enter a valid OTP";
    }
    return null;
  }
}
