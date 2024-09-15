import 'package:api_di/models/user.dart';
import 'package:flutter/widgets.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _userModel;

  void setUser(UserModel model) {
    _userModel = model;
    notifyListeners();
  }

  UserModel? getUser() => _userModel;
}
