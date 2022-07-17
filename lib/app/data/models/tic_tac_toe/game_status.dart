import 'package:tic_tac_toe/app/utils/enums.dart';

class GameStatus {
  final GameResultStatus resultStatus;
  final TicTacToeSymbol? winningSymbol;

  GameStatus({
    required this.resultStatus,
    this.winningSymbol,
  });
}
