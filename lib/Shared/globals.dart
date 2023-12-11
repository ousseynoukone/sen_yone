library SenYone.globals;

import 'dart:math';
import 'dart:ui';

import 'package:SenYone/Models/Dto/custom_position_dto.dart';
import 'package:SenYone/Models/Dto/globals_dto.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

CustumPostionDto userLocation =
    new CustumPostionDto(latitude: 0.0, longitude: 0.0);

// Set to keep track of used colors
final Set<Color> usedColors = {};

RandomColorDto generateRandomColor(int numero) {
  final Random random = Random();

  // List of vibrant colors (excluding white and green)
  final List<Color> vibrantColors = [
    Color.fromARGB(255, 0, 106, 12),
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.blue,
    Colors.indigo,
    Colors.deepOrange,
    Colors.deepPurple,
  ];

  // Shuffle the list to randomize color selection
  vibrantColors.shuffle();

  Color color;
  do {
    // Select a color from the shuffled list
    color = vibrantColors[random.nextInt(vibrantColors.length)];
  } while (usedColors.contains(color));

  usedColors.add(color);

  return RandomColorDto(color, numero);
}


List<LatLng> createLatLngList(List<dynamic> coordinates) {
    List<LatLng> latLngList = [];
    for (var coordinate in coordinates) {
      double latitude = coordinate[0];

      double longitude = coordinate[1];

      latLngList.add(LatLng(latitude, longitude));
    }

    return latLngList;
  }
