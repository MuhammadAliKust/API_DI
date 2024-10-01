import 'dart:developer';

import 'package:api_di/models/task.dart';
import 'package:api_di/providers/token_provider.dart';
import 'package:api_di/services/task.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class SearchTaskView extends StatefulWidget {
  const SearchTaskView({super.key});

  @override
  State<SearchTaskView> createState() => _SearchTaskViewState();
}

class _SearchTaskViewState extends State<SearchTaskView> {
  bool isLoading = false;

  TaskModel? searchTaskModel;
  List<String> myList = ['A', 'B'];

  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Search Task"),
        ),
        body: Column(
          children: [
            ...myList.map((e){

              return Text(e.toString());
            }),
            TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (val) {
                isLoading = true;
                setState(() {});
                TaskServices()
                    .searchTask(
                        searchKey: val,
                        token: tokenProvider.getToken().toString())
                    .then((val) {
                  isLoading = false;
                  searchTaskModel = val;
                  setState(() {});
                });
              },
            ),
            if (isLoading) CircularProgressIndicator(),
            if (searchTaskModel != null)
              searchTaskModel!.tasks!.isEmpty
                  ? const Text("No Data Found")
                  : ListView.builder(
                      itemCount: searchTaskModel!.tasks!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return ListTile(
                          title: Text(searchTaskModel!.tasks![i].description
                              .toString()),
                        );
                      })
          ],
        ));
  }
}
