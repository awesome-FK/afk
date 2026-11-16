import 'package:flutter/material.dart';

import '../foundations/motion/afk_motion.dart';
import '../foundations/radius/afk_radius.dart';
import '../foundations/spacing/afk_spacing.dart';
import '../theme/afk_theme_colors.dart';

enum AfkButtonVariant { primary, secondary, quiet }

enum AfkButtonSize { small, medium, large }

class AfkButton extends StatelessWidget {
  const AfkButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.variant = AfkButtonVariant.primary,
    this.size = AfkButtonSize.medium,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AfkButtonVariant variant;
  final AfkButtonSize size;
  final Widget? leading;
  final Widget? trailing;
  final bool isLoading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final AfkThemeColors colors = AfkThemeColors.of(context);
    final bool enabled = onPressed != null && !isLoading;
    final bool primary = variant == AfkButtonVariant.primary;
    final bool quiet = variant == AfkButtonVariant.quiet;
    final Color background = primary
        ? colors.primaryText
        : quiet
            ? const Color(0x00000000)
            : colors.surface;
    final Color foreground = primary
        ? colors.inverseSurface
        : enabled
            ? colors.primaryText
            : colors.disabled;
    final EdgeInsetsGeometry padding = switch (size) {
      AfkButtonSize.small => const EdgeInsets.symmetric(
          horizontal: AfkSpacing.md,
          vertical: AfkSpacing.sm,
        ),
      AfkButtonSize.medium => const EdgeInsets.symmetric(
          horizontal: AfkSpacing.xl,
          vertical: AfkSpacing.md,
        ),
      AfkButtonSize.large => const EdgeInsets.symmetric(
          horizontal: AfkSpacing.xxl,
          vertical: AfkSpacing.lg,
        ),
    };
    final double minHeight = switch (size) {
      AfkButtonSize.small => 36,
      AfkButtonSize.medium => 44,
      AfkButtonSize.large => 52,
    };

    final Widget button = AnimatedOpacity(
      duration: MediaQuery.of(context).disableAnimations
          ? AfkMotion.instant
          : AfkMotion.fast,
      opacity: enabled ? 1 : 0.48,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(AfkRadius.md),
        child: InkWell(
          onTap: enabled ? onPressed : null,
          borderRadius: BorderRadius.circular(AfkRadius.md),
          child: Container(
            constraints: BoxConstraints(minHeight: minHeight),
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AfkRadius.md),
              border: primary || quiet
                  ? null
                  : Border.all(color: colors.border),
            ),
            child: Row(
              mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (isLoading)
                  SizedBox.square(
                    dimension: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: foreground,
                    ),
                  )
                else if (leading != null)
                  IconTheme(
                    data: IconThemeData(color: foreground, size: 18),
                    child: leading!,
                  ),
                if (isLoading || leading != null)
                  const SizedBox(width: AfkSpacing.sm),
                Flexible(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: foreground,
                        ),
                  ),
                ),
                if (trailing != null) ...<Widget>[
                  const SizedBox(width: AfkSpacing.sm),
                  IconTheme(
                    data: IconThemeData(color: foreground, size: 18),
                    child: trailing!,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );

    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      child: expand ? SizedBox(width: double.infinity, child: button) : button,
    );
  }
}
