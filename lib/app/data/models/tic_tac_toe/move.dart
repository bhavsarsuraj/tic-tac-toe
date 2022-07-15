import 'package:tic_tac_toe/app/utils/enums.dart';

class Move {
  int row;
  int col;
  BlockStatus blockStatus;
  Move({
    required this.row,
    required this.col,
    this.blockStatus = BlockStatus.NONE,
  });
}
