import 'dart:convert';
import 'dart:io';

import 'package:SenYone/Models/ligne.dart';
import 'package:SenYone/REST_REQUEST/http_request_operation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../REST_REQUEST/http_request_auth.dart';
import '../Models/user.dart';
import '../Models/Dto/user_dto.dart';

class OpsServices {
  static Future<List<Ligne>> getAllLines() async {
    var response = await HttpOpsRequest.getAllLines();

    var result = jsonDecode(response.body);
    List<Ligne> ligneListe = [];

    if (response.statusCode == 200) {
      for (var item in result) {
        // Access the "itineraire" object
        var itineraire = item["itineraire"];

        // Access the "original" field from the "itineraire" object
        var original = itineraire["original"];
        ligneListe.add(new Ligne(
            id: item["id"],
            tarifs: item["tarifs"],
            itineraire: original,
            check_points: item["check_points"],
            frequence: item["frequence"],
            numero: item["numero"]));
      }
    }

    return ligneListe;
  }

  static getOneLine(String id) async {
    var result = await HttpOpsRequest.getOneLine(id);
    return result;
  }
}
