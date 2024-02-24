import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';

class ProfileHomeScreen extends StatelessWidget {
  const ProfileHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<CoreCubit>().state.user;
    return Scaffold(
        body: BgGradient(
      child: SafeArea(
        child: Column(
          children: [
            20.heightBox,
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user?.image ?? ""),
            ),
            20.heightBox,
            Text(user?.name ?? "", style: context.headlineMedium),
            10.heightBox,
            Text(user?.email ?? "", style: context.headlineSmall),
            20.heightBox,
            ElevatedButton(
              onPressed: () {
                // context.go(ProfileRoutes.editProfile);
              },
              child: Text("Edit Profile"),
            ),
            20.heightBox,
            ElevatedButton(
              onPressed: () {
                context.read<CoreCubit>().signOut();
              },
              child: Text("Sign Out"),
            ),
          ],
        ),
      ),
    ));
  }
}
