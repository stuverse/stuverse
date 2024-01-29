import 'package:flutter/material.dart';
import 'package:stuverse/app/app.dart';

class BgGradient extends StatelessWidget {
  const BgGradient({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // 100%
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkBackgroundGradient
            : null,
        color: Theme.of(context).brightness == Brightness.light
            ? Theme.of(context).colorScheme.background
            : null,
      ),
      child: child,
    );
  }
}
