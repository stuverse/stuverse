import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    colorScheme: _flexSchemeLight,
    useMaterial3: true,
  );

  static final darkTheme = ThemeData(
    colorScheme: _flexSchemeDark,
    useMaterial3: true,
  );

// Light and dark ColorSchemes made by FlexColorScheme v7.3.1.
// These ColorScheme objects require Flutter 3.7 or later.
  static const ColorScheme _flexSchemeLight = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff0052a2),
    onPrimary: Color(0xffffffff),
    primaryContainer: Color(0xff00172d),
    onPrimaryContainer: Color(0xffeff1f2),
    secondary: Color(0xfffac595),
    onSecondary: Color(0xff000000),
    secondaryContainer: Color(0xfffcdbbd),
    onSecondaryContainer: Color(0xff141210),
    tertiary: Color(0xff00264d),
    onTertiary: Color(0xffffffff),
    tertiaryContainer: Color(0xffebd9da),
    onTertiaryContainer: Color(0xff141212),
    error: Color(0xffb00020),
    onError: Color(0xffffffff),
    errorContainer: Color(0xfffcd8df),
    onErrorContainer: Color(0xff141213),
    background: Color(0xfff8fafc),
    onBackground: Color(0xff090909),
    surface: Color(0xfff8fafc),
    onSurface: Color(0xff090909),
    surfaceVariant: Color(0xffe0e5e9),
    onSurfaceVariant: Color(0xff111112),
    outline: Color(0xff7c7c7c),
    outlineVariant: Color(0xffc8c8c8),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xff101214),
    onInverseSurface: Color(0xfff5f5f5),
    inversePrimary: Color(0xff99d0ff),
    surfaceTint: Color(0xff0052a2),
  );

  static const ColorScheme _flexSchemeDark = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xff0052a2),
    onPrimary: Color(0xffeff5fb),
    primaryContainer: Color(0xff00172d),
    onPrimaryContainer: Color(0xffdfe3e6),
    secondary: Color(0xfffabf93),
    onSecondary: Color(0xff14120f),
    secondaryContainer: Color(0xff465f77),
    onSecondaryContainer: Color(0xffeaeef2),
    tertiary: Color(0xff000b18),
    onTertiary: Color(0xffefeff0),
    tertiaryContainer: Color(0xffaf676b),
    onTertiaryContainer: Color(0xfffbeff0),
    error: Color(0xffcf6679),
    onError: Color(0xff140c0d),
    errorContainer: Color(0xffb1384e),
    onErrorContainer: Color(0xfffbe8ec),
    background: Color(0xff101213),
    onBackground: Color(0xffececec),
    surface: Color(0xff101213),
    onSurface: Color(0xffececec),
    surfaceVariant: Color(0xff303336),
    onSurfaceVariant: Color(0xffdedfdf),
    outline: Color(0xff797979),
    outlineVariant: Color(0xff2d2d2d),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xfffafbfd),
    onInverseSurface: Color(0xff131313),
    inversePrimary: Color(0xff0e3051),
    surfaceTint: Color(0xff0052a2),
  );

  static final backgroundGradient = LinearGradient(
    colors: [_flexSchemeDark.tertiary, _flexSchemeDark.primaryContainer],
    stops: const [0.25, 0.75],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
