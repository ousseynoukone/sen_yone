import 'package:flutter/material.dart';

import 'ligne.dart';

class Trajet {
  int id;
  Ligne ligne;
  double duree;
  TimeOfDay heureDepart;
  TimeOfDay heureArrivee;
  double prix;
  double distance;

  Trajet(
      {required this.id,
      required this.ligne,
      required this.duree,
      required this.heureDepart,
      required this.heureArrivee,
      required this.prix,
      required this.distance});


  void afficherDetails() {
    
    print('ID: $id');
    print('Ligne: ${ligne.id}');
    print('Durée: $duree');
    print('Heure de départ: $heureDepart');
    print('Heure d\'arrivée: $heureArrivee');
    print('Prix: $prix');
    print('Distance: $distance');

  }
}
