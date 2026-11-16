import 'package:flutter/widgets.dart';

import '../foundations/radius/afk_radius.dart';
import '../foundations/spacing/afk_spacing.dart';
import '../theme/afk_theme_colors.dart';

class AfkSurface extends StatelessWidget {
  const AfkSurface({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(AfkSpacing.lg),
    this.radius = AfkRadius.lg,
    this.border = true,
    this.backgroundColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final bool border;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final AfkThemeColors colors = AfkThemeColors.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.surface,
        borderRadius: BorderRadius.circular(radius),
        border: border ? Border.all(color: colors.border) : null,
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}
