import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/app/utils/constants/app_colors.dart';
import 'package:tic_tac_toe/app/utils/constants/images.dart';
import 'package:tic_tac_toe/app/utils/constants/styles.dart';
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
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScoresView(
                  myWins: controller.myWins,
                  opponentWins: controller.opponentWins,
                  isOpponentRobot: controller.arguments!.isOpponentRobot,
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
        text,
        style: Styles.semibold(
          24,
          AppColors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  String get text {
    if (controller.arguments!.isOpponentRobot) {
      if (controller.isMyTurn) {
        return 'Your Turn';
      } else {
        return 'Robot’s Turn';
      }
    } else {
      if (controller.isMyTurn) {
        return 'Your Turn';
      } else {
        return 'Your Friend\'s Turn';
      }
    }
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
                  onTap: () => _onTapBlock(row, col),
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

  void _onTapBlock(int row, int col) {
    if (controller.arguments!.isOpponentRobot) {
      if (controller.isMyTurn) {
        controller.onTapBlock(row, col);
      }
    } else {
      controller.onTapBlock(row, col);
    }
  }
}
