import 'package:flutter/material.dart';
import 'package:stuverse/features/common/auth/widgets/custom_textfield.dart';
import 'package:stuverse/features/common/common.dart';

class EmailOtpScreen extends StatelessWidget {
  const EmailOtpScreen({super.key});
  static const String routeName = '/email-otp';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BgGradient(
        child: SafeArea(
          child: Form(
              child: Padding(
            padding: const EdgeInsets.all(12),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "test@gmail.com",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Change Email?",
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.primary,
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
                    SizedBox(
                      width: 28,
                    ),
                    CustomTextField(),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomTextField(),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomTextField(),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomTextField(),
                    SizedBox(
                      width: 28,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 28,
                ),
                Spacer(),
                Row(children: [
                  ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Text(
                          "Resend",
                          style: TextStyle(fontSize: 15).copyWith(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      )),
                  Spacer(),
                  FilledButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                ])
              ],
            ),
          )),
        ),
      ),
    );
  }
}
