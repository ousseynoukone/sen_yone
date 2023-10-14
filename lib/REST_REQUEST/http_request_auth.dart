import '../Models/user.dart';
import '../Models/Dto/user_dto.dart';
import '../Shared/shared_config.dart';
import 'package:http/http.dart' as http;

class HttpAuthRequest {

  static Future<http.Response> loginUser(UserDtoLogin u) async {
    String endpoint = "api/login";
    String url = SharedConfig().BASE_URL + endpoint;
        _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
   
  };
    return await http.post(Uri.parse(url),
        body: u.toBody());
  }

  static Future<http.Response> registerUser(User u) async {
    String endpoint = "api/register";
    return await http.post(Uri.parse(SharedConfig().BASE_URL + endpoint),
        body: u.toBody());
  }

  static Future<http.Response> activeAccount(String code) async {
    String endpoint = "api/active-account";
    return await http.post(Uri.parse(SharedConfig().BASE_URL + endpoint),
        body: {code: code});
  }

  static Future<http.Response> sendEmailForForgetPassword(String email) async {
    String endpoint = "api/reset-mail-sender";
    return await http.post(Uri.parse(SharedConfig().BASE_URL + endpoint),
        body: {email: email});
  }

  static Future<http.Response> resetPassword(
      String code, String password) async {
    String endpoint = "api/reset";
    return await http.post(Uri.parse(SharedConfig().BASE_URL + endpoint),
        body: {password: password, code: code});
  }
}
