import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/domain.dart';
import '../state/task_list_state.dart';

/// Notifier for managing task list state
class TaskListNotifier extends Notifier<TaskListState> {
  @override
  TaskListState build() {
    return TaskListState.initial();
  }

  /// Change the selected filter
  void setFilter(TaskFilter filter) {
    state = state.copyWith(selectedFilter: filter);
  }

  /// Add a new task
  void addTask({required String title, String? description}) {
    final newTask = TaskEntity.create(title: title, description: description);
    state = state.copyWith(tasks: [...state.tasks, newTask]);
  }

  /// Update an existing task
  void updateTask({required String taskId, String? title, String? description, TaskStatus? status}) {
    final updatedTasks = state.tasks.map((task) {
      if (task.id == taskId) {
        return task.copyWith(
          title: title,
          description: description,
          status: status,
          completedAt: status == TaskStatus.done ? DateTime.now() : null,
        );
      }
      return task;
    }).toList();
    state = state.copyWith(tasks: updatedTasks);
  }

  /// Delete a task
  void deleteTask(String taskId) {
    final updatedTasks = state.tasks.where((task) => task.id != taskId).toList();
    state = state.copyWith(tasks: updatedTasks);
  }

  /// Mark task as done (for swipe action)
  void markTaskAsDone(String taskId) {
    final updatedTasks = state.tasks.map((task) {
      if (task.id == taskId) {
        return task.markAsDone();
      }
      return task;
    }).toList();
    state = state.copyWith(tasks: updatedTasks);
  }

  /// Move task to next status
  void moveTaskToNextStatus(String taskId) {
    final updatedTasks = state.tasks.map((task) {
      if (task.id == taskId) {
        return task.moveToNextStatus();
      }
      return task;
    }).toList();
    state = state.copyWith(tasks: updatedTasks);
  }

  /// Change task status
  void changeTaskStatus(String taskId, TaskStatus newStatus) {
    updateTask(taskId: taskId, status: newStatus);
  }

  /// Clear all completed tasks
  void clearCompletedTasks() {
    final updatedTasks = state.tasks.where((task) => task.status != TaskStatus.done).toList();
    state = state.copyWith(tasks: updatedTasks);
  }
}

/// Provider for TaskListNotifier
final taskListProvider = NotifierProvider<TaskListNotifier, TaskListState>(TaskListNotifier.new);
