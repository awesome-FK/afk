import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../design_system/components/afk_button.dart';
import '../design_system/foundations/spacing/afk_spacing.dart';
import '../localization/app_localizations.dart';
import 'app_router.dart';

class RouteErrorScreen extends StatelessWidget {
  const RouteErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AfkSpacing.xxxl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  l10n.notFoundTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: AfkSpacing.sm),
                Text(
                  l10n.notFoundBody,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: AfkSpacing.xxl),
                AfkButton(
                  label: l10n.backHome,
                  onPressed: () => context.go(AppRoutePaths.home),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
