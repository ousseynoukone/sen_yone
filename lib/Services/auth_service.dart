import 'dart:io';

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

    static resetPassword(String code , String password) async {
    var result = await HttpAuthRequest.resetPassword (code  , password);   
    return result;
  }

}
