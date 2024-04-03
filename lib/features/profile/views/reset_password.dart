import 'package:flutter/material.dart';
import 'package:stuverse/app/app.dart';

class ResetAccountPassword extends StatefulWidget {
  const ResetAccountPassword({super.key});

  @override
  State<ResetAccountPassword> createState() => _ResetAccountPasswordState();
}

class _ResetAccountPasswordState extends State<ResetAccountPassword>
    with SingleTickerProviderStateMixin {
  @override
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Reset Password",
                style: context.titleLarge!.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
            30.heightBox,
            Text(
              "Enter your new password  and this password should be different from your previous password.",
              style: context.bodyMedium,
            ),
            20.heightBox,
            TextField(
              decoration: InputDecoration(
                labelText: "New Password",
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.remove_red_eye_rounded),
                ),
              ),
            ),
            20.heightBox,
            TextField(
              decoration: InputDecoration(
                labelText: "Confirm Password",
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.remove_red_eye_rounded),
                ),
              ),
            ),
            50.heightBox,
            Center(
              child: FilledButton(
                onPressed: () {},
                child: Text("Reset Password",
                    style: context.titleLarge!.copyWith(
                      fontSize: 20,
                    )),
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
