import 'package:SenYone/Models/Dto/direct_trajet_dto.dart';
import 'package:SenYone/Models/Dto/trajet_history_dto.dart';
import 'package:SenYone/Models/Dto/undirect_trajet_dto.dart';

class TrajetHistorique {
  List<TrajetDirectDto> trajetDirect;
  List<TrajetIndirectDto> trajetIndirect;

 TrajetHistorique({required this.trajetDirect, required this.trajetIndirect});
}
