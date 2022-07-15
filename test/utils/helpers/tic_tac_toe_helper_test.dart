import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/app/utils/Helpers/tic_tac_toe_helper.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';

void main() {
  test('board size', () {
    // Arrange
    final easy = Difficulty.EASY;
    final medium = Difficulty.MEDIUM;
    final hard = Difficulty.HARD;

    // Act
    final easyDifficulty = TicTacToeHelper.getBoardSizeFromDifficulty(easy);
    final mediumDifficulty = TicTacToeHelper.getBoardSizeFromDifficulty(medium);
    final hardDifficulty = TicTacToeHelper.getBoardSizeFromDifficulty(hard);

    // Assert
    expect(easyDifficulty, equals(3));
    expect(mediumDifficulty, equals(4));
    expect(hardDifficulty, equals(5));
  });
}
