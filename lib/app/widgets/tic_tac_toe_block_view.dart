import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app/data/models/tic_tac_toe/tic_tac_toe_board_block.dart';
import 'package:tic_tac_toe/app/utils/constants/app_colors.dart';
import 'package:tic_tac_toe/app/utils/constants/images.dart';
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
          color: AppColors.boardBackground,
        ),
        child: Center(
          child: mark,
        ),
      ),
    );
  }

  Widget get mark {
    switch (block.blockStatus) {
      case BlockStatus.ZERO:
        return Image.asset(
          Images.zero,
          height: 70,
          width: 64,
        );
      case BlockStatus.CROSS:
        return Image.asset(
          Images.cross,
          fit: BoxFit.cover,
          height: 70,
          width: 64,
        );
      case BlockStatus.NONE:
        return Container();
    }
  }
}
