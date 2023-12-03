class IndirectLine {
  List<double> startingPoint;
  List<List<dynamic>> line;
  int numero;
  List<double>? endingPoint;
  BusStop ArretbusD;
  BusStop ArretbusA;

  IndirectLine({
    required this.startingPoint,
    required this.line,
    required this.endingPoint,
    required this.ArretbusD,
    required this.ArretbusA,
    required this.numero,
  });

  factory IndirectLine.fromJson(Map<String, dynamic> json) {
    //toute cette gimnastique aurait pu etre eviter si j'avait envoyé les données toutes avec le meme format , hélas je suis trop con , et j'ai pas le temps d'aller réctifier cela :( .
    List<List<double>> lineList = List<List<double>>.from(
        json["ligne"][1].map((point) => List<double>.from(point)));

    int numero = json["ligne"][0];

    List<double> startingPoint = List<double>.from(json['StartingPoint']);
    List<double> endingPoint = List<double>.from(json['EndingPoint']);

    BusStop ArretbusD = BusStop.fromJson(json['ArretbusD']);
    BusStop ArretbusA = BusStop.fromJson(json['ArretbusA']);

    return IndirectLine(
      line: lineList,
      numero: numero,
      startingPoint: startingPoint,
      endingPoint: endingPoint,
      ArretbusD: ArretbusD,
      ArretbusA: ArretbusA,
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
