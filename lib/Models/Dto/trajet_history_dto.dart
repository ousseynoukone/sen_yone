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
      this.createdAt,
      this.updatedAt});

  factory TrajetDirectDto.fromJson(Map<String, dynamic> json) =>
      TrajetDirectDto(
        depart: json['depart'],
        arrive: json['arrive'],
        departLat: json['departLat'],
        departLon: json['departLon'],
        arriveLat: json['arriveLat']?.cast<double>(),
        arriveLon: json['arriveLon']?.cast<double>(),
        distance: json['distance'],
        frequence: json['frequence'],
        ligneId: json['ligne_id'],
        createdAt: DateTime.parse(json['created_at']),
      );

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
