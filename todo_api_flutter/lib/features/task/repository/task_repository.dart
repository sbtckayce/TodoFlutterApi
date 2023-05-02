import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_api/features/task/controller/task_controller.dart';
import 'package:todo_api/model/task_model.dart';
import 'package:http/http.dart' as http;

final taskRepositoryProvider =
    Provider<TaskRepository>((ref) => TaskRepository());

class TaskRepository {
  Future<List<TaskModel>> getAllTask() async {
    String url = 'http://192.168.1.12/api/todo/tasks';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(response.body);

      return result.map((e) => TaskModel.fromJson(e)).toList();
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<void> deleteTask(int id,ProviderRef ref) async {
    String url = 'http://192.168.1.12/api/todo/tasks/$id';
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Delete Task Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: 16.0);
      ref.invalidate(getAllTaskProvider);
    } else {
      throw Exception(response.statusCode);
    }
  }
}
