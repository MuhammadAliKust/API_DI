import 'dart:convert';

import 'package:api_di/models/login_response.dart';
import 'package:api_di/models/register_response.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  ///Register
  Future<RegisterResponseModel> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    http.Response response = await http.post(
        Uri.parse(
          'https://todo-nu-plum-19.vercel.app/users/register',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"name": name, "email": email, "password": password}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegisterResponseModel.fromJson(jsonDecode(response.body));
    } else {
      return RegisterResponseModel();
    }
  }

  ///Login
  Future<LoginResponseModel> loginUser(
      {required String email, required String password}) async {
    http.Response response = await http.post(
        Uri.parse(
          'https://todo-nu-plum-19.vercel.app/users/login',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    } else {
      return LoginResponseModel();
    }
  }

  ///Get User Profile
}
