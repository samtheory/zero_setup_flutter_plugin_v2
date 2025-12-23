import 'package:app_test_plugin/core/logger/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Home')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _Welcome(),

            //custom ScrollView with sliverFillRemaining
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to testing screen or add new feature
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _Welcome extends StatelessWidget {
  const _Welcome();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(Icons.home, size: 80, color: Colors.indigo),
        SizedBox(height: 10),
        Text('Welcome to the App!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

        SizedBox(height: 2),
        Text(
          'This is the home screen feature example.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
