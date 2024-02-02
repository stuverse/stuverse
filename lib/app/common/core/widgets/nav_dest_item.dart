import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stuverse/app/app.dart';

class NavDestItem extends StatelessWidget {
  const NavDestItem({
    super.key,
    required this.label,
    required this.svgPath,
  });
  final String label;
  final String svgPath;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      label: label,
      icon: SvgPicture.asset(
        svgPath,
        colorFilter: ColorFilter.mode(
          context.colorScheme.onBackground,
          BlendMode.srcIn,
        ),
      ),
      selectedIcon: SvgPicture.asset(
        svgPath,
        colorFilter: ColorFilter.mode(
          context.colorScheme.onSecondaryContainer,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
