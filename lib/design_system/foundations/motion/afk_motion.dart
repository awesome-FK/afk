import 'package:flutter/animation.dart';

abstract final class AfkMotion {
  static const Duration instant = Duration.zero;
  static const Duration fast = Duration(milliseconds: 120);
  static const Duration standard = Duration(milliseconds: 220);
  static const Duration deliberate = Duration(milliseconds: 320);

  static const Curve standardCurve = Curves.easeOutCubic;
  static const Curve enterCurve = Curves.easeOutQuart;
  static const Curve exitCurve = Curves.easeInCubic;
}
