import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';

class FundHomeScreen extends StatelessWidget {
  const FundHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<CoreCubit>().state.user;
    return SafeArea(
      child: Center(
        child: Text(
          "Hi ${user?.name ?? ""}! Welcome to Fund Module",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
