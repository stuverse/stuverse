import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/forum/forum.dart';

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
                Image.asset(
                  AppImages.logo,
                  height: context.height * 0.08,
                ),
                10.heightBox,
                Text(
                  'Welcome to Stuverse!',
                  style: context.headlineSmall!.copyWith(
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
            title: const Text('Manage Communities'),
            onTap: () {
              context.push(ForumRoutes.communityManage);
            },
          ),
          ListTile(
            title: const Text("User Requests"),
            onTap: () {
              context.push(CommonRoutes.userRequest);
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
