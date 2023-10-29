import '../Models/user.dart';
import '../Models/Dto/user_dto.dart';
import '../Shared/shared_config.dart';
import 'package:http/http.dart' as http;

class HttpAuthRequest {
  static Future<http.Response> loginUser(UserDtoLogin u) async {
    String endpoint = "api/login";
    String url = SharedConfig().BASE_URL + endpoint;

    Map<String, String> _setHeaders() {
      return {'ngrok-skip-browser-warning': 'chiant !'};
    }

    try {
      return await http.post(
        Uri.parse(url),
        body: u.toBody(),
      );
    } catch (e) {
      print("response from login" + e.toString());
      return http.Response("Serveur indisponible", 404);
    }
  }

  static Future<http.Response> logOut() async {
    String endpoint = "api/logout";
    String url = SharedConfig().BASE_URL + endpoint;

    return await http.get(Uri.parse(url));
  }

  static Future<http.Response> registerUser(User u) async {
    String endpoint = "api/register";
    try {
      return await http.post(Uri.parse(SharedConfig().BASE_URL + endpoint),
          body: u.toBody());
    } catch (e) {
      print(e);
      return http.Response("Serveur indisponible", 404);
    }
  }

  static Future<http.Response> activeAccount(String code) async {
    String endpoint = "api/active-account";
    try {
      return await http.post(Uri.parse(SharedConfig().BASE_URL + endpoint),
          body: {"code": code});
    } catch (e) {
      print(e);
      return http.Response("Serveur indisponible", 404);
    }
  }

  static Future<http.Response> sendEmailForForgetPassword(String email) async {
    String endpoint = "api/reset-mail-sender";

    try {
      return await http.post(Uri.parse(SharedConfig().BASE_URL + endpoint),
          body: {"email": email});
    } catch (e) {
      print(e);
      return http.Response("Serveur indisponible", 404);
    }
  }

  static Future<http.Response> resetPassword(
      String code, String password) async {
    String endpoint = "api/reset";
    try {
      return await http.post(Uri.parse(SharedConfig().BASE_URL + endpoint),
          body: {"password": password, "code": code});
    } catch (e) {
      print(e);
      return http.Response("Serveur indisponible", 404);
    }
  }
}
