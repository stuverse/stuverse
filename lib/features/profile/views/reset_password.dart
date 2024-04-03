import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';

import '../cubit/reset_password/reset_password_cubit.dart';

class ResetAccountPassword extends StatefulWidget {
  const ResetAccountPassword({super.key});

  @override
  State<ResetAccountPassword> createState() => _ResetAccountPasswordState();
}

class _ResetAccountPasswordState extends State<ResetAccountPassword> {
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Reset Password",
                style: context.titleLarge!.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
            30.heightBox,
            Text(
              "Enter your new password  and this password should be different from your previous password.",
              style: context.bodyMedium,
            ),
            20.heightBox,
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "New Password",
              ),
              obscureText: true,
            ),
            20.heightBox,
            TextField(
              controller: _password2Controller,
              decoration: InputDecoration(
                labelText: "Confirm Password",
              ),
              obscureText: true,
            ),
            50.heightBox,
            Center(
              child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                listener: (context, state) {
                  if (state is ResetPasswordSuccess) {
                    context.go(CommonRoutes.signin);
                    context.read<CoreCubit>().signOut();
                    context.showMessage(message: "Password reset successfully");
                  }
                  if (state is ResetPasswordError) {
                    context.showErrorMessage(
                        message: "Unable to reset password");
                  }
                },
                builder: (context, state) {
                  if (state is ResetPasswordLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return FilledButton(
                    onPressed: () {
                      if (_passwordController.text !=
                          _password2Controller.text) {
                        context.showErrorMessage(
                            message: "Passwords do not match");
                        return;
                      }
                      context.read<ResetPasswordCubit>().resetPassword(
                          password: _passwordController.text,
                          password2: _password2Controller.text);
                    },
                    child: Text("Reset Password",
                        style: context.titleLarge!.copyWith(
                          fontSize: 20,
                        )),
                    style: FilledButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
