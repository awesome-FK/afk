import 'package:flutter/material.dart';

import '../foundations/motion/afk_motion.dart';
import '../foundations/radius/afk_radius.dart';
import '../foundations/spacing/afk_spacing.dart';
import '../theme/afk_theme_colors.dart';

class AfkSegmentOption<T> {
  const AfkSegmentOption({required this.value, required this.label});

  final T value;
  final String label;
}

class AfkSegmentedControl<T> extends StatelessWidget {
  const AfkSegmentedControl({
    required this.value,
    required this.options,
    required this.onChanged,
    super.key,
    this.expand = true,
  });

  final T value;
  final List<AfkSegmentOption<T>> options;
  final ValueChanged<T> onChanged;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final AfkThemeColors colors = AfkThemeColors.of(context);
    final bool reduceMotion = MediaQuery.of(context).disableAnimations;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceRaised,
        borderRadius: BorderRadius.circular(AfkRadius.md),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AfkSpacing.xxs),
        child: Row(
          mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
          children: <Widget>[
            for (final AfkSegmentOption<T> option in options)
              if (expand)
                Expanded(child: _segment(context, colors, option, reduceMotion))
              else
                _segment(context, colors, option, reduceMotion),
          ],
        ),
      ),
    );
  }

  Widget _segment(
    BuildContext context,
    AfkThemeColors colors,
    AfkSegmentOption<T> option,
    bool reduceMotion,
  ) {
    final bool selected = option.value == value;
    return Semantics(
      button: true,
      selected: selected,
      inMutuallyExclusiveGroup: true,
      child: AnimatedContainer(
        duration: reduceMotion ? AfkMotion.instant : AfkMotion.fast,
        curve: AfkMotion.standardCurve,
        decoration: BoxDecoration(
          color: selected ? colors.inverseSurface : Colors.transparent,
          borderRadius: BorderRadius.circular(AfkRadius.sm),
        ),
        child: InkWell(
          onTap: selected ? null : () => onChanged(option.value),
          borderRadius: BorderRadius.circular(AfkRadius.sm),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AfkSpacing.sm,
              vertical: AfkSpacing.md,
            ),
            child: Center(
              child: Text(
                option.label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: selected ? colors.surface : colors.secondaryText,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
