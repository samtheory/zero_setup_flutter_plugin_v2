import 'package:flutter/material.dart';

import '../../domain/domain.dart';
import 'task_filter_chip.dart';

/// Horizontal filter bar showing all task filters
class TaskFilterBar extends StatelessWidget {
  const TaskFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(children: TaskFilter.values.map((filter) => TaskFilterChip(filter: filter)).toList()),
      ),
    );
  }
}
