import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';

import '../cubit/delete_account/delete_account_cubit.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final TextEditingController _passwordController = TextEditingController();
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
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Enter your password",
                    border: const OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                30.heightBox,
                BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
                  listener: (context, state) {
                    if (state is DeleteAccountSuccess) {
                      context.go(CommonRoutes.signin);
                      context.read<CoreCubit>().signOut();
                      context.showMessage(
                          message:
                              "Your account has been deleted successfully. Thank you for using our app.",
                          duration: 5.seconds);
                    }
                    if (state is DeleteAccountError) {
                      context.showErrorMessage(message: state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is DeleteAccountLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Enter your password"),
                            ),
                          );
                          return;
                        }
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                                "Are you sure you want to delete your account?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel"),
                              ),
                              FilledButton(
                                style: FilledButton.styleFrom(
                                  backgroundColor: context.colorScheme.error,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  context
                                      .read<DeleteAccountCubit>()
                                      .deleteAccount(
                                          password: _passwordController.text);
                                },
                                child: Text("Delete",
                                style: context.bodyMedium!.copyWith(
                                  color: context.colorScheme.onError
                                ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text("Delete Account",
                      style: context.bodyMedium!.copyWith(
                                  color: context.colorScheme.onError
                                ),
),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: Theme.of(context).colorScheme.error,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        textStyle: context.bodyMedium!.copyWith(
                                  color: context.colorScheme.onError
                                ),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
