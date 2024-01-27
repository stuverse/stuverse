import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'signup_screen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});
  static const String routeName = '/signin';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  final _formKey=GlobalKey<FormState>();
  bool _obscureText=true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Container(
          width:double.infinity,
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
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset('assets/app/logo/stuverse.png',
                    height: 250,
                    width: 250,
                    ),
                  ),
                   Text(
                    'Welcome to StuVerse!',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
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
                     obscureText: _obscureText, 
                    controller: _passwordController,
                    cursorColor: Color.fromARGB(133, 255, 255, 255),
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      suffixIcon: GestureDetector(
                        onTap: () {
                        setState(() {
                          _obscureText =!_obscureText;
                        });
                        },
                        child: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                        )
                      ),
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
                    
                    SizedBox(height: 5),
                  TextButton(onPressed: (){}, child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('Forgot password?',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize:15
                    ),
                    ),
                  )),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: () {
                    _formKey.currentState!.validate();
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
                      child: Center(child: Text('Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                      ))
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                      
                      ),
                      TextButton(
                        onPressed: () {
                          context.replace(SignUpScreen.routeName);
                        },
                        child: Text('Sign Up',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary
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
