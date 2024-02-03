import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stuverse/app/app.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({
    super.key,
    required this.hasNotification,
    required this.onPressed,
  });
  final bool hasNotification;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Stack(
        children: [
          SvgPicture.asset(
            AppImages.bellSVG,
            colorFilter: ColorFilter.mode(
                context.colorScheme.onBackground, BlendMode.srcIn),
            height: 20,
          ),
          if (hasNotification)
            Positioned(
              right: 0,
              top: -2,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: context.colorScheme.error,
                  shape: BoxShape.circle,
                ),
                constraints: BoxConstraints(
                  minWidth: 10,
                  minHeight: 10,
                ),
              ),
            ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
