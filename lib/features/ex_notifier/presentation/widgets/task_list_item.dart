import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/application.dart';
import '../../domain/domain.dart';

/// A single task item with swipe actions
class TaskListItem extends ConsumerWidget {
  final TaskEntity task;
  final VoidCallback? onTap;

  const TaskListItem({
    super.key,
    required this.task,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
 final notifier = ref.watch(taskListProvider.notifier);
    return Dismissible(
      key: Key(task.id),
      direction: task.status == TaskStatus.done
          ? DismissDirection.endToStart // Only delete if done
          : DismissDirection.horizontal, // Swipe both ways
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // Swipe right to mark as done
          ref.read(taskListProvider.notifier).markTaskAsDone(task.id);
          return false; // Don't dismiss, just update status
        } else {
          // Swipe left to delete
          return await _showDeleteConfirmation(context);
        }
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          ref.read(taskListProvider.notifier).deleteTask(task.id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Task "${task.title}" deleted'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  // Could implement undo functionality
                },
              ),
            ),
          );
        }
      },
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        color: Colors.green,
        child: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Mark Done',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.delete, color: Colors.white),
          ],
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          leading: _buildStatusIcon(task.status, colorScheme),
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.status == TaskStatus.done
                  ? TextDecoration.lineThrough
                  : null,
              color: task.status == TaskStatus.done
                  ? colorScheme.onSurface.withValues(alpha: 0.5)
                  : null,
            ),
          ),
          subtitle: task.description != null
              ? Text(
                  task.description!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                  ),
                )
              : null,
          trailing: _buildStatusChip(task.status, context),
          onTap: onTap ?? () => _showTaskDetails(context, ref, task),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(TaskStatus status, ColorScheme colorScheme) {
    final (icon, color) = switch (status) {
      TaskStatus.todo => (Icons.radio_button_unchecked, colorScheme.outline),
      TaskStatus.inProgress => (Icons.pending, colorScheme.primary),
      TaskStatus.done => (Icons.check_circle, Colors.green),
    };

    return Icon(icon, color: color);
  }

  Widget _buildStatusChip(TaskStatus status, BuildContext context) {
    final (color, bgColor) = switch (status) {
      TaskStatus.todo => (
          Colors.grey.shade700,
          Colors.grey.shade200,
        ),
      TaskStatus.inProgress => (
          Colors.blue.shade700,
          Colors.blue.shade100,
        ),
      TaskStatus.done => (
          Colors.green.shade700,
          Colors.green.shade100,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Future<bool> _showDeleteConfirmation(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Task'),
            content: Text('Are you sure you want to delete "${task.title}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _showTaskDetails(BuildContext context, WidgetRef ref, TaskEntity task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => TaskDetailSheet(task: task),
    );
  }
}

/// Bottom sheet showing task details with edit options
class TaskDetailSheet extends ConsumerWidget {
  final TaskEntity task;

  const TaskDetailSheet({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showEditDialog(context, ref);
                },
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (task.description != null) ...[
            Text(
              task.description!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
          ],
          const Divider(),
          const SizedBox(height: 16),
          Text(
            'Change Status',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: TaskStatus.values.map((status) {
              final isSelected = task.status == status;
              return ChoiceChip(
                label: Text(status.label),
                selected: isSelected,
                onSelected: (_) {
                  ref.read(taskListProvider.notifier).changeTaskStatus(
                        task.id,
                        status,
                      );
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Created: ${_formatDate(task.createdAt)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (task.completedAt != null)
                Text(
                  'Completed: ${_formatDate(task.completedAt!)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showEditDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController(text: task.title);
    final descController = TextEditingController(text: task.description);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              ref.read(taskListProvider.notifier).updateTask(
                    taskId: task.id,
                    title: titleController.text,
                    description: descController.text.isEmpty
                        ? null
                        : descController.text,
                  );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
