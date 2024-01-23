import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const Placeholder(),
      themeMode: ThemeMode.light,
    );
  }
}
