import 'dart:developer';

import 'package:api_di/providers/token_provider.dart';
import 'package:api_di/services/task.dart';
import 'package:api_di/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTaskView extends StatefulWidget {
  CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    log(tokenProvider.getToken().toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
      ),
      body: Column(
        children: [
          TextField(
            controller: descriptionController,
          ),
          ElevatedButton(
              onPressed: () async {
                if (descriptionController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Description cannot be empty.")));
                  return;
                }
                isLoading = true;
                setState(() {});
                try {
                  await TaskServices()
                      .createTask(
                          description: descriptionController.text,
                          token: tokenProvider.getToken().toString())
                      .then((val) {
                    isLoading = false;
                    setState(() {});
                    if (val == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePageView()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Something went wrong.')));
                    }
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child:
                  isLoading ? CircularProgressIndicator() : Text("Create Task"))
        ],
      ),
    );
  }
}
