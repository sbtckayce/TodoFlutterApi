import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_api/features/task/repository/task_repository.dart';
import 'package:todo_api/model/task_model.dart';
final taskControllerProvider = Provider<TaskController>((ref) => TaskController(taskRepository: ref.watch(taskRepositoryProvider),ref: ref));

final getAllTaskProvider = FutureProvider<List<TaskModel>>((ref) {
  final taskController = ref.watch(taskControllerProvider);
  return taskController.getAllTask();
});
class TaskController {
  final TaskRepository _taskRepository;
  final ProviderRef _ref;
  TaskController({required TaskRepository taskRepository , required ProviderRef ref}):_taskRepository =taskRepository,_ref=ref;

  Future<List<TaskModel>> getAllTask()async{
    return await _taskRepository.getAllTask();
  }
  Future<void> deleteTask(int id)async{
    return await _taskRepository.deleteTask(id,_ref);
  }
}