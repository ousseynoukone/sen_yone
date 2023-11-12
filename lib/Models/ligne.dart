class Ligne {
  int id;
  List<dynamic> itineraire;
  List<dynamic> check_points;
  List<dynamic> tarifs;
  int numero;
  int frequence;

  // Constructeur
  Ligne(
      {required this.id,
      required this.itineraire,
      required this.check_points,
      required this.frequence,
      required this.tarifs,
      required this.numero});

  void afficherDetails() {
    print('ID: $id');
    print('Itinéraire: $itineraire');
    print('Checkpoints: $check_points');
    print('Numéro: $numero');
    print('Numéro: $frequence');
    print('Numéro: $tarifs');
  }
}
