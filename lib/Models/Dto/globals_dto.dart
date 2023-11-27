import 'dart:convert';

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
