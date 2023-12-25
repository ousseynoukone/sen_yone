import 'dart:convert';
import 'package:SenYone/Models/Dto/globals_dto.dart';
import 'package:logger/logger.dart';

class TrajetDirectDto {
  var id ;
  String tarifs;
  String depart;
  String arrive;
  double departLat;
  double departLon;
  double arriveLat;
  double arriveLon;
  double distance;
  int frequence;
  String ligneId;
  String? numero;
  DateTime? createdAt;
  DateTime? updatedAt;
  RouteInfo routeInfo;
  List<dynamic> line;

  TrajetDirectDto(
      {required this.depart,
      required this.arrive,
      required this.tarifs,
      required this.departLat,
      required this.departLon,
      required this.arriveLat,
      required this.arriveLon,
      required this.distance,
      required this.frequence,
      required this.ligneId,
      required this.routeInfo,
      required this.line,
      this.id,
      this.numero,
      this.createdAt,
      this.updatedAt});

  factory TrajetDirectDto.fromJson(Map<String, dynamic> json) {
    Logger().e(jsonDecode(json["ligne"]));
    return TrajetDirectDto(
        depart: json['depart'].toString(),
        arrive: json['arrive'].toString(),
        departLat: _parseDouble(json['departLat']) ??
            0.0, // Use a default value (e.g., 0.0) or handle null as needed
        departLon: _parseDouble(json['departLon']) ?? 0.0,
        arriveLat: _parseDouble(json['arriveLat']) ?? 0.0,
        arriveLon: _parseDouble(json['arriveLon']) ?? 0.0,
        distance: _parseDouble(json['distance']) ?? 0.0,
        frequence: json['frequence'],
        numero: json['numero'].toString(),
        ligneId: json['ligne_id'].toString(),
        createdAt: DateTime.parse(json['created_at']),
        routeInfo: RouteInfo.fromJson(jsonDecode(json["routeInfo"])),
        line: jsonDecode(json["ligne"]),
        tarifs: json["tarifs"].toString(),
        id:json["id"]

        
        );
  }

  static double _parseDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value) ??
          0.0; // Use a default value (e.g., 0.0) or handle null as needed
    }
    return 0.0; // Use a default value (e.g., 0.0) or handle null as needed
  }

  Map<String, dynamic> toJson() {
    List<List<double>> serializedCoordinates =
        routeInfo.coordinates.map((latLng) {
      return [latLng.latitude, latLng.longitude];
    }).toList();

    return {
      'depart': depart,
      'arrive': arrive,
      'departLat': departLat.toString(),
      'departLon': departLon.toString(),
      'arriveLat': arriveLat.toString(),
      'arriveLon': arriveLon.toString(),
      'distance': distance.toString(),
      'tarifs': tarifs.toString(),
      'frequence': frequence.toString(),
      'ligne_id': ligneId,
      'ligne': json.encode(line),
      'routeInfo': json.encode({
        'distance': routeInfo.distance,
        'duration': routeInfo.duration,
        'coordinates': serializedCoordinates,
      }),
    };
  }
}

class TrajetIndirectDto {
  String depart;
  String arrive;
  String lignes;
  double distance;
  DateTime? createdAt;
  var id ;

  TrajetIndirectDto({
    required this.depart,
    required this.arrive,
    required this.lignes,
    required this.distance,
    this.createdAt,
    this.id
  });

  factory TrajetIndirectDto.fromJson(Map<String, dynamic> json) =>
      TrajetIndirectDto(
        depart: json['depart'],
        id: json['id'],
        arrive: json['arrive'],
        lignes: json['lignes'],
        distance: json['distance'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'depart': depart.toString(),
        'arrive': arrive.toString(),
        'lignes': lignes.toString(),
        'distance': distance.toString(),
      };

  static TrajetIndirectDto fromBody(String body) =>
      TrajetIndirectDto.fromJson(json.decode(body));
}
