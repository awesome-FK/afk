import 'package:afk/app/app_error_reporter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('forwards framework and platform errors to the configured handler', () {
    final List<FlutterErrorDetails> reported = <FlutterErrorDetails>[];
    final FlutterExceptionHandler? previousFlutterHandler =
        FlutterError.onError;
    final bool Function(Object, StackTrace)? previousPlatformHandler =
        PlatformDispatcher.instance.onError;
    addTearDown(() {
      FlutterError.onError = previousFlutterHandler;
      PlatformDispatcher.instance.onError = previousPlatformHandler;
    });

    AppErrorReporter(handler: reported.add).install();

    final FlutterErrorDetails frameworkError = FlutterErrorDetails(
      exception: StateError('framework failure'),
    );
    FlutterError.onError!(frameworkError);

    final StateError platformException = StateError('platform failure');
    final StackTrace platformStack = StackTrace.current;
    final bool handled = PlatformDispatcher.instance.onError!(
      platformException,
      platformStack,
    );

    expect(handled, isTrue);
    expect(reported, hasLength(2));
    expect(reported.first, same(frameworkError));
    expect(reported.last.exception, same(platformException));
    expect(reported.last.stack, same(platformStack));
  });
}
