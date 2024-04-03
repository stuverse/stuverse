part of '../app_extensions.dart';

extension SnackBarExt on BuildContext {
  void showMessage({
    required String message,
    bool showIcon = true,
    IconData icon = Icons.info,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
    Color? foregroundColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    ShapeBorder? shape,
    SnackBarBehavior? behavior,
    Animation<double>? animation,
    void Function()? onVisible,
  }) {
    if (backgroundColor == null)
      backgroundColor = this.colorScheme.primaryContainer;
    if (foregroundColor == null)
      foregroundColor = this.colorScheme.onPrimaryContainer;
    ScaffoldMessenger.of(this)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          closeIconColor: foregroundColor,
          showCloseIcon: true,
          content: Row(
            children: [
              if (showIcon) Icon(icon, color: foregroundColor),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: foregroundColor),
                ),
              ),
            ],
          ),
          duration: duration,
          action: action,
          backgroundColor: backgroundColor,
          elevation: elevation,
          margin: margin,
          padding: padding,
          shape: shape,
          behavior: behavior,
          animation: animation,
          onVisible: onVisible,
        ),
      );
  }

  void showErrorMessage({
    required String message,
    bool showIcon = true,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 3),
  }) {
    showMessage(
      message: message,
      showIcon: showIcon,
      icon: Icons.error,
      foregroundColor: this.colorScheme.error,
      backgroundColor: this.colorScheme.onError,
      duration: duration,
      action: action,
    );
  }
}
