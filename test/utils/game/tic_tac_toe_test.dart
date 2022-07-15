import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/app/data/models/tic_tac_toe/move.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';
import 'package:tic_tac_toe/app/utils/game/tic_tac_toe.dart';

void main() {
  group('Initialise', () {
    test('initialising board with EASY difficulty and CIRCLE marking as self',
        () {
      // Arrange
      final easy = Difficulty.EASY;
      final myMarkingSymbol = BlockStatus.CIRCLE;

      // Act
      final ticTacToe = TicTacToe(
        difficulty: easy,
        myMarkingSymbol: myMarkingSymbol,
      );

      // Assert
      expect(ticTacToe.board.length, equals(3));
      for (int i = 0; i < ticTacToe.board.length; i++) {
        expect(ticTacToe.board[i].length, equals(3));
      }
    });

    test('initialising board with MEDIUM difficulty and CIRCLE marking as self',
        () {
      // Arrange
      final medium = Difficulty.MEDIUM;
      final myMarkingSymbol = BlockStatus.CIRCLE;

      // Act
      final ticTacToe = TicTacToe(
        difficulty: medium,
        myMarkingSymbol: myMarkingSymbol,
      );

      // Assert
      expect(ticTacToe.board.length, equals(4));
      for (int i = 0; i < ticTacToe.board.length; i++) {
        expect(ticTacToe.board[i].length, equals(4));
      }
    });

    test('initialising board with HARD difficulty and CIRCLE marking as self',
        () {
      // Arrange
      final hard = Difficulty.HARD;
      final myMarkingSymbol = BlockStatus.CIRCLE;

      // Act
      final ticTacToe = TicTacToe(
        difficulty: hard,
        myMarkingSymbol: myMarkingSymbol,
      );

      // Assert
      expect(ticTacToe.board.length, equals(5));
      for (int i = 0; i < ticTacToe.board.length; i++) {
        expect(ticTacToe.board[i].length, equals(5));
      }
    });
  });

  group('Opponent marking symbol', () {
    test('initialising my marking symbol with CIRCLE in EASY difficulty', () {
      // Arrange
      final myMarkingSymbol = BlockStatus.CIRCLE;
      final easy = Difficulty.EASY;

      // Act
      final ticTacToe = TicTacToe(
        difficulty: easy,
        myMarkingSymbol: myMarkingSymbol,
      );

      // Assert
      expect(
        ticTacToe.opponentMarkingSymbol,
        equals(BlockStatus.CROSS),
      );
    });

    test('initialising my marking symbol with CROSS in EASY difficulty', () {
      // Arrange
      final myMarkingSymbol = BlockStatus.CROSS;
      final easy = Difficulty.EASY;

      // Act
      final ticTacToe = TicTacToe(
        difficulty: easy,
        myMarkingSymbol: myMarkingSymbol,
      );

      // Assert
      expect(
        ticTacToe.opponentMarkingSymbol,
        equals(BlockStatus.CIRCLE),
      );
    });
  });

  group('Play Move', () {
    test(
      'play move in specific valid block with EASY difficulty and CROSS marking as self',
      () {
        // Arrange
        final firstRow = 0;
        final thirdColumn = 2;
        final secondRow = 1;
        final firstColumn = 0;
        final easy = Difficulty.EASY;
        final myMarkingSymbol = BlockStatus.CROSS;
        final none = BlockStatus.NONE;
        final firstRowThirdColumnMove = Move(
          row: firstRow,
          col: thirdColumn,
          blockStatus: myMarkingSymbol,
        );
        final secondRowFirstColumnMove = Move(
          row: secondRow,
          col: firstColumn,
          blockStatus: myMarkingSymbol,
        );
        final ticTacToe = TicTacToe(
          difficulty: easy,
          myMarkingSymbol: myMarkingSymbol,
        );

        // Act
        ticTacToe.playMove(firstRowThirdColumnMove);
        ticTacToe.playMove(secondRowFirstColumnMove);

        // Assert
        for (int i = 0; i < ticTacToe.board.length; i++) {
          for (int j = 0; j < ticTacToe.board.length; j++) {
            if ((i == firstRow && j == thirdColumn) ||
                (i == secondRow && j == firstColumn)) {
              expect(ticTacToe.board[i][j].value.blockStatus,
                  equals(myMarkingSymbol));
            } else {
              expect(ticTacToe.board[i][j].value.blockStatus, equals(none));
            }
          }
        }
      },
    );

    test(
      'play move in invalid block with EASY difficulty and CROSS marking as self',
      () {
        // Arrange
        final minusOneRow = -1;
        final thirdColumn = 3;
        final easy = Difficulty.EASY;
        final myMarkingSymbol = BlockStatus.CROSS;
        final none = BlockStatus.NONE;
        final invalidMove = Move(
          row: minusOneRow,
          col: thirdColumn,
          blockStatus: myMarkingSymbol,
        );
        final ticTacToe = TicTacToe(
          difficulty: easy,
          myMarkingSymbol: myMarkingSymbol,
        );

        // Act
        final gameStatus = ticTacToe.playMove(invalidMove);

        // Assert
        expect(gameStatus, GameStatus.CONTINUE);
        for (int i = 0; i < ticTacToe.board.length; i++) {
          for (int j = 0; j < ticTacToe.board.length; j++) {
            expect(ticTacToe.board[i][j].value.blockStatus, none);
          }
        }
      },
    );
  });

  group('Validate Row, Column and Diagonal', () {
    test('validate row with EASY difficulty and CROSS marking as self', () {
      // Arrange
      final firstRow = 0;
      final secondRow = 1;
      final easy = Difficulty.EASY;
      final myMarkingSymbol = BlockStatus.CROSS;
      final ticTacToe = TicTacToe(
        difficulty: easy,
        myMarkingSymbol: myMarkingSymbol,
      );

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

    test('validate column with EASY difficulty and CROSS marking as self', () {
      // Arrange
      final secondColumn = 1;
      final thirdColumn = 2;
      final easy = Difficulty.EASY;
      final myMarkingSymbol = BlockStatus.CROSS;
      final ticTacToe = TicTacToe(
        difficulty: easy,
        myMarkingSymbol: myMarkingSymbol,
      );

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

    test('validate diagonals with EASY difficulty and CROSS marking as self',
        () {
      // Arrange
      final firstRow = 0;
      final secondColumn = 1;
      final secondRow = 1;
      final thirdColumn = 2;
      final easy = Difficulty.EASY;
      final myMarkingSymbol = BlockStatus.CROSS;
      final ticTacToe = TicTacToe(
        difficulty: easy,
        myMarkingSymbol: myMarkingSymbol,
      );

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
    final easy = Difficulty.EASY;
    final myMarkingSymbol = BlockStatus.CROSS;
    final ticTacToe = TicTacToe(
      difficulty: easy,
      myMarkingSymbol: myMarkingSymbol,
    );

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
    test('CROSS symbol winner with EASY difficulty', () {
      // Arrange
      final easy = Difficulty.EASY;
      final myMarkingSymbol = BlockStatus.CROSS;
      final ticTacToe = TicTacToe(
        difficulty: easy,
        myMarkingSymbol: myMarkingSymbol,
      );
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
      ticTacToe.board[0][2].value.blockStatus = BlockStatus.CIRCLE;

      ticTacToe.board[1][0].value.blockStatus = BlockStatus.CIRCLE;
      ticTacToe.board[1][1].value.blockStatus = BlockStatus.CROSS;
      ticTacToe.board[1][2].value.blockStatus = BlockStatus.CROSS;

      ticTacToe.board[2][0].value.blockStatus = BlockStatus.CIRCLE;
      ticTacToe.board[2][1].value.blockStatus = BlockStatus.CROSS;
      ticTacToe.board[2][2].value.blockStatus = BlockStatus.CIRCLE;

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

    test('CIRCLE symbol winner with EASY difficulty', () {
      // Arrange
      final easy = Difficulty.EASY;
      final myMarkingSymbol = BlockStatus.CROSS;
      final ticTacToe = TicTacToe(
        difficulty: easy,
        myMarkingSymbol: myMarkingSymbol,
      );
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
      ticTacToe.board[0][2].value.blockStatus = BlockStatus.CIRCLE;

      ticTacToe.board[1][0].value.blockStatus = BlockStatus.CIRCLE;
      ticTacToe.board[1][1].value.blockStatus = BlockStatus.CROSS;
      ticTacToe.board[1][2].value.blockStatus = BlockStatus.CROSS;

      ticTacToe.board[2][0].value.blockStatus = BlockStatus.CIRCLE;
      ticTacToe.board[2][1].value.blockStatus = BlockStatus.CIRCLE;
      ticTacToe.board[2][2].value.blockStatus = BlockStatus.CIRCLE;

      final boardEvaluationStatus = ticTacToe.checkWinner(
        lastPlayedRow,
        lastPlayedColumn,
      );

      // Assert
      expect(boardEvaluationStatus.isTie, equals(false));
      expect(
        boardEvaluationStatus.winnerBlockStatus,
        equals(BlockStatus.CIRCLE),
      );
    });

    test('tie with EASY difficulty', () {
      // Arrange
      final easy = Difficulty.EASY;
      final myMarkingSymbol = BlockStatus.CROSS;
      final ticTacToe = TicTacToe(
        difficulty: easy,
        myMarkingSymbol: myMarkingSymbol,
      );
      final lastPlayedRow = 2;
      final lastPlayedColumn = 2;
      /*
        X O O
        O X X
        O X O
      */

      // Act
      ticTacToe.board[0][0].value.blockStatus = BlockStatus.CROSS;
      ticTacToe.board[0][1].value.blockStatus = BlockStatus.CIRCLE;
      ticTacToe.board[0][2].value.blockStatus = BlockStatus.CIRCLE;

      ticTacToe.board[1][0].value.blockStatus = BlockStatus.CIRCLE;
      ticTacToe.board[1][1].value.blockStatus = BlockStatus.CROSS;
      ticTacToe.board[1][2].value.blockStatus = BlockStatus.CROSS;

      ticTacToe.board[2][0].value.blockStatus = BlockStatus.CIRCLE;
      ticTacToe.board[2][1].value.blockStatus = BlockStatus.CROSS;
      ticTacToe.board[2][2].value.blockStatus = BlockStatus.CIRCLE;

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
