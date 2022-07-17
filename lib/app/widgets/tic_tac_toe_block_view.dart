import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app/data/models/tic_tac_toe/tic_tac_toe_board_block.dart';
import 'package:tic_tac_toe/app/utils/Helpers/tic_tac_toe_helper.dart';
import 'package:tic_tac_toe/app/utils/constants/app_colors.dart';
import 'package:tic_tac_toe/app/utils/constants/images.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';

class TicTacToeBlockView extends StatelessWidget {
  final TicTacToeBoardBlock block;
  final VoidCallback onTap;
  final Color backgroundColor;
  final double? width;
  final double? height;
  final int row;
  final int col;
  final Difficulty difficulty;
  const TicTacToeBlockView({
    Key? key,
    required this.block,
    required this.onTap,
    this.backgroundColor = Colors.white,
    required this.row,
    required this.col,
    required this.difficulty,
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
        margin: EdgeInsets.zero,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(border: border),
        child: Center(
          child: _Mark(
            block: block,
          ),
        ),
      ),
    );
  }

  Border? get border {
    final boardSize = TicTacToeHelper.getBoardSizeFromDifficulty(difficulty);
    final borderSide = BorderSide(color: AppColors.brown);
    if (row == 0) {
      if (col == 0) {
        return Border(
          bottom: borderSide,
          right: borderSide,
        );
      } else if (col == boardSize - 1) {
        return Border(
          left: borderSide,
          bottom: borderSide,
        );
      } else {
        return Border(
          left: borderSide,
          bottom: borderSide,
          right: borderSide,
        );
      }
    } else if (row == boardSize - 1) {
      if (col == 0) {
        return Border(
          top: borderSide,
          right: borderSide,
        );
      } else if (col == boardSize - 1) {
        return Border(
          top: borderSide,
          left: borderSide,
        );
      } else {
        return Border(
          top: borderSide,
          left: borderSide,
          right: borderSide,
        );
      }
    } else {
      if (col == 0) {
        return Border(
          top: borderSide,
          right: borderSide,
          bottom: borderSide,
        );
      } else if (col == boardSize - 1) {
        return Border(
          top: borderSide,
          left: borderSide,
          bottom: borderSide,
        );
      } else {
        return Border(
          top: borderSide,
          left: borderSide,
          right: borderSide,
          bottom: borderSide,
        );
      }
    }
  }
}

class _Mark extends StatelessWidget {
  final TicTacToeBoardBlock block;
  const _Mark({Key? key, required this.block}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (block.blockStatus) {
      case BlockStatus.ZERO:
        return Image.asset(
          Images.zero,
          fit: BoxFit.contain,
        );
      case BlockStatus.CROSS:
        return Image.asset(
          Images.cross,
          fit: BoxFit.contain,
        );
      case BlockStatus.NONE:
        return Container();
    }
  }
}
