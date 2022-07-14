import 'package:tic_tac_toe/app/utils/enums.dart';

class Move {
  final int row;
  final int col;
  final BlockStatus blockStatus;
  Move({
    required this.row,
    required this.col,
    required this.blockStatus,
  });
}
