import 'package:tic_tac_toe/app/utils/enums.dart';

class TicTacToeHelper {
  static BlockStatus getBlockStatusFromSymbol(TicTacToeSymbol symbol) {
    return symbol == TicTacToeSymbol.CROSS
        ? BlockStatus.CROSS
        : BlockStatus.ZERO;
  }
}
