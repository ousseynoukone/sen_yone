class Ligne {
  int id;
  List<double> itineraire;
  List<String> checkPoints;
  int numero;

  // Constructeur
  Ligne({required this.id, required this.itineraire, required this.checkPoints, required this.numero});

  void afficherDetails() {
    print('ID: $id');
    print('Itinéraire: $itineraire');
    print('Checkpoints: $checkPoints');
    print('Numéro: $numero');
  }
  
}
