import 'package:flutter/foundation.dart';

import '../enums/task_status.dart';

/// Task entity representing a single todo item
@immutable
class TaskEntity {
  final String id;
  final String title;
  final String? description;
  final TaskStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;

  const TaskEntity({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.createdAt,
    this.completedAt,
  });

  /// Create a new task with default values
  factory TaskEntity.create({required String title, String? description}) {
    return TaskEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      status: TaskStatus.todo,
      createdAt: DateTime.now(),
    );
  }

  /// Copy with method for immutability
  TaskEntity copyWith({
    String? id,
    String? title,
    String? description,
    TaskStatus? status,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  /// Mark task as done
  TaskEntity markAsDone() {
    return copyWith(status: TaskStatus.done, completedAt: DateTime.now());
  }

  /// Move task to next status
  TaskEntity moveToNextStatus() {
    final nextStatus = switch (status) {
      TaskStatus.todo => TaskStatus.inProgress,
      TaskStatus.inProgress => TaskStatus.done,
      TaskStatus.done => TaskStatus.done,
    };
    return copyWith(status: nextStatus, completedAt: nextStatus == TaskStatus.done ? DateTime.now() : null);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TaskEntity &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.completedAt == completedAt;
  }

  @override
  int get hashCode => Object.hash(id, title, description, status, createdAt, completedAt);

  @override
  String toString() {
    return 'TaskEntity(id: $id, title: $title, status: $status)';
  }
}
