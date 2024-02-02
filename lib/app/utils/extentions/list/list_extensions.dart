part of '../app_extensions.dart';

extension ListExtn on List<Widget> {
  AnimateList defaultListAnimation({
    Duration? interval,
    Duration? duration,
    Duration? delay,
    Offset? begin,
    Color? shimmerColor,
  }) =>
      this
          .animate(interval: interval ?? 50.ms)
          .fadeIn(duration: duration ?? 500.ms, delay: 100.ms)
          .shimmer(color: shimmerColor ?? Colors.white12)
          .move(begin: begin ?? Offset(0, -16), curve: Curves.easeOutQuad);

  AnimateList defaultHorzListAnimation({
    Duration? interval,
    Duration? duration,
    Duration? delay,
    Offset? begin,
    Color? shimmerColor,
  }) =>
      this
          .animate(interval: interval ?? 100.ms)
          .fadeIn(duration: duration ?? 600.ms, delay: 200.ms)
          .shimmer(color: shimmerColor ?? Colors.white12)
          .move(begin: begin ?? Offset(-16, 0), curve: Curves.easeOutQuad);
}
