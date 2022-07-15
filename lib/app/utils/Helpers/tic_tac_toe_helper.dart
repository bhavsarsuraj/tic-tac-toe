import 'package:tic_tac_toe/app/utils/enums.dart';

class TicTacToeHelper {
  static int getBoardSizeFromDifficulty(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.EASY:
        return 3;
      case Difficulty.MEDIUM:
        return 4;
      case Difficulty.HARD:
        return 5;
    }
  }
}
