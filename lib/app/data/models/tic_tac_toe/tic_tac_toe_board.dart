import 'package:get/get.dart';
import 'package:tic_tac_toe/app/data/models/tic_tac_toe/tic_tac_toe_board_block.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';

class TicTacToeBoard {
  List<List<Rx<TicTacToeBoardBlock>>> board;

  TicTacToeBoard({required this.board});

  void resetBoard() {
    board.forEach((boardRow) {
      boardRow.forEach((block) {
        block.value.resetBlockStatus();
        block.refresh();
      });
    });
  }

  bool get noMovesLeft {
    for (final boardRow in board) {
      for (final block in boardRow) {
        if (block.value.blockStatus == BlockStatus.none) {
          return false;
        }
      }
    }
    // No more moves left
    return true;
  }

  bool canPlayMove(int row, int col) {
    if (row < 0 || col < 0 || row >= board.length || col > board[row].length)
      return false;

    return board[row][col].value.blockStatus == BlockStatus.none;
  }
}
