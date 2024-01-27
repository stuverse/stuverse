import 'package:flutter/material.dart';
import 'package:stuverse/app/utils/app_images.dart';
import 'package:stuverse/features/common/core/core.dart';

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BgGradient(
        child: Center(
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
                    backgroundImage: AssetImage(AppImages.logo),
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
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person_2_outlined,
                        size: 20,
                        color: Color.fromARGB(255, 150, 150, 150),
                      ),
                      labelText: 'Name',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 78, 77, 77),
                          width: 0,
                        ),
                      ),
                      hintText: 'Full Name',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        size: 20,
                        color: Color.fromARGB(255, 150, 150, 150),
                      ),
                      labelText: 'Email',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 78, 77, 77),
                          width: 0,
                        ),
                      ),
                      hintText: 'Enter your email',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.phone_android_rounded,
                        size: 20,
                        color: Color.fromARGB(255, 150, 150, 150),
                      ),
                      labelText: 'Phone',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 78, 77, 77),
                          width: 0,
                        ),
                      ),
                      hintText: 'Phone number',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.location_on_outlined,
                          size: 20,
                          color: Color.fromARGB(255, 150, 150, 150),
                        ),
                        labelText: 'Branch',
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
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        size: 20,
                        color: Color.fromARGB(255, 150, 150, 150),
                      ),
                      labelText: 'Password',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 78, 77, 77),
                          width: 0,
                        ),
                      ),
                      hintText: 'Password...',
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FilledButton(
                    onPressed: () {},
                    child: Center(
                      child: Text(
                        'Sign Up',
                      ),
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
