import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
            Stack(
              children: [
                CircleAvatar(
                  radius: 65,
                  backgroundImage: NetworkImage(user?.image ?? ""),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        child: Icon(
                          Icons.edit,
                          size: 20,
                        )))
              ],
            ),
            10.heightBox,
            Text(user?.name ?? "", style: context.headlineSmall),
            Text(user?.email ?? "",
                style: context.titleMedium!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.7))),
            30.heightBox,
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ProfileTile(
                          title: "Edit Profile",
                          iconData: Icons.person,
                          color:
                              Theme.of(context).colorScheme.tertiaryContainer,
                          onTap: () {}),
                      10.heightBox,
                      ProfileTile(
                          title: "My stats",
                          iconData: Icons.circle_notifications_sharp,
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          onTap: () {}),
                      10.heightBox,
                      ProfileTile(
                          title: "Settings",
                          iconData: Icons.settings,
                          color: Theme.of(context).colorScheme.secondary,
                          onTap: () {}),
                      10.heightBox,
                      Divider(
                        thickness: 5,
                      ),
                      10.heightBox,
                      ProfileTile(
                        title: "Logout",
                        iconData: Icons.logout,
                        color: Theme.of(context).colorScheme.error,
                        onTap: () {
                          context.go(CommonRoutes.signin);
                          context.read<CoreCubit>().signOut();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile(
      {super.key,
      required this.title,
      required this.iconData,
      required this.color,
      required this.onTap});
  final String title;
  final Color color;
  final IconData iconData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(iconData, color: color),
          ),
          20.widthBox,
          Text(title, style: context.titleMedium),
          Spacer(),
          Icon(
            Icons.chevron_right_rounded,
          )
        ],
      ),
    );
  }
}
