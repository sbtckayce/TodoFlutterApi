import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_api/features/update_task/repository/update_task_repository.dart';
import 'package:todo_api/model/task_model.dart';

final updateTaskControllerProvider = Provider<UpdateTaskController>((ref) {
  return UpdateTaskController(
      updateTaskRepository: ref.watch(updateTaskRepositoryProvider));
});

class UpdateTaskController {
  final UpdateTaskRepository _updateTaskRepository;

  UpdateTaskController({required UpdateTaskRepository updateTaskRepository})
      : _updateTaskRepository = updateTaskRepository;

  Future<TaskModel> getTask(int id) async {
    return await _updateTaskRepository.getTask(id);
  }

  Future updateTask(int id, TaskModel task,BuildContext context,bool mounted) async {
    await _updateTaskRepository.updateTask(id, task,context,mounted);
  }
}
