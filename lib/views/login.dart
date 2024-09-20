import 'dart:developer';

import 'package:api_di/models/login_response.dart';
import 'package:api_di/providers/token_provider.dart';
import 'package:api_di/providers/user_provider.dart';
import 'package:api_di/services/auth.dart';
import 'package:api_di/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    var user = Provider.of<UserProvider>(context);
    var tokenProvider = Provider.of<TokenProvider>(context);
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
                      .then((loginResponse) async {
                    await AuthServices()
                        .getUserProfile(loginResponse.token.toString())
                        .then((userResponse) {
                      Provider.of<UserProvider>(context,listen: false).setUser(userResponse);
                      Provider.of<TokenProvider>(context,listen: false).setToken(loginResponse.token.toString());

                      isLoading = false;
                      setState(() {});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePageView()));
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
