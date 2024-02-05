part of '../app_extensions.dart';

const defaultPaddingFactor = 0.05;

extension PaddingExtension on BuildContext {
  //Return EdgeInset all ,symmetrical ,only with default padding factor with respect to screen size
  EdgeInsets get paddingAll => EdgeInsets.all(minSize * defaultPaddingFactor);
  EdgeInsets get paddingSymmetric => EdgeInsets.symmetric(
      horizontal: width * defaultPaddingFactor,
      vertical: height * defaultPaddingFactor);

  EdgeInsets get paddingHorz => EdgeInsets.symmetric(
        horizontal: width * defaultPaddingFactor,
      );

  EdgeInsets get paddingHorzWithTop => EdgeInsets.only(
        left: width * defaultPaddingFactor,
        right: width * defaultPaddingFactor,
        top: 10,
      );

  //now functions
  EdgeInsets paddingAllWith(double factor) => EdgeInsets.all(minSize * factor);
  EdgeInsets paddingSymmetricWith(double factor) => EdgeInsets.symmetric(
      horizontal: width * factor, vertical: height * factor);
  EdgeInsets paddingHorzWith(double factor) => EdgeInsets.symmetric(
        horizontal: width * factor,
      );
  EdgeInsets paddingHorzWithVertical({
    double? factor,
    double? top,
    double? bottom,
  }) =>
      EdgeInsets.only(
        left: width * (factor ?? defaultPaddingFactor),
        right: width * (factor ?? defaultPaddingFactor),
        top: top ?? 0,
        bottom: bottom ?? 0,
      );
  EdgeInsets paddingOnlyWith(
          {double? left, double? right, double? top, double? bottom}) =>
      EdgeInsets.only(
          left: left ?? 0,
          right: right ?? 0,
          top: top ?? 0,
          bottom: bottom ?? 0);
}
