import 'dart:math';
import 'package:get/get.dart';
import 'package:tic_tac_toe/app/data/models/tic_tac_toe/game_status.dart';
import 'package:tic_tac_toe/app/data/models/tic_tac_toe/board_evaluation_status.dart';
import 'package:tic_tac_toe/app/data/models/tic_tac_toe/move.dart';
import 'package:tic_tac_toe/app/data/models/tic_tac_toe/tic_tac_toe_board.dart';
import 'package:tic_tac_toe/app/data/models/tic_tac_toe/tic_tac_toe_board_block.dart';
import 'package:tic_tac_toe/app/utils/Helpers/tic_tac_toe_helper.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';

class TicTacToe {
  final TicTacToeSymbol myMarkingSymbol;
  TicTacToe({
    required this.myMarkingSymbol,
  }) {
    _initialise();
  }

  late TicTacToeBoard ticTacToeBoard;
  List<List<Rx<TicTacToeBoardBlock>>> get board => ticTacToeBoard.board;
  late TicTacToeSymbol _opponentMarkingSymbol;
  TicTacToeSymbol get opponentMarkingSymbol => _opponentMarkingSymbol;
  final boardSize = 3;

  bool get playedAtLeastOneMove {
    return ticTacToeBoard.movesLeft < (boardSize * boardSize);
  }

  void _initialise() {
    _initialiseBoard();
    _setOpponentMarkingSymbol();
  }

  void _initialiseBoard() {
    ticTacToeBoard = TicTacToeBoard(
      board: List.generate(
        boardSize,
        (index) => List.generate(
          boardSize,
          (index) => TicTacToeBoardBlock().obs,
        ).toList(),
      ).toList(),
    );
  }

  void _setOpponentMarkingSymbol() {
    _opponentMarkingSymbol = myMarkingSymbol == TicTacToeSymbol.CROSS
        ? TicTacToeSymbol.ZERO
        : TicTacToeSymbol.CROSS;
  }

  GameStatus playMove(Move move) {
    // Validate row and col
    if (move.row < 0 ||
        move.col < 0 ||
        move.row >= board.length ||
        move.col >= board.length)
      return GameStatus(resultStatus: GameResultStatus.CONTINUE);

    final block = board[move.row][move.col];
    if (block.value.blockStatus != BlockStatus.NONE)
      return GameStatus(resultStatus: GameResultStatus.CONTINUE);

    block.value.blockStatus = move.blockStatus;
    block.refresh();
    return evaluate(row: move.row, col: move.col);
  }

  // Evaluates Game Status
  GameStatus evaluate({
    required int row,
    required int col,
  }) {
    bool hasMatch = isRowValid(row) || isColumnValid(col) || isDiagonalsValid();
    if (hasMatch) {
      // Game Finished
      return GameStatus(
        resultStatus: GameResultStatus.FINISHED,
        winningSymbol: board[row][col].value.blockStatus == BlockStatus.ZERO
            ? TicTacToeSymbol.ZERO
            : TicTacToeSymbol.CROSS,
      );
    } else if (ticTacToeBoard.noMovesLeft) {
      // Game finished and result in draw
      return GameStatus(resultStatus: GameResultStatus.DRAW);
    }

    return GameStatus(resultStatus: GameResultStatus.CONTINUE);
  }

  bool isRowValid(int row) {
    // Validate row index
    if (row < 0 || row >= board.length) return false;
    final boardRow = board[row];

    int col = 0;

    // Continue loop till adjacent blockStatus matches in the row
    while (col < boardRow.length - 1 &&
        boardRow[col].value.blockStatus ==
            boardRow[col + 1].value.blockStatus) {
      col++;
    }

    if ((col == boardRow.length - 1) &&
        boardRow[col].value.blockStatus != BlockStatus.NONE) {
      // All blocks of row have the same block status
      return true;
    } else {
      return false;
    }
  }

  bool isColumnValid(int col) {
    // Validate row and col
    if (col < 0 || col >= board.length) return false;
    int row = 0;

    // Continue loop till adjacent blockStatus matches in the column
    while (row < board.length - 1 &&
        board[row][col].value.blockStatus ==
            board[row + 1][col].value.blockStatus) {
      row++;
    }
    if ((row == board.length - 1) &&
        board[row][col].value.blockStatus != BlockStatus.NONE) {
      // All blocks of column have the same block status
      return true;
    } else {
      return false;
    }
  }

  bool isDiagonalsValid() {
    // Traversing diagonal from top left to bottom right
    int index = 0;
    while (index < board.length - 1 &&
        board[index][index].value.blockStatus ==
            board[index + 1][index + 1].value.blockStatus) {
      index++;
    }
    if (index == board.length - 1 &&
        board[index][index].value.blockStatus != BlockStatus.NONE) {
      return true;
    }

    // Traversing diagonal from top right to bottom left
    int col = board.length - 1;
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
        board[row][col].value.blockStatus != BlockStatus.NONE) {
      return true;
    }
    return false;
  }

  void resetGame() {
    ticTacToeBoard.resetBoard();
  }

  GameStatus playComputerMove() {
    final optimalMove = _playOptimalMove();
    return evaluate(row: optimalMove.row, col: optimalMove.col);
  }

  Move _playOptimalMove() {
    int bestScore = -1000;
    Move optimalMove = Move(row: 0, col: 0);

    for (int row = 0; row < board.length; row++) {
      for (int col = 0; col < board.length; col++) {
        // Checks if AI can play move on this block
        if (board[row][col].value.blockStatus == BlockStatus.NONE) {
          // Marks this block with opponent symbol and checks the possiblity of winning through backtracking
          board[row][col].value.blockStatus =
              TicTacToeHelper.getBlockStatusFromSymbol(_opponentMarkingSymbol);
          final score = _minimax(row, col, isMaximizing: false);
          // Reset this block
          board[row][col].value.resetBlockStatus();
          // Update best score and optimal move
          if (score > bestScore) {
            bestScore = score;
            optimalMove.row = row;
            optimalMove.col = col;
          }
        }
      }
    }
    board[optimalMove.row][optimalMove.col].value.blockStatus =
        TicTacToeHelper.getBlockStatusFromSymbol(_opponentMarkingSymbol);
    board[optimalMove.row][optimalMove.col].refresh();
    return optimalMove;
  }

  int _minimax(int row, int col, {bool isMaximizing = true}) {
    /*
    Points System
    Tie: 0,
    I Won: -10,
    Opponent Won: 10,
    */
    final gameStatus = checkWinner(row, col);
    if (gameStatus.isTie) {
      return 0;
    } else if (gameStatus.winnerBlockStatus ==
        TicTacToeHelper.getBlockStatusFromSymbol(myMarkingSymbol)) {
      // I Won
      return -10;
    } else if (gameStatus.winnerBlockStatus ==
        TicTacToeHelper.getBlockStatusFromSymbol(_opponentMarkingSymbol)) {
      // Opponent Won
      return 10;
    }

    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < board.length; i++) {
        for (int j = 0; j < board.length; j++) {
          if (board[i][j].value.blockStatus == BlockStatus.NONE) {
            board[i][j].value.blockStatus =
                TicTacToeHelper.getBlockStatusFromSymbol(
                    _opponentMarkingSymbol);
            final score = _minimax(
              i,
              j,
              isMaximizing: false,
            );
            board[i][j].value.resetBlockStatus();
            bestScore = max(score, bestScore);
          }
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < board.length; i++) {
        for (int j = 0; j < board.length; j++) {
          if (board[i][j].value.blockStatus == BlockStatus.NONE) {
            board[i][j].value.blockStatus =
                TicTacToeHelper.getBlockStatusFromSymbol(myMarkingSymbol);
            final score = _minimax(
              i,
              j,
              isMaximizing: true,
            );
            board[i][j].value.resetBlockStatus();
            bestScore = min(score, bestScore);
          }
        }
      }
      return bestScore;
    }
  }

  BoardEvaluationStatus checkWinner(int row, int col) {
    BlockStatus? winner;

    // horizontal
    final validRow = isRowValid(row);
    if (validRow) winner = board[row][col].value.blockStatus;

    // Vertical
    final validCol = isColumnValid(col);
    if (validCol) winner = board[row][col].value.blockStatus;

    // Diagonal
    final validDiagonals = isDiagonalsValid();
    if (validDiagonals) winner = board[row][col].value.blockStatus;

    if (winner == null && ticTacToeBoard.movesLeft == 0) {
      // If there is no winner and also no more moves left, then it will result into a tie
      return BoardEvaluationStatus(isTie: true);
    } else {
      // returns winner if any exists
      return BoardEvaluationStatus(winnerBlockStatus: winner);
    }
  }
}
