import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:stuverse/features/common/common.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<_BranchChoice> branches = [
    _BranchChoice(label: 'Computer Science', value: 'CS'),
    _BranchChoice(label: 'Electronics and Communication', value: 'EC'),
    _BranchChoice(label: 'Electrical', value: 'EE'),
    _BranchChoice(label: 'Mechanical', value: 'ME'),
    _BranchChoice(label: 'Civil', value: 'CE'),
    _BranchChoice(label: 'Information Technology', value: 'IT'),
  ];

  String? selectedBranch;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: BgGradient(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.primaryContainer
              ]),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: const Text(
                        'Create Your Account',
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Name',
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Email',
                    ),
                    TextFormField(
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
                    SizedBox(height: 10),
                    Text(
                      'Password',
                    ),
                    TextFormField(
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
                      obscureText: true,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your password',
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Branch',
                    ),
                    DropdownButtonFormField<String>(
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
                      decoration: const InputDecoration(
                        hintText: 'Select your branch',
                      ),
                    ),
                    const SizedBox(height: 40),
                    FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                      child: Center(
                        child: Text(
                          'Sign Up',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
