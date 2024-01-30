// ignore_for_file: inference_failure_on_function_return_type

part of '../app_extensions.dart';

extension GestureDetectorExtensions on Widget {
  Widget onDoubleTap(Function() function) => GestureDetector(
        onDoubleTap: function,
        child: this,
      );

  Widget onTap(Function() function) => GestureDetector(
        onTap: function,
        child: this,
      );

  Widget onLongPress(Function() function) => GestureDetector(
        onLongPress: function,
        child: this,
      );
}
