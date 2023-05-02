import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_api/features/task/repository/task_repository.dart';
import 'package:todo_api/model/task_model.dart';

import '../repository/add_task_repository.dart';
final addTaskControllerProvider = Provider<AddTaskController>((ref) => AddTaskController(addTaskRepository: ref.watch(addTaskRepositoryProvider)));


class AddTaskController {
  final AddTaskRepository _addTaskRepository;

  AddTaskController({required AddTaskRepository addTaskRepository}):_addTaskRepository =addTaskRepository;

  Future<void> addTask(TaskModel task,BuildContext context,bool mounted)async {
   await  _addTaskRepository.addTask(task,context,mounted);
  }
}