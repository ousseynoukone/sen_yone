import 'package:SenYone/Models/Dto/globals_dto.dart';
import 'package:SenYone/Models/Dto/trajet_history_dto.dart';
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

  static Future<http.Response> getOneLine(String num) async {
    String endpoint = "api/lignes/${num}";
    String url = SharedConfig().BASE_URL + endpoint;

    try {
      var response =
          await http.get(Uri.parse(url), headers: _setHeadersToken());
      return response;
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

  static Future<http.Response> createDirectTrajet(
      TrajetDirectDto trajetDirectDto) async {
    String endpoint =
        "api/trajets-historiqueD"; // Adjust the endpoint based on your API
    String url = SharedConfig().BASE_URL + endpoint;

    var any = trajetDirectDto.toJson();

    Logger().w(any);

    try {
      return await http.post(
        Uri.parse(url),
        headers: _setHeadersToken(),
        body: trajetDirectDto
            .toJson(), // Assuming toJson is implemented in TrajetDto
      );
    } catch (e) {
      print("Error from createTrajet: $e");
      return http.Response("Server unavailable", 404);
    }
  }

  static Future<http.Response> createIndirectTrajet(
      TrajetIndirectDto trajetInDirectDto) async {
    String endpoint =
        "api/trajets-historiqueI"; // Adjust the endpoint based on your API
    String url = SharedConfig().BASE_URL + endpoint;

    try {
      var responose = await http.post(
        Uri.parse(url),
        headers: _setHeadersToken(),
        body: trajetInDirectDto
            .toJson(), // Assuming toJson is implemented in TrajetDto
      );
      Logger().d(responose.body);
      return responose;
    } catch (e) {
      print("Error from createIndirectTrajet: $e");
      return http.Response("Server unavailable", 404);
    }
  }
}
