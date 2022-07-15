import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/app/widgets/tic_tac_toe_block_view.dart';
import '../controllers/tic_tac_toe_play_page_controller.dart';

class TicTacToePlayPageView extends GetView<TicTacToePlayPageController> {
  const TicTacToePlayPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final padding = 24.0;
    double size = min(Get.height, Get.width);
    size = size - 2 * padding;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic-Tac-Toe'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(padding),
          height: size,
          width: size,
          child: AspectRatio(
            aspectRatio: 1,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: controller.boardSize,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
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
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
