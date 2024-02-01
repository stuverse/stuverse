import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';

class MentorHomeScreen extends StatelessWidget {
  const MentorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<CoreCubit>().state.user;
    return SafeArea(
      child: Center(
        child: Text(
          "Hi ${user?.name ?? ""}! Welcome to Mentor Module",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
