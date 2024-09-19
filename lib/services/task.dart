import 'dart:convert';

import 'package:api_di/configs/backend_configs.dart';
import 'package:api_di/configs/endpoints.dart';
import 'package:http/http.dart' as http;

import '../models/task.dart';

class TaskServices {
  ///Create Task
  Future<bool> createTask(
      {required String description, required String token}) async {
    http.Response response = await http.post(
        Uri.parse(
          BackendConfigs.kBaseUrl + EndPoints.kAddTask,
        ),
        headers: {'Authorization': token},
        body: {'description': description});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  ///Get All Task
  Future<TaskModel> getAllTasks(String token) async {
    http.Response response = await http.get(
      Uri.parse(
        BackendConfigs.kBaseUrl + EndPoints.kGetAllTasks,
      ),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskModel.fromJson(jsonDecode(response.body));
    } else {
      return TaskModel();
    }
  }

  ///Get Completed Tasks
  Future<TaskModel> getCompletedTasks(String token) async {
    http.Response response = await http.get(
      Uri.parse(
        BackendConfigs.kBaseUrl + EndPoints.kGetCompletedTasks,
      ),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskModel.fromJson(jsonDecode(response.body));
    } else {
      return TaskModel();
    }
  }

  ///Get InCompleted Tasks
  Future<TaskModel> getInCompletedTasks(String token) async {
    http.Response response = await http.get(
      Uri.parse(
        BackendConfigs.kBaseUrl + EndPoints.kGetInCompletedTasks,
      ),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskModel.fromJson(jsonDecode(response.body));
    } else {
      return TaskModel();
    }
  }
}
