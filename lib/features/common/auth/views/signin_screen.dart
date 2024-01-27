import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'signup_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  static const String routeName = '/signin';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/app/logo/stuverse.png',
                height: 100,
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 8,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.robotoSerif(
                      color: const Color.fromARGB(255, 172, 172, 172)),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      size: 20,
                      color: Color.fromARGB(255, 150, 150, 150),
                    ),
                    labelText: 'Username',
                    labelStyle: GoogleFonts.robotoSerif(
                      color: Color.fromARGB(255, 150, 150, 150),
                    ),
                    floatingLabelStyle: GoogleFonts.robotoSerif(
                      color: Colors.white,
                    ),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 78, 77, 77),
                          width: 0,
                        )),
                    hintText: 'Email or Phone number',
                    hintStyle: GoogleFonts.robotoSerif(
                      color: Color.fromARGB(255, 150, 150, 150),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 8,
                ),
                child: TextFormField(
                  obscureText: true,
                  obscuringCharacter: '*',
                  style: GoogleFonts.robotoSerif(
                      color: const Color.fromARGB(255, 172, 172, 172)),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 20,
                      color: Color.fromARGB(255, 150, 150, 150),
                    ),
                    labelText: 'Password',
                    labelStyle: GoogleFonts.robotoSerif(
                      color: Color.fromARGB(255, 150, 150, 150),
                    ),
                    floatingLabelStyle: GoogleFonts.robotoSerif(
                      color: Colors.white,
                    ),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 78, 77, 77),
                          width: 0,
                        )),
                    hintText: 'Password...',
                    hintStyle: GoogleFonts.robotoSerif(
                      color: Color.fromARGB(255, 150, 150, 150),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text('Forgot Password?',
                            style: GoogleFonts.robotoSerif(
                              color: Colors.white,
                              fontSize: 10,
                            ))),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  child: Center(
                      child: Text('Sign In',
                          style: GoogleFonts.robotoSerif(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ))),
                ),
              ),
              // SizedBox(
              //   height: 50,
              // ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Don't have an account?",
                    style: GoogleFonts.robotoSerif(
                      color: Colors.white,
                      fontSize: 10,
                    )),
                TextButton(
                    onPressed: () {
                      context.replace(SignUpScreen.routeName);
                    },
                    child: Text('sign up',
                        style: GoogleFonts.robotoSerif(
                          color: Colors.white,
                          fontSize: 10,
                        ))),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
