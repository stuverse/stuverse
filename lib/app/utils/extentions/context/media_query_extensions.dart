part of '../app_extensions.dart';

extension MediaQueryExt on BuildContext {
  /// The same of MediaQuery.sizeOf(context)
  Size get mqSize => MediaQuery.sizeOf(this);

  /// The same of MediaQuery.sizeOf(context).height
  double get height => mqSize.height;

  /// The same of [MediaQuery.sizeOf(context).width]
  /// Note: updates when you rezise your screen (like on a browser or
  /// desktop window)
  double get width => mqSize.width;

  double get minSize {
    if (width > height) {
      return height;
    } else {
      return width;
    }
  }

  /// similar to [ MediaQuery.paddingOf(context)]
  EdgeInsets get padding => MediaQuery.paddingOf(this);

  /// similar to [MediaQuery.viewPaddingOf(context)]
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);

  /// similar to [MediaQuery.viewInsetsOf(context)]
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  /// similar to [MediaQuery.orientationOf(context)]
  Orientation get orientation => MediaQuery.orientationOf(this);

  /// similar to [MediaQuery.alwaysUse24HourFormatOf(context)]
  bool get alwaysUse24HourFormat => MediaQuery.alwaysUse24HourFormatOf(this);

  /// similar to [MediaQuery.devicePixelRatioOf(context)]
  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(this);

  /// similar to [MediaQuery.platformBrightnessOf(context)]
  Brightness get platformBrightness => MediaQuery.platformBrightnessOf(this);

  /// similar to [MediaQuery.textScaleFactorOf(context)]
  TextScaler get textScaleFactor => MediaQuery.textScalerOf(this);

  /// check if device is on landscape mode
  bool get isLandscape => orientation == Orientation.landscape;

  /// check if device is on portrait mode
  bool get isPortrait => orientation == Orientation.portrait;

  /// get the shortestSide from screen
  double get mediaQueryShortestSide => mqSize.shortestSide;

  /// True if width be larger than 800
  bool get showNavbar => (width > 800);

  /// True if the shortestSide is smaller than 600p
  bool get isPhone => (mediaQueryShortestSide < 600);

  /// True if the shortestSide is largest than 600p
  bool get isSmallTablet => (mediaQueryShortestSide >= 600);

  /// True if the shortestSide is largest than 720p
  bool get isLargeTablet => (mediaQueryShortestSide >= 720);

  /// True if the current device is Tablet
  bool get isTablet => isSmallTablet || isLargeTablet;

  /// Returns a specific value according to the screen size
  /// if the device width is higher than or equal to 1200 return
  /// [desktop] value. if the device width is higher than  or equal to 600
  /// and less than 1200 return [tablet] value.
  /// if the device width is less than 300  return [watch] value.
  /// in other cases return [mobile] value.
  T? responsiveValue<T>({
    T? mobile,
    T? tablet,
    T? desktop,
  }) {
    var deviceWidth = mqSize.shortestSide;
    if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      deviceWidth = mqSize.width;
    }
    if (deviceWidth >= 1200 && desktop != null) return desktop;
    if (deviceWidth >= 600 && tablet != null) return tablet;
    return mobile;
  }
}
