class DirectLine {
  List<double> startingPoint;
  List<List<dynamic>> line;
  int numero;
  List<double> endingPoint;
  BusStop busStopD;
  BusStop busStopA;

  DirectLine({
    required this.startingPoint,
    required this.line,
    required this.endingPoint,
    required this.busStopD,
    required this.busStopA,
    required this.numero,
  });

  factory DirectLine.fromJson(Map<String, dynamic> json) {
    return DirectLine(
      startingPoint: List<double>.from(json['StartingPoint']),
      line: List<List<dynamic>>.from(json['0'][1]),
      numero: json['0'][0],
      endingPoint: List<double>.from(json['EndingPoint']),
      busStopA: BusStop.fromJson(json['busStopA']),
      busStopD: BusStop.fromJson(json['busStopD']),
    );
  }
}

class BusStop {
  Coordinates coordinates;
  int distance;
  String street;

  BusStop({
    required this.coordinates,
    required this.distance,
    required this.street,
  });

  factory BusStop.fromJson(Map<String, dynamic> json) {
    return BusStop(
      coordinates: Coordinates.fromJson(json['coordinates']),
      distance: json['distance'],
      street: json['street'],
    );
  }
}

class Coordinates {
  double lon;
  double lat;

  Coordinates({
    required this.lon,
    required this.lat,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lon: json['lon'],
      lat: json['lat'],
    );
  }
}
