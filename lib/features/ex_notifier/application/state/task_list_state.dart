import 'package:flutter/foundation.dart';

import '../../domain/domain.dart';

/// State class for the task list feature
@immutable
class TaskListState {
  final List<TaskEntity> tasks;
  final TaskFilter selectedFilter;
  final bool isLoading;
  final String? errorMessage;

  const TaskListState({
    this.tasks = const [],
    this.selectedFilter = TaskFilter.all,
    this.isLoading = false,
    this.errorMessage,
  });

  /// Initial state with some sample tasks
  factory TaskListState.initial() {
    return TaskListState(
      tasks: [
        TaskEntity(
          id: '1',
          title: 'Learn Riverpod',
          description: 'Study NotifierProvider and state management',
          status: TaskStatus.done,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          completedAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        TaskEntity(
          id: '2',
          title: 'Build Todo App',
          description: 'Create a todo app with DDD structure',
          status: TaskStatus.inProgress,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        TaskEntity(
          id: '3',
          title: 'Write Unit Tests',
          description: 'Add comprehensive unit tests',
          status: TaskStatus.todo,
          createdAt: DateTime.now(),
        ),
        TaskEntity(
          id: '4',
          title: 'Setup CI/CD',
          description: 'Configure continuous integration pipeline',
          status: TaskStatus.todo,
          createdAt: DateTime.now(),
        ),
      ],
    );
  }

  /// Get filtered tasks based on selected filter
  List<TaskEntity> get filteredTasks {
    final statusFilter = selectedFilter.toTaskStatus();
    if (statusFilter == null) return tasks;
    return tasks.where((task) => task.status == statusFilter).toList();
  }

  /// Get count of tasks by status
  int getCountByStatus(TaskStatus status) {
    return tasks.where((task) => task.status == status).length;
  }

  /// Get total task count
  int get totalCount => tasks.length;

  TaskListState copyWith({List<TaskEntity>? tasks, TaskFilter? selectedFilter, bool? isLoading, String? errorMessage}) {
    return TaskListState(
      tasks: tasks ?? this.tasks,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TaskListState &&
        listEquals(other.tasks, tasks) &&
        other.selectedFilter == selectedFilter &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return Object.hash(Object.hashAll(tasks), selectedFilter, isLoading, errorMessage);
  }
}
