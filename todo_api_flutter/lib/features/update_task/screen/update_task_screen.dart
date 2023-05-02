import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:todo_api/features/update_task/controller/update_task_controller.dart';

import '../../../constants/coloors.dart';
import '../../../constants/func_help.dart';
import '../../../model/task_model.dart';
import '../../../widgets/custom_text_field.dart';

class UpdateTaskScreen extends ConsumerStatefulWidget {
  const UpdateTaskScreen({super.key, required this.task});
  final TaskModel task;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends ConsumerState<UpdateTaskScreen> {
final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();
  bool isComplete =false;

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
  void initState() {
    _titleController.text = widget.task.title;
    _descriptionController.text =widget.task.description;
    _dateController.text=DateFormat().add_yMEd().format(widget.task.dateTime);
    isComplete=widget.task.complete;
    super.initState();
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
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text('Complete',style: Theme.of(context).textTheme.titleMedium,),
                        Checkbox(
                         
                          value: isComplete, onChanged: (value) {
                          setState(() {
                            isComplete=!isComplete;
                          });
                        },),
                      ],
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
                                  _dateEnd ?? DateTime.now(),
                                  );
                              if (validation) {
                                TaskModel task = TaskModel(
                                    title: _titleController.text,
                                    description: _descriptionController.text,
                                    dateTime: _dateEnd ?? DateTime.now(),
                                    complete: isComplete);
    
                                ref.read(updateTaskControllerProvider).updateTask(widget.task.id!, task,context,true);
                                
                              }
                            },
                            child: Text(
                              'Update Task',
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