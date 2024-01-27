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
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  final _formKey=GlobalKey<FormState>();

 final Map<String, String> branchOptions = {
    'Select Branch':'Branch',
    'CSE': 'Computer Science and Engineering',
    'ECE': 'Electronics and Communication Engineering',
    'EEE': 'Electrical and Electronics Engineering',
    'ME': 'Mechanical Engineering',
    'CE': 'Civil Engineering',
    'IT': 'Information Technology',
  };

   String selectedBranch = 'Select Branch'; 
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: 
            [
              Theme.of(context).colorScheme.tertiary,
              Theme.of(context).colorScheme.primaryContainer
            ]
            ),
            ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:20),
                    child: const Text(
                      'Create Your Account',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                   SizedBox(height: 20),
                    Text('Name',
                    style:TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize:15
                    )
                    ),
                      TextFormField(
                      validator: (value) {
                      if (value == null || value.isEmpty) {
                      return 'Please enter name';
                      }
                      },
                      cursorColor: Color.fromARGB(133, 255, 255, 255),
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(133, 255, 255, 255)
                        )
                        ),
                           focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(112, 255, 255, 255),
                          ),
                        ),
                        fillColor: Color.fromARGB(73, 70, 95, 119),
                        filled: true,
                        ),
                      ),
                   SizedBox(height: 10,),
                   Text('Email',
                    style:TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize:15
                    )
                    ),
        
                    TextFormField(
                     validator: (value) {
                     if (value == null || value.isEmpty) {
                     return 'Please enter email';
                     } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
                    return 'Please enter a valid email address';
                     }
                       return null;
                      },
                      controller: _emailController,
                      cursorColor: Color.fromARGB(133, 255, 255, 255),
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(112, 255, 255, 255)
                        )
                        ),
                           focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(112, 255, 255, 255),
                          ),
                        ),
                          fillColor: Color.fromARGB(73, 70, 95, 119),
                          filled: true,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Password',
                    style:TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize:15
                    )
                    ),
                      TextFormField(
                        validator: (value) {
                        if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                   } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*[0-9!@#$%^&*()_+{}|:;<>,.?~\\-]).+$').hasMatch(value)) {
                   return 'Password must contain a number or a special character';
                    }
                   return null;
                    },
                       obscureText: true, 
                        controller: _passwordController,
                      cursorColor: Color.fromARGB(133, 255, 255, 255),
                      decoration: const InputDecoration(
                        hintText: 'Enter your password',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(133, 255, 255, 255)
                        )
                        ),
                           focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(112, 255, 255, 255),
                          ),
                        ),
                        fillColor: Color.fromARGB(73, 70, 95, 119),
                        filled: true,
                        ),
                      ),
                      SizedBox(height: 10),
                  Text('Branch',
                  style:TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize:15
                  )
                  ),
                   DropdownButtonFormField<String>(
                    value: selectedBranch,
                    onChanged: (value) {
                    setState(() {
                        selectedBranch = value!;
                      });
                    },
                    items: branchOptions.keys.map((newValue) {
                      return DropdownMenuItem<String>(
                        value: newValue,
                        child: Text(newValue),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == 'Select Branch') {
                        return 'Please select your branch';
                      }
                      return null;
                    },
                      decoration: const InputDecoration(
                        hintText: 'Select your branch',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(133, 255, 255, 255)
                        )
                        ),
                           focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(112, 255, 255, 255),
                          ),
                        ),
                        fillColor: Color.fromARGB(73, 70, 95, 119),
                        filled: true,
                        ),
                      ),
                      SizedBox(height: 40),
                      InkWell(
                        onTap: () {
                         if( _formKey.currentState!.validate())
                        context.replace(SignInScreen.routeName);
                        
                        },
                        child: Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondaryContainer
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: Text('Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                            ))),
                        ),
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
