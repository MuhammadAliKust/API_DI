import 'dart:developer';

import 'package:api_di/services/auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login View"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: emailController,
          ),
          TextFormField(
            controller: pwdController,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                isLoading = true;
                setState(() {});
                try {
                  await AuthServices()
                      .loginUser(
                          email: emailController.text,
                          password: pwdController.text)
                      .then((val) {
                    isLoading = false;
                    setState(() {});
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Message"),
                            content: Text(val.user!.name.toString()),
                          );
                        });
                  });
                } catch (e) {
                  isLoading = false;
                  setState(() {});
                  log(e.toString());
                }
              },
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text("Login"))
        ],
      ),
    );
  }
}
