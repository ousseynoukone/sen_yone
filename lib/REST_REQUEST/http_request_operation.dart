import '../Models/user.dart';
import '../Models/Dto/user_dto.dart';
import '../Shared/shared_config.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

class HttpOpsRequest {
  static  Map<String, String> _setHeadersToken() {
      return {'Authorization': "Bearer ${Hive.box("account_data").get("token")}"};
    }


  static Future<http.Response> getAllLines() async {
    String endpoint = "api/lignes";
    String url = SharedConfig().BASE_URL + endpoint;



    try {
      return await http.get(
        Uri.parse(url),
        headers: _setHeadersToken()
      );
    } catch (e) {
      print("response from getAllLines" + e.toString());
      return http.Response("Serveur indisponible", 404);
    }
  }

  static Future<http.Response> getOneLine(String id) async {
    String endpoint = "api/lignes/${id}";
    String url = SharedConfig().BASE_URL + endpoint;

   

    try {
      return await http.get(
        Uri.parse(url),
                headers: _setHeadersToken()

      );
    } catch (e) {
      print("response from getOneLine" + e.toString());
      return http.Response("Serveur indisponible", 404);
    }
  }
}
