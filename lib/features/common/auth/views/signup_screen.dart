import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final _productList = ['CSE', 'IT', 'ECE', 'EEE', 'CE', 'ME'];
String? selectedValue;

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        leading: IconButton(
            onPressed: () => context.replace(SignInScreen.routeName),
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(
            20,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/app/logo/stuverse.png'),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: 40,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    child: Center(
                      child: Text(
                        'Change Photo',
                        style: GoogleFonts.robotoSerif(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  style: GoogleFonts.robotoSerif(
                    color: const Color.fromARGB(255, 172, 172, 172),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person_2_outlined,
                      size: 20,
                      color: Color.fromARGB(255, 150, 150, 150),
                    ),
                    labelText: 'Name',
                    labelStyle: GoogleFonts.robotoSerif(
                      color: const Color.fromARGB(255, 150, 150, 150),
                    ),
                    floatingLabelStyle: GoogleFonts.robotoSerif(
                      color: Colors.white,
                    ),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 78, 77, 77),
                        width: 0,
                      ),
                    ),
                    hintText: 'Full Name',
                    hintStyle: GoogleFonts.robotoSerif(
                      color: const Color.fromARGB(255, 150, 150, 150),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.robotoSerif(
                    color: const Color.fromARGB(255, 172, 172, 172),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      size: 20,
                      color: Color.fromARGB(255, 150, 150, 150),
                    ),
                    labelText: 'Email',
                    labelStyle: GoogleFonts.robotoSerif(
                      color: const Color.fromARGB(255, 150, 150, 150),
                    ),
                    floatingLabelStyle: GoogleFonts.robotoSerif(
                      color: Colors.white,
                    ),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 78, 77, 77),
                        width: 0,
                      ),
                    ),
                    hintText: 'Enter your email',
                    hintStyle: GoogleFonts.robotoSerif(
                      color: const Color.fromARGB(255, 150, 150, 150),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.robotoSerif(
                    color: const Color.fromARGB(255, 172, 172, 172),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.phone_android_rounded,
                      size: 20,
                      color: Color.fromARGB(255, 150, 150, 150),
                    ),
                    labelText: 'Phone',
                    labelStyle: GoogleFonts.robotoSerif(
                      color: const Color.fromARGB(255, 150, 150, 150),
                    ),
                    floatingLabelStyle: GoogleFonts.robotoSerif(
                      color: Colors.white,
                    ),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 78, 77, 77),
                        width: 0,
                      ),
                    ),
                    hintText: 'Phone number',
                    hintStyle: GoogleFonts.robotoSerif(
                      color: const Color.fromARGB(255, 150, 150, 150),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                    style: GoogleFonts.robotoSerif(
                      color: const Color.fromARGB(255, 172, 172, 172),
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.location_on_outlined,
                        size: 20,
                        color: Color.fromARGB(255, 150, 150, 150),
                      ),
                      labelText: 'Branch',
                      labelStyle: GoogleFonts.robotoSerif(
                        color: const Color.fromARGB(255, 150, 150, 150),
                      ),
                      floatingLabelStyle: GoogleFonts.robotoSerif(
                        color: Colors.white,
                      ),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 78, 77, 77),
                          width: 0,
                        ),
                      ),
                    ),
                    value: selectedValue,
                    items: _productList
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedValue = val as String;
                      });
                    }),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  obscuringCharacter: '*',
                  style: GoogleFonts.robotoSerif(
                    color: const Color.fromARGB(255, 172, 172, 172),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      size: 20,
                      color: Color.fromARGB(255, 150, 150, 150),
                    ),
                    labelText: 'Password',
                    labelStyle: GoogleFonts.robotoSerif(
                      color: const Color.fromARGB(255, 150, 150, 150),
                    ),
                    floatingLabelStyle: GoogleFonts.robotoSerif(
                      color: Colors.white,
                    ),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 78, 77, 77),
                        width: 0,
                      ),
                    ),
                    hintText: 'Password...',
                    hintStyle: GoogleFonts.robotoSerif(
                      color: const Color.fromARGB(255, 150, 150, 150),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.robotoSerif(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
