import 'dart:convert';
import 'dart:developer';

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
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
        body: jsonEncode({'description': description}));
    log(response.request!.url.toString());
    log(response.statusCode.toString());
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

  ///Delete Task
  Future<bool> deleteTaskByID(
      {required String taskID, required String token}) async {
    http.Response response = await http.delete(
      Uri.parse(
        "${BackendConfigs.kBaseUrl}${EndPoints.kDeleteTask}/$taskID",
      ),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  ///Search Task
  Future<TaskModel> searchTask(
      {required String searchKey, required String token}) async {
    http.Response response = await http.get(
      Uri.parse(
        "${BackendConfigs.kBaseUrl}${EndPoints.kSearchTask}?keywords=$searchKey",
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
