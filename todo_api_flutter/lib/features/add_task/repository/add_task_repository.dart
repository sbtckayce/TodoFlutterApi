import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todo_api/constants/func_help.dart';
import 'package:todo_api/features/task/screen/task_screen.dart';
import 'package:todo_api/model/task_model.dart';
import 'package:http/http.dart' as http;
import 'package:todo_api/router/router_app.dart';

final addTaskRepositoryProvider =
    Provider<AddTaskRepository>((ref) => AddTaskRepository());

class AddTaskRepository {
  Future<void> addTask(
      TaskModel task, BuildContext context, bool mounted) async {
    try {
  String url = 'http://192.168.1.12/api/todo/task';
      showLoadingDialog(context, 'Add Task');
      Map<String, dynamic> data = {
        "title": task.title,
        "description": task.description,
        "dateTime": task.dateTime.toString().split(' ')[0],
        "complete": task.complete
      };
      final response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
      
      if (response.statusCode == 200) {
        if (!mounted) return;
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: "Add Task Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16.0);
        RouteApp.push(widget:const TaskScreen(), context: context);
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
       Navigator.of(context).pop();
    }
  }
}
