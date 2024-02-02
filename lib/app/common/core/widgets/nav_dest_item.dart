import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stuverse/app/app.dart';

class NavDestItem extends StatelessWidget {
  const NavDestItem({
    super.key,
    required this.label,
    required this.regularSvgPath,
    required this.solidSvgPath,
  });
  final String label;
  final String regularSvgPath;
  final String solidSvgPath;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      label: label,
      icon: SvgPicture.asset(
        regularSvgPath,
        colorFilter: ColorFilter.mode(
          context.colorScheme.onBackground.withOpacity(0.7),
          BlendMode.srcIn,
        ),
      ),
      selectedIcon: SvgPicture.asset(
        solidSvgPath,
        colorFilter: ColorFilter.mode(
          context.colorScheme.secondaryContainer,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
