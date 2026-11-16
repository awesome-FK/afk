import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app_preferences.dart';
import '../../../design_system/foundations/colors/afk_colors.dart';
import '../../../design_system/foundations/motion/afk_motion.dart';
import '../../../design_system/foundations/radius/afk_radius.dart';
import '../../../design_system/foundations/spacing/afk_spacing.dart';
import '../../../localization/app_localizations.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ThemeMode themeMode = ref.watch(themeModeProvider);
    final Locale locale = ref.watch(localeProvider);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color secondary =
        isDark ? AfkColors.darkMutedText : AfkColors.lightMutedText;
    final Color border =
        isDark ? AfkColors.darkBorder : AfkColors.lightBorder;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AfkSpacing.xxl,
            AfkSpacing.xxxl,
            AfkSpacing.xxl,
            AfkSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'AFK',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      letterSpacing: 3.2,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Spacer(),
              Text(
                l10n.welcome,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.8,
                    ),
              ),
              const SizedBox(height: AfkSpacing.sm),
              Text(
                l10n.foundationLabel,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: secondary,
                      height: 1.5,
                    ),
              ),
              const SizedBox(height: AfkSpacing.section),
              _PreferenceSection(
                title: l10n.appearance,
                value: _themeLabel(l10n, themeMode),
                border: border,
                child: _ChoiceRail<ThemeMode>(
                  selected: themeMode,
                  options: <_Choice<ThemeMode>>[
                    _Choice(value: ThemeMode.system, label: l10n.system),
                    _Choice(value: ThemeMode.light, label: l10n.light),
                    _Choice(value: ThemeMode.dark, label: l10n.dark),
                  ],
                  onSelected: (ThemeMode value) =>
                      ref.read(themeModeProvider.notifier).setMode(value),
                ),
              ),
              _PreferenceSection(
                title: l10n.language,
                value: locale.languageCode == 'ar' ? l10n.arabic : l10n.english,
                border: border,
                child: _ChoiceRail<String>(
                  selected: locale.languageCode,
                  options: <_Choice<String>>[
                    _Choice(value: 'en', label: l10n.english),
                    _Choice(value: 'ar', label: l10n.arabic),
                  ],
                  onSelected: (String value) => ref
                      .read(localeProvider.notifier)
                      .setLocale(Locale(value)),
                ),
              ),
              const Spacer(),
              Text(
                'FOUNDATION  /  0.1.0',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: secondary,
                      letterSpacing: 1.4,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _themeLabel(AppLocalizations l10n, ThemeMode mode) => switch (mode) {
        ThemeMode.system => l10n.system,
        ThemeMode.light => l10n.light,
        ThemeMode.dark => l10n.dark,
      };
}

class _PreferenceSection extends StatelessWidget {
  const _PreferenceSection({
    required this.title,
    required this.value,
    required this.border,
    required this.child,
  });

  final String title;
  final String value;
  final Color border;
  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: AfkSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Text(value, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: AfkSpacing.md),
            child,
            const SizedBox(height: AfkSpacing.lg),
            Divider(height: 1, color: border),
          ],
        ),
      );
}

class _Choice<T> {
  const _Choice({required this.value, required this.label});

  final T value;
  final String label;
}

class _ChoiceRail<T> extends StatelessWidget {
  const _ChoiceRail({
    required this.selected,
    required this.options,
    required this.onSelected,
  });

  final T selected;
  final List<_Choice<T>> options;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color selectedBackground =
        isDark ? AfkColors.neutral100 : AfkColors.neutral900;
    final Color selectedForeground =
        isDark ? AfkColors.neutral900 : AfkColors.white;
    final Color idleForeground =
        isDark ? AfkColors.darkMutedText : AfkColors.lightMutedText;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? AfkColors.darkSurface : AfkColors.neutral100,
        borderRadius: BorderRadius.circular(AfkRadius.md),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AfkSpacing.xxs),
        child: Row(
          children: <Widget>[
            for (final _Choice<T> option in options)
              Expanded(
                child: Semantics(
                  button: true,
                  selected: option.value == selected,
                  child: AnimatedContainer(
                    duration: AfkMotion.fast,
                    curve: AfkMotion.standardCurve,
                    decoration: BoxDecoration(
                      color: option.value == selected
                          ? selectedBackground
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(AfkRadius.sm),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(AfkRadius.sm),
                      onTap: () => onSelected(option.value),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AfkSpacing.sm,
                          vertical: AfkSpacing.md,
                        ),
                        child: Center(
                          child: Text(
                            option.label,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                              color: option.value == selected
                                  ? selectedForeground
                                  : idleForeground,
                              fontWeight: option.value == selected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
