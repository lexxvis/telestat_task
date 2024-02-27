import 'package:flutter/material.dart';

class ErrorLogger {
  void logError(FlutterErrorDetails flutterErrorDetails) {
    FlutterError.dumpErrorToConsole(flutterErrorDetails);
    // must be remote logger implementation
  }

  void log(Object data, StackTrace stackTrace) {
    print('error data $data');
    print(stackTrace);
    // must be remote logger implementation
  }
}