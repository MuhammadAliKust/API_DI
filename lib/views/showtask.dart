import 'dart:developer';

import 'package:api_di/models/task.dart';
import 'package:api_di/providers/token_provider.dart';
import 'package:api_di/services/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Showtask extends StatefulWidget {
  const Showtask({super.key});

  @override
  State<Showtask> createState() => _ShowtaskState();
}

class _ShowtaskState extends State<Showtask> {
  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Get All Task"),
        ),
        body: FutureProvider.value(
          value:
              TaskServices().getAllTasks(tokenProvider.getToken().toString()),
          initialData: TaskModel(),
          builder: (context, child) {
            TaskModel taskModel = context.watch<TaskModel>();
            return taskModel.tasks == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: taskModel.tasks!.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(taskModel.tasks![i].description.toString()),
                      );
                    });
          },
        ));
  }
}
