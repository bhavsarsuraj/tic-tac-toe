import 'package:get/get.dart';
import 'package:tic_tac_toe/app/data/models/tic_tac_toe/move.dart';
import 'package:tic_tac_toe/app/data/models/tic_tac_toe/tic_tac_toe_board.dart';
import 'package:tic_tac_toe/app/data/models/tic_tac_toe/tic_tac_toe_board_block.dart';
import 'package:tic_tac_toe/app/utils/Helpers/tic_tac_toe_helper.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';

class TicTacToe {
  final Difficulty difficulty;
  final BlockStatus myMarkingSymbol;

  TicTacToe({
    required this.difficulty,
    required this.myMarkingSymbol,
  }) {
    _initialise();
  }

  late TicTacToeBoard ticTacToeBoard;
  List<List<Rx<TicTacToeBoardBlock>>> get board => ticTacToeBoard.board;

  late BlockStatus _opponentMarkingSymbol;

  void _initialise() {
    final size = TicTacToeHelper.getSizeFromDifficulty(difficulty);

    ticTacToeBoard = TicTacToeBoard(
      board: List.generate(
        size,
        (index) => List.generate(
          size,
          (index) => TicTacToeBoardBlock().obs,
        ).toList(),
      ).toList(),
    );

    switch (myMarkingSymbol) {
      case BlockStatus.CIRCLE:
        _opponentMarkingSymbol = BlockStatus.CROSS;
        return;
      case BlockStatus.CROSS:
        _opponentMarkingSymbol = BlockStatus.CIRCLE;
        return;
      default:
        _opponentMarkingSymbol = BlockStatus.CIRCLE;
        return;
    }
  }

  GameStatus playMove(Move move) {
    // Validate row and col
    if (move.row < 0 ||
        move.col < 0 ||
        move.row >= board.length ||
        move.col >= board[move.row].length) return GameStatus.CONTINUE;

    final block = board[move.row][move.col];
    if (block.value.blockStatus != BlockStatus.none) return GameStatus.CONTINUE;

    block.value.blockStatus = move.blockStatus;
    block.refresh();
    return _evaluate(
      row: move.row,
      col: move.col,
    );
  }

  GameStatus _evaluate({
    required int row,
    required int col,
  }) {
    bool hasMatch =
        _isRowValid(row) || _isColumnValid(col) || _isDiagonalsValid();
    if (hasMatch) {
      // Game Finished
      return GameStatus.FINISHED;
    } else if (ticTacToeBoard.noMovesLeft) {
      // Game finished and result in draw
      return GameStatus.DRAW;
    }

    return GameStatus.CONTINUE;
  }

  bool _isRowValid(int row) {
    // Validate row index
    if (row < 0 || row >= board.length) return false;
    final boardRow = board[row];

    int col = 0;
    while (col < boardRow.length - 1 &&
        boardRow[col].value.blockStatus ==
            boardRow[col + 1].value.blockStatus) {
      col++;
    }

    if (col >= 2 &&
        (col == boardRow.length - 1) &&
        boardRow[col].value.blockStatus != BlockStatus.none) {
      return true;
    } else {
      return false;
    }
  }

  bool _isColumnValid(int col) {
    // Validate row and col
    if (col < 0 || col >= board[0].length) return false;
    int row = 0;
    while (row < board.length - 1 &&
        board[row][col].value.blockStatus ==
            board[row + 1][col].value.blockStatus) {
      row++;
    }
    if (row >= 2 &&
        (row == board.length - 1) &&
        board[row][col].value.blockStatus != BlockStatus.none) {
      return true;
    } else {
      return false;
    }
  }

  bool _isDiagonalsValid() {
    int index = 0;

    while (index < board.length - 1 &&
        board[index][index].value.blockStatus ==
            board[index + 1][index + 1].value.blockStatus) {
      index++;
    }
    if (index == board.length - 1 &&
        board[index][index].value.blockStatus != BlockStatus.none) {
      return true;
    }
    int col = 2;
    int row = 0;
    while (row < board.length - 1 &&
        col > 0 &&
        board[row][col].value.blockStatus ==
            board[row + 1][col - 1].value.blockStatus) {
      row++;
      col--;
    }
    if ((row == board.length - 1) &&
        (col == 0) &&
        board[row][col].value.blockStatus != BlockStatus.none) {
      return true;
    }
    return false;
  }

  void resetGame() {
    ticTacToeBoard.resetBoard();
  }

  GameStatus playComputerMove() {
    for (int row = 0; row < board.length; row++) {
      for (int col = 0; col < board[row].length; col++) {
        if (ticTacToeBoard.canPlayMove(row, col)) {
          board[row][col].value.blockStatus = _opponentMarkingSymbol;
          board[row][col].refresh();
          return _evaluate(row: row, col: col);
        }
      }
    }
    return GameStatus.CONTINUE;
  }
}
