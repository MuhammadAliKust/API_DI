import 'dart:developer';

import 'package:api_di/models/task.dart';
import 'package:api_di/providers/token_provider.dart';
import 'package:api_di/services/task.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class Showtask extends StatefulWidget {
  const Showtask({super.key});

  @override
  State<Showtask> createState() => _ShowtaskState();
}

class _ShowtaskState extends State<Showtask> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    return LoadingOverlay(
      isLoading: isLoading,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
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
                          trailing: IconButton(
                            onPressed: () async {
                              try {
                                isLoading = true;
                                setState(() {});
                                await TaskServices()
                                    .deleteTaskByID(
                                        taskID:
                                            taskModel.tasks![i].id.toString(),
                                        token:
                                            tokenProvider.getToken().toString())
                                    .then((val) {
                                  isLoading = false;
                                  setState(() {});
                                  if (val == true) {
                                    setState(() {});
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                            Text('Task deleted successfully.')));

                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('Something went wrong.')));
                                  }
                                });
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())));
                              }
                            },
                            icon: Icon(Icons.delete),
                          ),
                          title:
                              Text(taskModel.tasks![i].description.toString()),
                        );
                      });
            },
          )),
    );
  }
}
