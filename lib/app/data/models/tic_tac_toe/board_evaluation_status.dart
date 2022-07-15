import 'package:tic_tac_toe/app/utils/enums.dart';

class BoardEvaluationStatus {
  final bool isTie;
  final BlockStatus? winnerBlockStatus;

  BoardEvaluationStatus({this.isTie = false, this.winnerBlockStatus});
}
