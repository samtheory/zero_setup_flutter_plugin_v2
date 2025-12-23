import 'package:app_test_plugin/app/app.dart';
import 'package:app_test_plugin/core/logger/logger_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(observers: [talkerRiverpodObserver], child: const App()));
}
