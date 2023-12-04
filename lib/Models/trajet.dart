import 'package:SenYone/Models/Dto/direct_trajet_dto.dart';
import 'package:SenYone/Models/Dto/undirect_trajet_dto.dart';

class Trajet {
  List<DirectLine> directLines;
  List<IndirectLine> indirectLines;
  double indirectLinesDistance;
  DateTime dateTime = DateTime.now();

  Trajet({
    required this.indirectLinesDistance,
    required this.directLines,
    required this.indirectLines,
  });
}
