import 'package:get/get.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';

class TicTacToeBoardBlock {
  final _blockStatus = BlockStatus.none.obs;
  BlockStatus get blockStatus => this._blockStatus.value;
  set blockStatus(BlockStatus value) => this._blockStatus.value = value;

  TicTacToeBoardBlock();

  void resetBlockStatus() {
    blockStatus = BlockStatus.none;
  }
}
