import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'app_configuration.dart';
import 'app_error_reporter.dart';

void bootstrap({required AppConfiguration configuration}) {
  WidgetsFlutterBinding.ensureInitialized();
  const AppErrorReporter()
      .install();
  runApp(
    ProviderScope(
      overrides: [
        appConfigurationProvider
            .overrideWithValue(configuration),
      ],
      child: const AppRoot(),
    ),
  );
}
