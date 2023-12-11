import 'package:SenYone/Models/Dto/globals_dto.dart';
import 'package:logger/logger.dart';

import '../Models/user.dart';
import '../Models/Dto/user_dto.dart';
import '../Shared/shared_config.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

class HttpOpsRequest {
  static Map<String, String> _setHeadersToken() {
    return {'Authorization': "Bearer ${Hive.box("account_data").get("token")}"};
  }

  static Future<http.Response> getAllLines() async {
    String endpoint = "api/lignes";
    String url = SharedConfig().BASE_URL + endpoint;

    try {
      return await http.get(Uri.parse(url), headers: _setHeadersToken());
    } catch (e) {
      print("response from getAllLines" + e.toString());
      return http.Response("Serveur indisponible", 404);
    }
  }

  static Future<http.Response> getOneLine(String id) async {
    String endpoint = "api/lignes/${id}";
    String url = SharedConfig().BASE_URL + endpoint;

    try {
      return await http.get(Uri.parse(url), headers: _setHeadersToken());
    } catch (e) {
      print("response from getOneLine" + e.toString());
      return http.Response("Serveur indisponible", 404);
    }
  }

  static Future<http.Response> searchForTraject(
      RouteRequestDTO routeRequestDTO) async {
    // routeRequestDTO.departLatitude = 14.7715691;
    // routeRequestDTO.departLongitude = -17.4206297;
    // routeRequestDTO.arriveLatitude = 14.68724935;
    // routeRequestDTO.arriveLongitude = -17.46444644727304;

    String endpoint = "api/make-trajets";
    String url = SharedConfig().BASE_URL + endpoint;

    try {
      return await http.post(Uri.parse(url),
          body: routeRequestDTO.toBody(), headers: _setHeadersToken());
    } catch (e) {
      new Logger().d(url);

      return http.Response("Serveur indisponible", 404);
    }
  }
}
