import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NormalNotifierScreen extends HookConsumerWidget {
  const NormalNotifierScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Normal Notifier Screen')),
      body: const Center(child: Text('This is the Normal Notifier Screen')),
    );
  }
}
