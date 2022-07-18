import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/app/utils/Helpers/tic_tac_toe_helper.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';

void main() {
  test('cross block status', () {
    // Arrange
    final crossSymbol = TicTacToeSymbol.CROSS;
    final zeroSymbol = TicTacToeSymbol.ZERO;
    // Act
    final crossBlockStatus =
        TicTacToeHelper.getBlockStatusFromSymbol(crossSymbol);
    final zeroBlockStatus =
        TicTacToeHelper.getBlockStatusFromSymbol(zeroSymbol);

    // Assert
    expect(crossBlockStatus, equals(BlockStatus.CROSS));
    expect(zeroBlockStatus, equals(BlockStatus.ZERO));
  });
}
