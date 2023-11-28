class IndirectLine {
  List<double> startingPoint;
  List<List<dynamic>> line;
  int numero;
  List<double>? endingPoint;
  BusStop busStop;

  IndirectLine({
    required this.startingPoint,
    required this.line,
    required this.endingPoint,
    required this.busStop,
    required this.numero,
  });

  factory IndirectLine.fromJson(Map<String, dynamic> json) {
    //toute cette gimnastique aurait pu etre eviter si j'avait envoyé les données toutes avec le meme format , hélas je suis trop con , et j'ai pas le temps d'aller réctifier cela :( .
    List<List<double>> lineList = json['0'][1] != null
        ? List<List<double>>.from(
            json['0'][1].map((point) => List<double>.from(point)))
        : List<List<double>>.from(
            json['0']['0'][1].map((point) => List<double>.from(point)));
    int numero = json['0'][0] ?? json['0']['0'][0];


        List<double> startingPoint = json['StartingPoint'] != null
    ? List<double>.from(json['StartingPoint'])
    : List<double>.from(json['0']['StartingPoint'] ?? []);

    BusStop busStop = json['busStop']!=null ?  BusStop.fromJson(json['busStop']) :  BusStop.fromJson(json['0']['busStop']);
    return IndirectLine(
      line: lineList,
      numero: numero,
      startingPoint: startingPoint,
      endingPoint: json['EndingPoint'] != null
          ? List<double>.from(json['EndingPoint'])
          : null,
      busStop: busStop,
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
