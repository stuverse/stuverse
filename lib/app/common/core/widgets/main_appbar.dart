import 'package:flutter/material.dart';
import 'package:stuverse/app/app.dart';

AppBar getMainAppbar({
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    title: Image.asset(
      AppImages.logoGlow,
      width: 90,
    ),
    centerTitle: true,
    actions: [
      if (actions != null) ...actions,
      // NotificationIcon(
      //   hasNotification: false,
      //   onPressed: () {},
      // ),
      // Padding(
      //   padding: const EdgeInsets.only(
      //     top: 7,
      //   ),
      //   child: IconButton(
      //     onPressed: () {
      //       context.showMessage(
      //           message: "Notifications will be available soon");
      //     },
      //     icon: SvgPicture.asset(
      //       AppImages.bellSVG,
      //       height: 20,
      //       colorFilter: ColorFilter.mode(
      //         context.colorScheme.onBackground,
      //         BlendMode.srcIn,
      //       ),
      //     ),
      //   ),
      // )
    ],
  );
}
