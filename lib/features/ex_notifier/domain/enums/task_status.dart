/// Represents the status of a task
enum TaskStatus {
  todo('Todo'),
  inProgress('In Progress'),
  done('Done');

  final String label;
  const TaskStatus(this.label);
}

/// Filter type for task list including "All" option
enum TaskFilter {
  all('All'),
  todo('Todo'),
  inProgress('In Progress'),
  done('Done');

  final String label;
  const TaskFilter(this.label);

  /// Convert filter to corresponding TaskStatus (null for all)
  TaskStatus? toTaskStatus() {
    return switch (this) {
      TaskFilter.all => null,
      TaskFilter.todo => TaskStatus.todo,
      TaskFilter.inProgress => TaskStatus.inProgress,
      TaskFilter.done => TaskStatus.done,
    };
  }
}
