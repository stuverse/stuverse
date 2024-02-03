import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stuverse',
                  style: context.headlineLarge!.copyWith(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                10.heightBox,
                Text(
                  'Welcome to Stuverse!',
                  style: context.headlineMedium!.copyWith(
                    color: context.colorScheme.onBackground,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: context.colorScheme.background,
            ),
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              context.go('/profile');
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              context.go('/settings');
            },
          ),
          ListTile(
            title: const Text('Sign Out'),
            onTap: () {
              context.go(CommonRoutes.signin);
              context.read<CoreCubit>().signOut();
            },
          ),
        ],
      ),
    );
  }
}
