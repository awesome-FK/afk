import 'package:flutter/foundation.dart';

typedef AppErrorHandler = void Function(FlutterErrorDetails details);

class AppErrorReporter {
  AppErrorReporter({AppErrorHandler? handler})
    : _handler = handler ?? FlutterError.presentError;

  final AppErrorHandler _handler;

  void install() {
    FlutterError.onError = report;
    PlatformDispatcher
        .instance
        .onError = (Object error, StackTrace stackTrace) {
      report(
        FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
          library: 'app',
          context: ErrorDescription('An uncaught asynchronous error occurred.'),
        ),
      );
      return true;
    };
  }

  void report(FlutterErrorDetails details) => _handler(details);
}
