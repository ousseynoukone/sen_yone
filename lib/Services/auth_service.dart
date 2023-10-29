import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';

import '../REST_REQUEST/http_request_auth.dart';
import '../Models/user.dart';
import '../Models/Dto/user_dto.dart';

class AuthService {
  static login(UserDtoLogin u) async {
    var result = await HttpAuthRequest.loginUser(u);
    return result;
  }

  static register(User u) async {
    var result = await HttpAuthRequest.registerUser(u);
    return result;
  }

  static activateAccount(String code) async {
    var result = await HttpAuthRequest.activeAccount(code);
    return result;
  }

  static sendResetEmail(String email) async {
    var result = await HttpAuthRequest.sendEmailForForgetPassword(email);
    return result;
  }

  static resetPassword(String code, String password) async {
    var result = await HttpAuthRequest.resetPassword(code, password);
    return result;
  }

  static logOut() async {
    var result = await HttpAuthRequest.logOut();
    final Box _boxLogin = Hive.box("login");

    _boxLogin.delete("login");
    _boxLogin.delete("password");
    _boxLogin.delete("loginStatus");
    return result;
  }
}
