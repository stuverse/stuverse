import 'package:flutter/material.dart';
import 'package:stuverse/app/app.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete This Account"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: Theme.of(context).colorScheme.error,
                ),
                15.widthBox,
                Text(
                  "If you delete this account:",
                  style: context.titleLarge!.copyWith(
                      fontSize: 20, color: Theme.of(context).colorScheme.error),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "- Your account will be deleted immediately from your device",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "- All  your threads  and posts will be deleted",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "- Any communities you joined will be deleted",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "- Deletes your fundraising information",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "- Your comments and added skills will be deleted",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                40.heightBox,
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "If  you want to delete your account enter your password.",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(),
                ),
                10.heightBox,
                TextField(
                  decoration: InputDecoration(
                    labelText: "Enter your password",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.remove_red_eye_rounded),
                    ),
                  ),
                ),
                30.heightBox,
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Delete Account",
                      style: context.titleLarge!.copyWith(
                        fontSize: 20,
                      )),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Theme.of(context).colorScheme.onError,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
