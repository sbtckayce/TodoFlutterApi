import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:todo_api/constants/coloors.dart';
import 'package:todo_api/constants/func_help.dart';
import 'package:todo_api/features/add_task/controller/add_task_controller.dart';
import 'package:todo_api/features/task/controller/task_controller.dart';
import 'package:todo_api/model/task_model.dart';
import 'package:todo_api/widgets/widgets.dart';

import '../../../router/router_app.dart';
import '../../task/screen/task_screen.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _dateController = TextEditingController(text: DateFormat().add_yMEd().format(DateTime.now()));

  DateTime? _dateEnd;

  Future<void> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await _showDatePicker(context, initialDate);
    if (newDate != null) {
      setState(() {
        _dateEnd = newDate;
        final date = DateFormat().add_yMEd().format(newDate);
        _dateController.text = date;
      });
    }
  }

  Future<DateTime?> _showDatePicker(
      BuildContext context, DateTime initialDate) {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 1),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    CustomTextField(
                      hintText: 'Enter Title',
                      title: 'Title',
                      controller: _titleController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      hintText: 'Enter Description',
                      title: 'Description',
                      controller: _descriptionController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      hintText: 'Enter Date',
                      title: 'Date',
                      readOnly: true,
                      controller: _dateController,
                      icon: IconButton(
                          onPressed: () {
                            pickDate(context);
                          },
                          icon: const Icon(
                            Icons.date_range_outlined,
                            color: Coloors.greenColors,
                          )),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Coloors.greenColors,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            minimumSize: const Size(double.infinity, 50)),
                        child: TextButton(
                            onPressed: () {
                              final validation = vaildationAdd(
                                  _titleController.text,
                                  _descriptionController.text,
                                  _dateEnd ?? DateTime.now());
                              if (validation) {
                                TaskModel task = TaskModel(
                                    title: _titleController.text,
                                    description: _descriptionController.text,
                                    dateTime: _dateEnd ?? DateTime.now());
    
                                ref.read(addTaskControllerProvider).addTask(task,context,true);
                                
                              }
                            },
                            child: Text(
                              'ADD TASK',
                              style: Theme.of(context).textTheme.titleMedium,
                            )))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
