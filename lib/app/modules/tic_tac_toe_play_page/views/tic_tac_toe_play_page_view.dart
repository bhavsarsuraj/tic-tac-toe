import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/app/utils/constants/app_colors.dart';
import 'package:tic_tac_toe/app/utils/constants/images.dart';
import 'package:tic_tac_toe/app/utils/constants/styles.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';
import 'package:tic_tac_toe/app/utils/widgets/base_scaffold.dart';
import 'package:tic_tac_toe/app/widgets/scores_view.dart';
import 'package:tic_tac_toe/app/widgets/tic_tac_toe_block_view.dart';
import '../controllers/tic_tac_toe_play_page_controller.dart';

class TicTacToePlayPageView extends GetView<TicTacToePlayPageController> {
  const TicTacToePlayPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final padding = 20.0;
    return BaseScaffold(
      actions: [
        IconButton(
          onPressed: controller.didTapResetGame,
          icon: Image.asset(Images.reset),
        ),
      ],
      body: WillPopScope(
        onWillPop: controller.onWillPop,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: padding,
                left: padding,
                bottom: 52,
                right: 26,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _PlayerTurn(),
                  SizedBox(height: 20),
                  _PlayingBoard(padding: padding),
                  SizedBox(height: 32),
                  _DifficultyMode(),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScoresView(
                  myScore: 0,
                  opponentScore: 1,
                  isOpponentRobot: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PlayerTurn extends GetView<TicTacToePlayPageController> {
  const _PlayerTurn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        controller.isMyTurn ? 'Your Turn' : 'Robot’s Turn',
        style: Styles.semibold(
          24,
          AppColors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _PlayingBoard extends GetView<TicTacToePlayPageController> {
  final double padding;
  const _PlayingBoard({
    Key? key,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = min(Get.height, Get.width);
    size = size - 2 * padding;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.boardBackground,
        boxShadow: [
          BoxShadow(
            offset: Offset(12, 12),
            color: AppColors.black,
          ),
        ],
      ),
      height: size,
      width: size,
      child: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: GridView.builder(
            padding: EdgeInsets.all(20),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: controller.boardSize,
              childAspectRatio: 1,
            ),
            itemCount: controller.boardSize * controller.boardSize,
            itemBuilder: (context, index) {
              final row = index ~/ controller.boardSize;
              final col = index % controller.boardSize;
              return Obx(
                () => TicTacToeBlockView(
                  block: controller.ticTacToe.board[row][col].value,
                  onTap: () => controller.onTapBlock(row, col),
                  difficulty: controller.arguments!.difficulty,
                  row: row,
                  col: col,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DifficultyMode extends GetView<TicTacToePlayPageController> {
  const _DifficultyMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Mode: $difficultyString',
      style: Styles.medium(
        16,
        AppColors.brown.withOpacity(0.8),
      ),
      textAlign: TextAlign.center,
    );
  }

  String get difficultyString {
    switch (controller.arguments!.difficulty) {
      case Difficulty.EASY:
        return 'Easy';
      case Difficulty.MEDIUM:
        return 'Medium';
      case Difficulty.HARD:
        return 'Hard';
    }
  }
}
