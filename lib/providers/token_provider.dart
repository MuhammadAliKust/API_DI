import 'package:api_di/models/user.dart';
import 'package:flutter/widgets.dart';

class TokenProvider extends ChangeNotifier {
  String? _token;

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  String? getToken() => _token;
}
