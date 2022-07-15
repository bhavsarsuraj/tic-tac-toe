import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app/data/models/tic_tac_toe/tic_tac_toe_board_block.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';

class TicTacToeBlockView extends StatelessWidget {
  final TicTacToeBoardBlock block;
  final VoidCallback onTap;
  final Color backgroundColor;
  final double? width;
  final double? height;
  const TicTacToeBlockView({
    Key? key,
    required this.block,
    required this.onTap,
    this.backgroundColor = Colors.white,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            width: 1,
            color: Colors.black,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  String get text {
    switch (block.blockStatus) {
      case BlockStatus.CIRCLE:
        return 'O';
      case BlockStatus.CROSS:
        return 'X';
      case BlockStatus.NONE:
        return '';
    }
  }
}
