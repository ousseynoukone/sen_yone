import 'dart:convert';

class TrajetDirectDto {
  String depart;
  String arrive;
  double departLat;
  double departLon;
  double arriveLat;
  double arriveLon;
  double distance;
  int frequence;
  String ligneId;
  String ?numero;
  DateTime? createdAt;
  DateTime? updatedAt;

  TrajetDirectDto(
      {required this.depart,
      required this.arrive,
      required this.departLat,
      required this.departLon,
      required this.arriveLat,
      required this.arriveLon,
      required this.distance,
      required this.frequence,
      required this.ligneId,
      this.numero,
      this.createdAt,
      this.updatedAt});

  factory TrajetDirectDto.fromJson(Map<String, dynamic> json) {
    return TrajetDirectDto(
      depart: json['depart'],
      arrive: json['arrive'],
      departLat: _parseDouble(json['departLat']) ??
          0.0, // Use a default value (e.g., 0.0) or handle null as needed
      departLon: _parseDouble(json['departLon']) ?? 0.0,
      arriveLat: _parseDouble(json['arriveLat']) ?? 0.0,
      arriveLon: _parseDouble(json['arriveLon']) ?? 0.0,
      distance: _parseDouble(json['distance']) ?? 0.0,
      frequence: json['frequence'],
      numero: json['numero'],
      ligneId: json['ligne_id'].toString(), // Explicitly cast to int
      createdAt: DateTime.parse(json['created_at']),
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
    return {
      'depart': depart.toString(),
      'arrive': arrive.toString(),
      'departLat': departLat.toString(),
      'departLon': departLon.toString(),
      'arriveLat': arriveLat.toString(),
      'arriveLon': arriveLon.toString(),
      'distance': distance.toString(),
      'frequence': frequence.toString(),
      'ligne_id': ligneId.toString(),
    };
  }
}

class TrajetIndirectDto {
  String depart;
  String arrive;
  String lignes;
  double distance;
  DateTime? createdAt;

  TrajetIndirectDto({
    required this.depart,
    required this.arrive,
    required this.lignes,
    required this.distance,
    this.createdAt,
  });

  factory TrajetIndirectDto.fromJson(Map<String, dynamic> json) =>
      TrajetIndirectDto(
        depart: json['depart'],
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
