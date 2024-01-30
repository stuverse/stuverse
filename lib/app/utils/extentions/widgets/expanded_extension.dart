part of '../app_extensions.dart';

extension ExpandedExtension on Widget {
  Expanded expanded({int flex = 1}) => Expanded(
        flex: flex,
        child: this,
      );
}
