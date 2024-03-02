// ignore_for_file: lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _formKey = GlobalKey<FormState>();
  int _selectedRadioValue = 0;
  int _selectedRadioValue2 = 0;
  final _branchController = TextEditingController();
  final _yearController = TextEditingController();

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
                        RadioMenuButton<int>(
                          value: 1,
                          groupValue: _selectedRadioValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedRadioValue = value!;
                            });
                          },
                          child: Text('Alumini').toCenter(),
                        ),
                        10.heightBox,
                        if (_selectedRadioValue == 1) ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabeledFormInput(
                                label: 'Branch',
                                isRequired: true,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter branch name';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Enter your branch name',
                                  ),
                                  controller: _branchController,
                                ),
                              ),
                              10.heightBox,
                              LabeledFormInput(
                                label: 'Graduation Year',
                                isRequired: true,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter graduation year';
                                    }
                                    if (int.tryParse(value) == null) {
                                      return 'Enter a valid graduation year';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Enter your graduation year',
                                  ),
                                  controller: _yearController,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ],
                        RadioMenuButton(
                          value: 2,
                          groupValue: _selectedRadioValue2,
                          onChanged: (value) {
                            setState(() {
                              _selectedRadioValue2 = value!;
                            });
                          },
                          child: Text('Student').toCenter(),
                        ),
                        10.heightBox,
                        if (_selectedRadioValue2 == 2)
                          ...[
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                  BlocConsumer<AuthCubit, AuthState>(
                                    listener: (context, state) {
                                      state.mapOrNull(
                                        signUpFailure: (state) {
                                          context.showErrorMessage(
                                              message: state.message);
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
                                                color: context
                                                    .colorScheme.onBackground,
                                              ),
                                            ),
                                        orElse: () => FilledButton(
                                              onPressed: () {
                                                HapticFeedback.lightImpact();
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  context
                                                      .read<AuthCubit>()
                                                      .signUpWithEmailAndPassword(
                                                        email: _emailController
                                                            .text,
                                                        name: _nameController
                                                            .text,
                                                        password:
                                                            _passwordController
                                                                .text,
                                                      );
                                                }
                                              },
                                              child: Text(
                                                'Sign Up',
                                              ).toCenter(),
                                            )),
                                  ),
                                ])
                          ].defaultListAnimation(),
                      ]),
                ),
              ),
            ),
          )),
    );
  }
}

class _BranchChoice {
  _BranchChoice({required this.label, required this.value});

  final String label;
  final String value;
}
