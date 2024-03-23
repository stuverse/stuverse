import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse/app/app.dart';

import '../routes/profile_routes.dart';

class ProfileHomeScreen extends StatelessWidget {
  const ProfileHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final coreState = context.watch<CoreCubit>().state;
    final user = coreState.user;

    return Scaffold(
        body: BgGradient(
      child: SafeArea(
        child: Column(
          children: [
            20.heightBox,
            CircleAvatar(
              radius: 65,
              backgroundImage: CachedNetworkImageProvider(user?.image ?? ""),
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
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceVariant
                      .withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    ProfileTile(
                        title: "Edit Profile",
                        iconData: Icons.person,
                        color: context.limeM3Primary,
                        onTap: () {
                          context.push(ProfileRoutes.profileEdit);
                        }),
                    10.heightBox,
                    ProfileTile(
                        title: coreState.isDarkMode
                            ? "Change to Light Mode"
                            : "Change to Dark Mode",
                        iconData: coreState.isDarkMode
                            ? Icons.light_mode
                            : Icons.dark_mode,
                        color: context.bluePrimary,
                        onTap: () {
                          context.read<CoreCubit>().toggleTheme();
                        }),
                    10.heightBox,
                    ProfileTile(
                        title: "Settings",
                        iconData: Icons.settings,
                        color: context.goldPrimary,
                        onTap: () {
                          context.showMessage(
                              message:
                                  "Settings will be available in future updates");
                        }),
                    10.heightBox,
                    Divider(
                      thickness: 5,
                    ),
                    10.heightBox,
                    ProfileTile(
                      title: "Logout",
                      iconData: Icons.logout,
                      color: context.pinkM3Primary,
                      onTap: () {
                        context.go(CommonRoutes.signin);
                        context.read<CoreCubit>().signOut();
                      },
                    ),
                  ]),
                ),
              ),
            )
          ].defaultListAnimation(),
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
