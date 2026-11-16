import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/app_configuration.dart';
import '../../../app/app_preferences.dart';
import '../../../design_system/components/afk_segmented_control.dart';
import '../../../design_system/foundations/spacing/afk_spacing.dart';
import '../../../design_system/theme/afk_theme_colors.dart';
import '../../../localization/app_localizations.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<AppPreferences> preferencesAsync = ref.watch(
      appPreferencesProvider,
    );
    final AppPreferences preferences = preferencesAsync.when(
      data: (AppPreferences value) => value,
      error: (Object error, StackTrace stackTrace) => const AppPreferences(),
      loading: () => const AppPreferences(),
    );
    final bool preferencesReady = preferencesAsync.hasValue;
    final ThemeMode themeMode = preferences.themeMode;
    final Locale locale = preferences.locale;
    final AfkThemeColors colors = AfkThemeColors.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AfkSpacing.xxl,
            AfkSpacing.xxxl,
            AfkSpacing.xxl,
            AfkSpacing.xxl,
          ),
          children: <Widget>[
            Text(
              ref.watch(appConfigurationProvider).identity.displayName,
              style: Theme.of(context).textTheme.labelLarge
                  ?.copyWith(letterSpacing: 3.2, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AfkSpacing.section),
            Text(
              l10n.welcome(ref.watch(appConfigurationProvider).identity.displayName),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AfkSpacing.sm),
            Text(
              l10n.foundationLabel,
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(color: colors.secondaryText),
            ),
            const SizedBox(height: AfkSpacing.section),
            _PreferenceSection(
              title: l10n.appearance,
              value: _themeLabel(l10n, themeMode),
              child: AfkSegmentedControl<ThemeMode>(
                value: themeMode,
                enabled: preferencesReady,
                options: <AfkSegmentOption<ThemeMode>>[
                  AfkSegmentOption(value: ThemeMode.system, label: l10n.system),
                  AfkSegmentOption(value: ThemeMode.light, label: l10n.light),
                  AfkSegmentOption(value: ThemeMode.dark, label: l10n.dark),
                ],
                onChanged: (ThemeMode value) => ref
                    .read(appPreferencesProvider.notifier)
                    .setThemeMode(value),
              ),
            ),
            _PreferenceSection(
              title: l10n.language,
              value: locale.languageCode == 'ar' ? l10n.arabic : l10n.english,
              child: AfkSegmentedControl<String>(
                value: locale.languageCode,
                enabled: preferencesReady,
                options: <AfkSegmentOption<String>>[
                  AfkSegmentOption(value: 'en', label: l10n.english),
                  AfkSegmentOption(value: 'ar', label: l10n.arabic),
                ],
                onChanged: (String value) => ref
                    .read(appPreferencesProvider.notifier)
                    .setLocale(Locale(value)),
              ),
            ),
            const SizedBox(height: AfkSpacing.xxxl),
            Text(
              'FOUNDATION  /  0.1.0',
              style: Theme.of(context).textTheme.labelSmall
                  ?.copyWith(letterSpacing: 1.4),
            ),
          ],
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
    required this.child,
  });

  final String title;
  final String value;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final AfkThemeColors colors = AfkThemeColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AfkSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(value, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: AfkSpacing.md),
          child,
          const SizedBox(height: AfkSpacing.lg),
          Divider(height: 1, color: colors.border),
        ],
      ),
    );
  }
}
