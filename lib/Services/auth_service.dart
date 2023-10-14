import 'dart:io';

import '../REST_REQUEST/http_request_auth.dart';
import '../Models/user.dart';
import '../Models/Dto/user_dto.dart';

class AuthService {
 static login(UserDtoLogin u) async {
    var result = await HttpAuthRequest.loginUser(u);
    return result;
  }
}
