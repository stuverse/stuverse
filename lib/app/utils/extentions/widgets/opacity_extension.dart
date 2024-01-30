part of '../app_extensions.dart';

extension OpacityExtension on Widget {
  Opacity setOpacity({required double opacity}) => Opacity(
        opacity: opacity,
        child: this,
      );
}
