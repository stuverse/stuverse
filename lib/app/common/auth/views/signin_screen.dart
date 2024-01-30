import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: BgGradient(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/app/logo/stuverse.png',
                 height: context.minSize * 0.65,
                 width: context.minSize * 0.65,
                  ),
                ),
                Text(
                  'Welcome to StuVerse!',
                  style: context.headlineLarge
                      
                ).bold(),
                10.heightBox,
                LabeledFormInput(
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      } else if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                    ),
                  ),
                  label: 'Email',
                  isRequired: true,
                ),
                10.heightBox,
                LabeledFormInput(
                  label: 'Password',
                  isRequired: true,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      } else if (!RegExp(
                              r'^(?=.*[A-Za-z])(?=.*[0-9!@#$%^&*()_+{}|:;<>,.?~\\-]).+$')
                          .hasMatch(value)) {
                        return 'Password must contain a number or a special character';
                      }
                      return null;
                    },
                    obscureText: _obscureText,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          )),
                    ),
                  ),
                ),
                10.heightBox,
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        context.push(CommonRoutes.otpSignin);
                      },
                      child: Text(
                        'Forgot password?',
                        style:context.bodyMedium!.copyWith(
                              color: context.colorScheme.secondaryContainer
                            ),
                           

                      ).bold()
                      ),
                ),
                10.heightBox,
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: Text(
                    'Login',
                  ).toCenter(),
                ),
               10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: context.bodyMedium
                    ).bold(),
                    TextButton(
                      onPressed: () {
                        context.push(CommonRoutes.signup);
                      },
                      child: Text(
                        'Sign Up',
                        style:context.bodyMedium!.copyWith(
                              color: context.colorScheme.secondaryContainer
                            ),
                      ).bold(),
                    ),
                  ],
                )
              ],
            ).paddingSymmetric(
              horizontal: context.width *0.05,
              vertical: context.height *0.05
            ),
          ),
        ),
      ),
    );
  }
}
