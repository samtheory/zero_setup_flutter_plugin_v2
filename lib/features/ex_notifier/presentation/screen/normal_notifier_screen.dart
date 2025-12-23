import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/application.dart';
import '../../domain/domain.dart';
import '../widgets/widgets.dart';

class NormalNotifierScreen extends HookConsumerWidget {
  const NormalNotifierScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskListProvider);
    final filteredTasks = taskState.filteredTasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          // Clear completed tasks button
          if (taskState.getCountByStatus(TaskStatus.done) > 0)
            IconButton(
              onPressed: () => _showClearCompletedDialog(context, ref),
              icon: const Icon(Icons.cleaning_services),
              tooltip: 'Clear completed tasks',
            ),
        ],
      ),
      body: Column(
        children: [
          // Filter bar at the top
          const TaskFilterBar(),
          const Divider(height: 1),

          // Task list
          Expanded(
            child: filteredTasks.isEmpty
                ? _buildEmptyState(taskState.selectedFilter)
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return TaskListItem(task: task);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAddTaskDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
      ),
    );
  }

  Widget _buildEmptyState(TaskFilter filter) {
    final (icon, message) = switch (filter) {
      TaskFilter.all => (Icons.task_alt, 'No tasks yet.\nTap the button below to add one!'),
      TaskFilter.todo => (Icons.inbox, 'No pending tasks.\nGreat job staying on top of things!'),
      TaskFilter.inProgress => (Icons.pending_actions, 'No tasks in progress.\nStart working on something!'),
      TaskFilter.done => (Icons.celebration, 'No completed tasks yet.\nFinish a task to see it here!'),
    };

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  void _showClearCompletedDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Completed Tasks'),
        content: const Text('Are you sure you want to remove all completed tasks? This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              ref.read(taskListProvider.notifier).clearCompletedTasks();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Completed tasks cleared'), behavior: SnackBarBehavior.floating),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}
