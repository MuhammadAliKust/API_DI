import 'package:api_di/providers/user_provider.dart';
import 'package:api_di/views/create_task.dart';
import 'package:api_di/views/profile.dart';
import 'package:api_di/views/showtask.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileView()));
              },
              icon: Icon(Icons.person))
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateTaskView()));
              },
              child: Text("Create Task")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Showtask()));
              },
              child: Text("Get Task")),
        ],
      ),
    );
  }
}
