import 'dart:convert';
import 'dart:ui';

import 'package:SenYone/Shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class RouteRequestDTO {
  double departLatitude;
  double departLongitude;
  double arriveLatitude;
  double arriveLongitude;
  int approximation;

  RouteRequestDTO({
    required this.departLatitude,
    required this.departLongitude,
    required this.arriveLatitude,
    required this.arriveLongitude,
    required this.approximation,
  });

  factory RouteRequestDTO.fromJson(Map<String, dynamic> json) {
    return RouteRequestDTO(
      departLatitude: double.parse(json['departLatitude'].toString()),
      departLongitude: double.parse(json['departLongitude'].toString()),
      arriveLatitude: double.parse(json['arriveLatitude'].toString()),
      arriveLongitude: double.parse(json['arriveLongitude'].toString()),
      approximation: json['approximation'] as int,
    );
  }

  Map<String, String> toBody() {
    return {
      'departLatitude': departLatitude.toString(),
      'departLongitude': departLongitude.toString(),
      'arriveLatitude': arriveLatitude.toString(),
      'arriveLongitude': arriveLongitude.toString(),
      'approximation': approximation.toString(),
    };
  }

  String toJsonString() {
    return json.encode(toBody());
  }
}

class CoordinatesFromGlobal {
  double lon;
  double lat;

  CoordinatesFromGlobal({
    required this.lon,
    required this.lat,
  });

  factory CoordinatesFromGlobal.fromJson(Map<String, dynamic> json) {
    return CoordinatesFromGlobal(
      lon: json['lon'],
      lat: json['lat'],
    );
  }
}

class RandomColorDto {
  final Color color;
  final int numero;

  RandomColorDto(this.color, this.numero);
}

class LegendItem extends StatelessWidget {
  final Color? color;
  final IconData? icon;
  final Color? iconColor;
  final String text;

  const LegendItem({
    Key? key,
    this.color,
    this.icon,
    this.iconColor,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        children: [
          if (color != null)
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: color),
              width: 30,
              height: 4,
            ),
          SizedBox(width: 5),
          if (icon != null)
            Icon(
              icon,
              color: iconColor,
            ),
          SizedBox(width: 5),
          Text(text),
        ],
      ),
    );
  }
}

class RouteInfo {
  int distance;
  var duration;
  List<LatLng> coordinates;

  RouteInfo(
      {required this.distance,
      required this.duration,
      required this.coordinates});

  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'duration': duration,
      'coordinates': coordinates,
    };
  }

  factory RouteInfo.fromJson(Map<String, dynamic> json) {
    var cords = List<List<double>>.from(
        json['coordinates'].map((c) => List<double>.from(c)));

    return RouteInfo(
      distance: json['distance'],
      duration: json['duration'],
      coordinates: createLatLngList(cords),
    );
  }
}


class LineDto {
  int id;
  List<List<double>> itineraire;

  LineDto({
    required this.id,
    required this.itineraire,
  });

  factory LineDto.fromJson(Map<String, dynamic> json) {
    return LineDto(
      id: json['id'],
      itineraire: List<List<double>>.from(json['itineraire'].map((point) =>
          List<double>.from(point.map((coordinate) => coordinate.toDouble())))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itineraire': itineraire.map((point) =>
          List<double>.from(point.map((coordinate) => coordinate.toDouble()))),
    };
  }
}
