import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_api/constants/coloors.dart';
import 'package:todo_api/features/task/controller/task_controller.dart';
import 'package:todo_api/model/task_model.dart';

class TaskItem extends ConsumerWidget {
  const TaskItem({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      height: 80,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Coloors.pinkColors),
      child: Row(
      children: [
        Checkbox(value: taskModel.complete

       , onChanged: (value) {
         
       },),
       Expanded(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(taskModel.title,style: Theme.of(context).textTheme.titleMedium!.copyWith( decoration:taskModel.complete ? TextDecoration.lineThrough : TextDecoration.none),),
        const Spacer(),
        Text(taskModel.description,style: Theme.of(context).textTheme.titleMedium!.copyWith( decoration:taskModel.complete ? TextDecoration.lineThrough : TextDecoration.none),),
        const Spacer(),
        Text(DateFormat().add_yMEd().format(taskModel.dateTime),style: Theme.of(context).textTheme.titleSmall!.copyWith( decoration:taskModel.complete ? TextDecoration.lineThrough : TextDecoration.none),)
       ],)),
       IconButton(onPressed: (){
        ref.read(taskControllerProvider).deleteTask(taskModel.id!);
       }, icon:const Icon(Icons.delete))
      ],
      ),
    );
  }
}