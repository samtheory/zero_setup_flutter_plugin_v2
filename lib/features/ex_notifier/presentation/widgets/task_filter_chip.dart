import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/application.dart';
import '../../domain/domain.dart';

/// Filter chip widget for task status filtering
class TaskFilterChip extends ConsumerWidget {
  final TaskFilter filter;

  const TaskFilterChip({super.key, required this.filter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(taskListProvider.select((state) => state.selectedFilter));
    final taskState = ref.watch(taskListProvider);
    final isSelected = selectedFilter == filter;

    // Get count for the filter
    final count = switch (filter) {
      TaskFilter.all => taskState.totalCount,
      TaskFilter.todo => taskState.getCountByStatus(TaskStatus.todo),
      TaskFilter.inProgress => taskState.getCountByStatus(TaskStatus.inProgress),
      TaskFilter.done => taskState.getCountByStatus(TaskStatus.done),
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        selected: isSelected,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(filter.label),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.2)
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
        onSelected: (_) {
          ref.read(taskListProvider.notifier).setFilter(filter);
        },
        selectedColor: Theme.of(context).colorScheme.primary,
        checkmarkColor: Theme.of(context).colorScheme.onPrimary,
        labelStyle: TextStyle(
          color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
