import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Theme config for FlexColorScheme version 7.3.x. Make sure you use
// same or higher package version, but still same major version. If you
// use a lower package version, some properties may not be supported.
// In that case remove them after copying this theme to your app.

  static final lightTheme = FlexThemeData.light(
    colors: _flexSchemeLight,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 7,
    transparentStatusBar: false,
    appBarElevation: 2.5,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      thinBorderWidth: 0.5,
      defaultRadius: 9,
      textButtonRadius: 9,
      textButtonSchemeColor: SchemeColor.secondaryContainer,
      filledButtonRadius: 9,
      elevatedButtonRadius: 9,
      outlinedButtonRadius: 9,
      outlinedButtonBorderWidth: 0.5,
      outlinedButtonPressedBorderWidth: 1.5,
      toggleButtonsRadius: 9,
      toggleButtonsBorderWidth: 0.5,
      segmentedButtonRadius: 9,
      segmentedButtonBorderWidth: 0.5,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    // To use the Playground font, add GoogleFonts package and uncomment
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  );

  static final darkTheme = FlexThemeData.dark(
    colors: _flexSchemeDark,
    scaffoldBackground: Colors.black,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 5,
    transparentStatusBar: false,
    appBarElevation: 3,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      blendTextTheme: true,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      defaultRadius: 9,
      thinBorderWidth: 0.5,
      textButtonRadius: 9,
      filledButtonRadius: 9,
      elevatedButtonRadius: 9,
      outlinedButtonRadius: 9,
      outlinedButtonBorderWidth: 0.5,
      outlinedButtonPressedBorderWidth: 1.5,
      toggleButtonsRadius: 9,
      toggleButtonsBorderWidth: 0.5,
      segmentedButtonRadius: 9,
      segmentedButtonBorderWidth: 0.5,
      inputDecoratorSchemeColor: SchemeColor.tertiary,

      inputDecoratorBorderSchemeColor: SchemeColor.primary,
      inputCursorSchemeColor: SchemeColor.onTertiary,
      // inputDecoratorIsFilled: false,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
      appBarBackgroundSchemeColor: SchemeColor.shadow,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    // To use the Playground font, add GoogleFonts package and uncomment
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  );

// Light and dark ColorSchemes made by FlexColorScheme v7.3.1.
// These ColorScheme objects require Flutter 3.7 or later.
  static const _flexSchemeLight = FlexSchemeColor(
    primary: Color(0xff1d72c6),
    primaryContainer: Color(0xff00172d),
    secondary: Color(0xfffac595),
    secondaryContainer: Color(0xff0052a2),
    tertiary: Color(0xff00264d),
    tertiaryContainer: Color(0xffebd9da),
    appBarColor: Color(0xff0052a2),
    error: Color(0xffb00020),
  );

  static const _flexSchemeDark = FlexSchemeColor(
    primary: Color(0xff4e8ecd),
    primaryContainer: Color(0xff001d34),
    secondary: Color(0xfffabf93),
    secondaryContainer: Color(0xFF8EC8F5),
    tertiary: Color(0xff000b18),
    tertiaryContainer: Color(0xffaf676b),
    appBarColor: Color(0xff002d4d),
    error: Color(0xffcf6679),
  );

  static final darkBackgroundGradient = LinearGradient(
    colors: [
      _flexSchemeDark.tertiary,
      _flexSchemeDark.tertiary.withOpacity(0.5),
    ],
    stops: const [0.25, 0.75],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
