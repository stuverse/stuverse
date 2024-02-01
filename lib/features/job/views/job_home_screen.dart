import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';

class JobHomeScreen extends StatelessWidget {
  const JobHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<CoreCubit>().state.user;
    return SafeArea(
      child: Center(
        child: Text(
          "Hi ${user?.name ?? ""}! Welcome to Job Module",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
