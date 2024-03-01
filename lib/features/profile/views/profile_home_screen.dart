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
              radius: 60,
              backgroundImage: NetworkImage(user?.image ?? ""),
            ),
            20.heightBox,
            Text(user?.name ?? "", style: context.headlineMedium),
            6.heightBox,
            Text(user?.email ?? "", style: context.titleMedium),
            50.heightBox,
            Container(
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ProfileTile(
                      title: "Edit Profile",
                      iconData: Icons.person,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                    ProfileTile(
                        title: "My stats",
                        iconData: Icons.circle_notifications_sharp,
                        color:
                            Theme.of(context).colorScheme.secondaryContainer),
                    ProfileTile(
                      title: "Settings",
                      iconData: Icons.settings,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Divider(
                      thickness: 6,
                    ),
                    10.heightBox,
                    ProfileTile(
                      title: "Logout",
                      iconData: Icons.logout,
                      color: Theme.of(context).colorScheme.error,
                    )
                  ],
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
      required this.color});
  final String title;
  final Color color;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(iconData, color: color),
        ),
        20.widthBox,
        Text(title, style: context.titleLarge),
        Spacer(),
        Icon(
          Icons.chevron_right_rounded,
        )
      ],
    );
  }
}
