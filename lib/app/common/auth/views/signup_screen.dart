// ignore_for_file: lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<_BranchChoice> branches = [
    _BranchChoice(label: 'Computer Science and Engineering', value: 'cse'),
    _BranchChoice(
        label: 'Electronics and Communication Engineering', value: 'ece'),
    _BranchChoice(
        label: 'Electrical and Electronics Engineering', value: 'eee'),
    _BranchChoice(label: 'Mechanical Engineering', value: 'me'),
    _BranchChoice(label: 'Civil Engineering', value: 'ce'),
    _BranchChoice(label: 'Information Technology', value: 'it'),
  ];

  String? selectedBranch;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Your Account',
                    style: context.headlineLarge,
                  ).bold(),
                  20.heightBox,
                  LabeledFormInput(
                    label: 'Name',
                    isRequired: true,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                      ),
                      controller: _nameController,
                    ),
                  ),
                  10.heightBox,
                  LabeledFormInput(
                    label: 'Email',
                    isRequired: true,
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
                  ),
                  10.heightBox,
                  LabeledFormInput(
                    label: 'Mobile',
                    isRequired: true,
                    child: TextFormField(
                      validator: (value) {
                        if (value?.length != 10) {
                          return 'Please enter a valid mobile number';
                        }
                        return null;
                      },
                      controller: _mobileController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your mobile number',
                      ),
                    ),
                  ),
                  10.heightBox,
                  LabeledFormInput(
                    label: 'Branch',
                    isRequired: true,
                    child: DropdownButtonFormField<String>(
                      value: selectedBranch,
                      onChanged: (value) {
                        setState(() {
                          selectedBranch = value!;
                        });
                      },
                      items: branches.map((branch) {
                        return DropdownMenuItem<String>(
                          value: branch.value,
                          child: Text(branch.label),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your branch';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Select your branch',
                      ),
                      isExpanded: true,
                    ),
                  ),
                  10.heightBox,
                  LabeledFormInput(
                    label: 'Password',
                    isRequired: true,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      obscureText: true,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your password',
                      ),
                    ),
                  ),
                  40.heightBox,
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      state.mapOrNull(
                        signUpFailure: (state) {
                          context.showErrorMessage(message: state.message);
                        },
                        signUpSuccess: (state) {
                          context.pop();
                          context.showMessage(
                              message:
                                  'Account created, Now login with your credentials');
                        },
                      );
                    },
                    builder: (context, state) => state.maybeMap(
                        signUpLoading: (state) => Center(
                              child: CircularProgressIndicator(
                                color: context.colorScheme.onBackground,
                              ),
                            ),
                        orElse: () => FilledButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (selectedBranch == null) {
                                    context.showErrorMessage(
                                        message: 'Please select your branch');
                                    return;
                                  }
                                  context
                                      .read<AuthCubit>()
                                      .signUpWithEmailAndPassword(
                                        email: _emailController.text,
                                        name: _nameController.text,
                                        password: _passwordController.text,
                                        mobile: _mobileController.text,
                                        branch: selectedBranch!,
                                      );
                                }
                              },
                              child: Text(
                                'Sign Up',
                              ).toCenter(),
                            )),
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}

class _BranchChoice {
  _BranchChoice({required this.label, required this.value});

  final String label;
  final String value;
}
