import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants/func_help.dart';
import '../../../model/task_model.dart';
import 'package:http/http.dart' as http;

import '../../../router/router_app.dart';
import '../../task/screen/task_screen.dart';

final updateTaskRepositoryProvider = Provider<UpdateTaskRepository>((ref) {
  return UpdateTaskRepository();
});

class UpdateTaskRepository {
  Future<TaskModel> getTask(int id) async {
    String url = 'http://192.168.1.12/api/todo/tasks/$id';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final task = jsonDecode(response.body);
      print(task);
      return TaskModel.fromJson(task);
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<void> updateTask(
      int id, TaskModel task, BuildContext context, bool mounted) async {
    try {
      showLoadingDialog(context, 'Update Task');

      String url = 'http://192.168.1.12/api/todo/tasks/$id';
      Map<String, dynamic> data = {
        "title": task.title,
        "description": task.description,
        "dateTime": task.dateTime.toString().split(' ')[0],
        "complete": task.complete
      };
      final response = await http.put(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));

      if (response.statusCode == 200) {
        if (!mounted) return;
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: "Update Task Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16.0);
        RouteApp.push(widget: const TaskScreen(), context: context);
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    }
  }
}
