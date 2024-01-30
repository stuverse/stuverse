import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController(text: '20ncs10@meaec.edu.in');
  final _passwordController = TextEditingController(text: "1234");
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: BgGradient(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/app/logo/stuverse.png',
                      height: 250,
                      width: 250,
                    ),
                  ),
                  Text(
                    'Welcome to StuVerse!',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 15),
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
                  const SizedBox(height: 10),
                  LabeledFormInput(
                    label: 'Password',
                    isRequired: true,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
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
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          context.push(CommonRoutes.otpSignin);
                        },
                        child: Text(
                          'Forgot password?',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                  ),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        state.mapOrNull(
                          signInFailure: (failure) => context.showErrorMessage(
                            message: failure.message,
                          ),
                          accountNotVerified: (_) {
                            context.showAlertDialog(
                                title: 'Account not verified',
                                message:
                                    'Your account is not verified. Please verify your account.',
                                onDone: (p0) => context.push(
                                    CommonRoutes.otpSignin,
                                    extra: _emailController.text),
                                positiveButtonsTitle: [
                                  'Verify Now',
                                ],
                                cancelButtonTitle: "Cancel");
                          },
                          success: (user) {
                            context.go(ForumRoutes.forumHome);
                          },
                        );
                      },
                      builder: (context, state) => state.maybeMap(
                            signInLoading: (_) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            orElse: () => FilledButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<AuthCubit>()
                                      .signInWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      );
                                }
                              },
                              child: Center(
                                child: Text(
                                  'Login',
                                ),
                              ),
                            ),
                          )),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.push(CommonRoutes.signup);
                        },
                        child: Text(
                          'Sign Up',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                  ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
