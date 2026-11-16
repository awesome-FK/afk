import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'app_error_reporter.dart';

void bootstrap() {
  WidgetsFlutterBinding.ensureInitialized();
  const AppErrorReporter().install();
  runApp(const ProviderScope(child: AfkApp()));
}
