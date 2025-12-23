import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RootScreen extends HookConsumerWidget {
  const RootScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Root Screen')),
      body: const Center(child: Text('This is the Root Screen')),
    );
  }
}
