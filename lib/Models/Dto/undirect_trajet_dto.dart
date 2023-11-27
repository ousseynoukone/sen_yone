class IndirectLineDTO {
  List<List<Map<String, dynamic>>> indirectLines;

  IndirectLineDTO({required this.indirectLines});

  factory IndirectLineDTO.fromJson(Map<String, dynamic> json) {
    return IndirectLineDTO(
      indirectLines: List<List<Map<String, dynamic>>>.from(json['IndirectLines'].map<List<Map<String, dynamic>>>((line) {
        return List<Map<String, dynamic>>.from(line.map<Map<String, dynamic>>((data) {
          return {
            'StartingPoint': List<double>.from(data['StartingPoint'].map<double>((point) => point.toDouble())),
            'busStop': {
              'coordinates': {
                'lon': data['busStop']['coordinates']['lon'].toDouble(),
                'lat': data['busStop']['coordinates']['lat'].toDouble(),
              },
              'distance': data['busStop']['distance'],
              'operator': data['busStop']['operator'],
              'street': data['busStop']['street'],
            },
            'points': List<Map<String, dynamic>>.from(data['0'][1].map<Map<String, dynamic>>((point) {
              return {
                '0': point[0],
                '1': List<List<double>>.from(point[1].map<List<double>>((coord) {
                  return [coord[0].toDouble(), coord[1].toDouble()];
                })),
              };
            })),
          };
        }));
      })),
    );
  }
}
