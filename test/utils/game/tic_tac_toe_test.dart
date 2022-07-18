import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/app/data/models/tic_tac_toe/move.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';
import 'package:tic_tac_toe/app/utils/game/tic_tac_toe.dart';
import 'package:tic_tac_toe/app/utils/helpers/tic_tac_toe_helper.dart';

void main() {
  group('Opponent marking symbol', () {
    test('initialising my marking symbol with ZERO', () {
      // Arrange
      final myMarkingSymbol = TicTacToeSymbol.ZERO;

      // Act
      final ticTacToe = TicTacToe(myMarkingSymbol: myMarkingSymbol);

      // Assert
      expect(
        ticTacToe.opponentMarkingSymbol,
        equals(TicTacToeSymbol.CROSS),
      );
    });

    test('initialising my marking symbol with CROSS', () {
      // Arrange
      final myMarkingSymbol = TicTacToeSymbol.CROSS;

      // Act
      final ticTacToe = TicTacToe(myMarkingSymbol: myMarkingSymbol);

      // Assert
      expect(
        ticTacToe.opponentMarkingSymbol,
        equals(TicTacToeSymbol.ZERO),
      );
    });
  });

  group('Play Move', () {
    test(
      'play move in specific valid block with CROSS marking as self',
      () {
        // Arrange
        final firstRow = 0;
        final thirdColumn = 2;
        final secondRow = 1;
        final firstColumn = 0;
        final myMarkingSymbol = TicTacToeSymbol.CROSS;
        final none = BlockStatus.NONE;
        final firstRowThirdColumnMove = Move(
          row: firstRow,
          col: thirdColumn,
          blockStatus: TicTacToeHelper.getBlockStatusFromSymbol(
            myMarkingSymbol,
          ),
        );
        final secondRowFirstColumnMove = Move(
          row: secondRow,
          col: firstColumn,
          blockStatus: TicTacToeHelper.getBlockStatusFromSymbol(
            myMarkingSymbol,
          ),
        );
        final ticTacToe = TicTacToe(myMarkingSymbol: myMarkingSymbol);

        // Act
        ticTacToe.playMove(firstRowThirdColumnMove);
        ticTacToe.playMove(secondRowFirstColumnMove);

        // Assert
        for (int i = 0; i < ticTacToe.board.length; i++) {
          for (int j = 0; j < ticTacToe.board.length; j++) {
            if ((i == firstRow && j == thirdColumn) ||
                (i == secondRow && j == firstColumn)) {
              expect(
                ticTacToe.board[i][j].value.blockStatus,
                equals(
                  TicTacToeHelper.getBlockStatusFromSymbol(myMarkingSymbol),
                ),
              );
            } else {
              expect(ticTacToe.board[i][j].value.blockStatus, equals(none));
            }
          }
        }
      },
    );

    test(
      'play move in invalid block with CROSS marking as self',
      () {
        // Arrange
        final minusOneRow = -1;
        final thirdColumn = 3;
        final myMarkingSymbol = TicTacToeSymbol.CROSS;
        final none = BlockStatus.NONE;
        final invalidMove = Move(
          row: minusOneRow,
          col: thirdColumn,
          blockStatus:
              TicTacToeHelper.getBlockStatusFromSymbol(myMarkingSymbol),
        );
        final ticTacToe = TicTacToe(myMarkingSymbol: myMarkingSymbol);

        // Act
        final gameStatus = ticTacToe.playMove(invalidMove);

        // Assert
        expect(gameStatus.resultStatus, equals(GameResultStatus.CONTINUE));
        for (int i = 0; i < ticTacToe.board.length; i++) {
          for (int j = 0; j < ticTacToe.board.length; j++) {
            expect(ticTacToe.board[i][j].value.blockStatus, none);
          }
        }
      },
    );
  });

  group('Validate Row, Column and Diagonal', () {
    test('validate row with CROSS marking as self', () {
      // Arrange
      final firstRow = 0;
      final secondRow = 1;
      final myMarkingSymbol = TicTacToeSymbol.CROSS;
      final ticTacToe = TicTacToe(myMarkingSymbol: myMarkingSymbol);

      // Act
      for (int i = 0; i < ticTacToe.board.length; i++) {
        ticTacToe.board[firstRow][i].value.blockStatus = BlockStatus.CROSS;
      }
      final validRow = ticTacToe.isRowValid(firstRow);

      ticTacToe.board[secondRow][0].value.blockStatus = BlockStatus.CROSS;
      ticTacToe.board[secondRow][2].value.blockStatus = BlockStatus.CROSS;
      final invalidRow = ticTacToe.isRowValid(secondRow);

      // Assert
      expect(validRow, equals(true));
      expect(invalidRow, equals(false));
    });

    test('validate column with CROSS marking as self', () {
      // Arrange
      final secondColumn = 1;
      final thirdColumn = 2;
      final myMarkingSymbol = TicTacToeSymbol.CROSS;
      final ticTacToe = TicTacToe(myMarkingSymbol: myMarkingSymbol);

      // Act
      for (int i = 0; i < ticTacToe.board.length; i++) {
        ticTacToe.board[i][secondColumn].value.blockStatus = BlockStatus.CROSS;
      }
      final validColumn = ticTacToe.isColumnValid(secondColumn);

      ticTacToe.board[1][thirdColumn].value.blockStatus = BlockStatus.CROSS;
      ticTacToe.board[2][thirdColumn].value.blockStatus = BlockStatus.CROSS;
      final invalidColumn = ticTacToe.isColumnValid(thirdColumn);

      // Assert
      expect(validColumn, equals(true));
      expect(invalidColumn, equals(false));
    });

    test('validate diagonals with CROSS marking as self', () {
      // Arrange
      final firstRow = 0;
      final secondColumn = 1;
      final secondRow = 1;
      final thirdColumn = 2;

      final myMarkingSymbol = TicTacToeSymbol.CROSS;
      final ticTacToe = TicTacToe(myMarkingSymbol: myMarkingSymbol);

      // Act
      for (int i = 0, j = 0;
          i < ticTacToe.board.length && j < ticTacToe.board.length;
          i++, j++) {
        ticTacToe.board[i][j].value.blockStatus = BlockStatus.CROSS;
      }
      final validTopLeftToBottomRightDiagonal = ticTacToe.isDiagonalsValid();

      ticTacToe.resetGame();

      for (int i = ticTacToe.board.length - 1, j = 0;
          i >= 0 && j < ticTacToe.board.length;
          i--, j++) {
        ticTacToe.board[i][j].value.blockStatus = BlockStatus.CROSS;
      }
      final validBottomLeftToTopRightDiagonal = ticTacToe.isDiagonalsValid();

      ticTacToe.resetGame();

      ticTacToe.board[secondRow][secondColumn].value.blockStatus =
          BlockStatus.CROSS;
      ticTacToe.board[firstRow][thirdColumn].value.blockStatus =
          BlockStatus.CROSS;
      final invalidDiagonal = ticTacToe.isDiagonalsValid();

      // Assert
      expect(validTopLeftToBottomRightDiagonal, equals(true));
      expect(validBottomLeftToTopRightDiagonal, equals(true));
      expect(invalidDiagonal, equals(false));
    });
  });

  test('reset board', () {
    // Arrange
    final myMarkingSymbol = TicTacToeSymbol.CROSS;
    final ticTacToe = TicTacToe(myMarkingSymbol: myMarkingSymbol);

    // Act
    for (int i = 0; i < ticTacToe.board.length; i++) {
      for (int j = 0; j < ticTacToe.board.length; j++) {
        ticTacToe.board[i][j].value.blockStatus = BlockStatus.CROSS;
      }
    }
    bool boardContainsAnyMarkingBeforeReset = false;
    for (int i = 0; i < ticTacToe.board.length; i++) {
      for (int j = 0; j < ticTacToe.board.length; j++) {
        if (ticTacToe.board[i][j].value.blockStatus != BlockStatus.NONE) {
          boardContainsAnyMarkingBeforeReset = true;
          break;
        }
      }
    }

    ticTacToe.resetGame();
    bool boardContainsAnyMarkingAfterReset = false;
    for (int i = 0; i < ticTacToe.board.length; i++) {
      for (int j = 0; j < ticTacToe.board.length; j++) {
        if (ticTacToe.board[i][j].value.blockStatus != BlockStatus.NONE) {
          boardContainsAnyMarkingAfterReset = true;
          break;
        }
      }
    }

    // Assert
    expect(boardContainsAnyMarkingBeforeReset, equals(true));
    expect(boardContainsAnyMarkingAfterReset, equals(false));
  });

  group('Check Winner', () {
    test('CROSS symbol winner', () {
      // Arrange

      final myMarkingSymbol = TicTacToeSymbol.CROSS;
      final ticTacToe = TicTacToe(myMarkingSymbol: myMarkingSymbol);
      final lastPlayedRow = 0;
      final lastPlayedColumn = 1;
      /*
        X X O
        O X X
        O X O
      */

      // Act
      ticTacToe.board[0][0].value.blockStatus = BlockStatus.CROSS;
      ticTacToe.board[0][1].value.blockStatus = BlockStatus.CROSS;
      ticTacToe.board[0][2].value.blockStatus = BlockStatus.ZERO;

      ticTacToe.board[1][0].value.blockStatus = BlockStatus.ZERO;
      ticTacToe.board[1][1].value.blockStatus = BlockStatus.CROSS;
      ticTacToe.board[1][2].value.blockStatus = BlockStatus.CROSS;

      ticTacToe.board[2][0].value.blockStatus = BlockStatus.ZERO;
      ticTacToe.board[2][1].value.blockStatus = BlockStatus.CROSS;
      ticTacToe.board[2][2].value.blockStatus = BlockStatus.ZERO;

      final boardEvaluationStatus = ticTacToe.checkWinner(
        lastPlayedRow,
        lastPlayedColumn,
      );

      // Assert
      expect(boardEvaluationStatus.isTie, equals(false));
      expect(
        boardEvaluationStatus.winnerBlockStatus,
        equals(BlockStatus.CROSS),
      );
    });

    test('CIRCLE symbol winner', () {
      // Arrange
      final myMarkingSymbol = TicTacToeSymbol.CROSS;
      final ticTacToe = TicTacToe(myMarkingSymbol: myMarkingSymbol);
      final lastPlayedRow = 2;
      final lastPlayedColumn = 0;
      /*
        X X O
        O X X
        O O O
      */

      // Act
      ticTacToe.board[0][0].value.blockStatus = BlockStatus.CROSS;
      ticTacToe.board[0][1].value.blockStatus = BlockStatus.CROSS;
      ticTacToe.board[0][2].value.blockStatus = BlockStatus.ZERO;

      ticTacToe.board[1][0].value.blockStatus = BlockStatus.ZERO;
      ticTacToe.board[1][1].value.blockStatus = BlockStatus.CROSS;
      ticTacToe.board[1][2].value.blockStatus = BlockStatus.CROSS;

      ticTacToe.board[2][0].value.blockStatus = BlockStatus.ZERO;
      ticTacToe.board[2][1].value.blockStatus = BlockStatus.ZERO;
      ticTacToe.board[2][2].value.blockStatus = BlockStatus.ZERO;

      final boardEvaluationStatus = ticTacToe.checkWinner(
        lastPlayedRow,
        lastPlayedColumn,
      );

      // Assert
      expect(boardEvaluationStatus.isTie, equals(false));
      expect(
        boardEvaluationStatus.winnerBlockStatus,
        equals(BlockStatus.ZERO),
      );
    });

    test('tie', () {
      // Arrange

      final myMarkingSymbol = TicTacToeSymbol.CROSS;
      final ticTacToe = TicTacToe(myMarkingSymbol: myMarkingSymbol);
      final lastPlayedRow = 2;
      final lastPlayedColumn = 2;
      /*
        X O O
        O X X
        O X O
      */

      // Act
      ticTacToe.board[0][0].value.blockStatus = BlockStatus.CROSS;
      ticTacToe.board[0][1].value.blockStatus = BlockStatus.ZERO;
      ticTacToe.board[0][2].value.blockStatus = BlockStatus.ZERO;

      ticTacToe.board[1][0].value.blockStatus = BlockStatus.ZERO;
      ticTacToe.board[1][1].value.blockStatus = BlockStatus.CROSS;
      ticTacToe.board[1][2].value.blockStatus = BlockStatus.CROSS;

      ticTacToe.board[2][0].value.blockStatus = BlockStatus.ZERO;
      ticTacToe.board[2][1].value.blockStatus = BlockStatus.CROSS;
      ticTacToe.board[2][2].value.blockStatus = BlockStatus.ZERO;

      final boardEvaluationStatus = ticTacToe.checkWinner(
        lastPlayedRow,
        lastPlayedColumn,
      );

      // Assert
      expect(boardEvaluationStatus.isTie, equals(true));
      expect(
        boardEvaluationStatus.winnerBlockStatus,
        equals(null),
      );
    });
  });
}
