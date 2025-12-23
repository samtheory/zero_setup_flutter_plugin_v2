import 'package:app_test_plugin/app/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class RootScreen extends HookConsumerWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Root Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This is the Root Screen'),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () => context.go(Routes.home), child: const Text('Go to Home')),
          ],
        ),
      ),
    );
  }
}
