import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_api/constants/coloors.dart';
import 'package:todo_api/constants/theme_app.dart';
import 'package:todo_api/features/add_task/screen/add_task_screen.dart';
import 'package:todo_api/features/task/controller/task_controller.dart';
import 'package:todo_api/features/update_task/screen/update_task_screen.dart';
import 'package:todo_api/router/router_app.dart';
import 'package:todo_api/widgets/task_item.dart';

import '../../../model/task_model.dart';

class TaskScreen extends ConsumerStatefulWidget {
  const TaskScreen({super.key});

  @override
  ConsumerState<TaskScreen> createState() => _TaskScreenState();
}


class _TaskScreenState extends ConsumerState<TaskScreen> {
  @override
  void initState() {
     Future.delayed(Duration.zero,(){
      ref.invalidate(getAllTaskProvider);
     });
    super.initState();
  }
   @override
  void didChangeDependencies() {
    Future.delayed(Duration.zero,(){
      ref.invalidate(getAllTaskProvider);
     });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Switch.adaptive(
          value:
              ref.watch(themeAppProvide.notifier).eThemeApp == EThemeApp.dark,
          onChanged: (value) {
            ref.read(themeAppProvide.notifier).changeTheme();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Daily Task',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Coloors.greenColors),
            child: Row(
              children: [
                const Icon(Icons.check),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Complete',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          
          Expanded(child: ref.watch(getAllTaskProvider).when(data: (tasks) {
              return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    RouteApp.push(widget: UpdateTaskScreen(task: tasks[index]), context: context);
                  },
                  child: TaskItem(taskModel: tasks[index]));
              },
            );
          }, error: (error, stackTrace) => Text(error.toString()), loading: () => const CircularProgressIndicator(),))
        ]),
      ),
      floatingActionButton:FloatingActionButton(onPressed: (){
        RouteApp.push(widget: AddTaskScreen(), context: context);
      },child:const Icon(Icons.add)) ,
    );
  }
}
