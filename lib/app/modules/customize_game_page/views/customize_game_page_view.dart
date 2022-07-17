import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/app/utils/constants/app_colors.dart';
import 'package:tic_tac_toe/app/utils/constants/images.dart';
import 'package:tic_tac_toe/app/utils/constants/styles.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';
import 'package:tic_tac_toe/app/utils/widgets/base_scaffold.dart';
import 'package:tic_tac_toe/app/utils/widgets/buttons/primary_button.dart';
import '../controllers/customize_game_page_controller.dart';

class CustomizeGamePageView extends GetView<CustomizeGamePageController> {
  const CustomizeGamePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      titleText: 'Customize Game',
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 72,
              bottom: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ChooseDifficulty(),
                SizedBox(height: 54),
                _ChooseSymbol(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 48,
            ),
            child: PrimaryButton(
              width: Get.width,
              text: 'Continue',
              onTap: controller.didTapContinue,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChooseDifficulty extends GetView<CustomizeGamePageController> {
  const _ChooseDifficulty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Difficulty',
          style: Styles.semibold(16, AppColors.black),
        ),
        SizedBox(height: 16),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _DifficultyView(
                difficulty: Difficulty.EASY,
                isSelected: controller.selectedDifficulty == Difficulty.EASY,
                onTap: () => controller.didChangeDifficulty(Difficulty.EASY),
              ),
              _DifficultyView(
                difficulty: Difficulty.MEDIUM,
                isSelected: controller.selectedDifficulty == Difficulty.MEDIUM,
                onTap: () => controller.didChangeDifficulty(Difficulty.MEDIUM),
              ),
              _DifficultyView(
                difficulty: Difficulty.HARD,
                isSelected: controller.selectedDifficulty == Difficulty.HARD,
                onTap: () => controller.didChangeDifficulty(Difficulty.HARD),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _DifficultyView extends StatelessWidget {
  final Difficulty difficulty;
  final bool isSelected;
  final VoidCallback onTap;

  const _DifficultyView({
    Key? key,
    required this.difficulty,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.red : Colors.transparent,
            width: isSelected ? 1 : 0,
          ),
          borderRadius:
              isSelected ? BorderRadius.circular(12) : BorderRadius.zero,
        ),
        child: Text(
          difficultyString,
          style: isSelected
              ? Styles.semibold(22, AppColors.red)
              : Styles.semibold(
                  22,
                  AppColors.brown.withOpacity(0.5),
                ),
        ),
      ),
    );
  }

  String get difficultyString {
    switch (difficulty) {
      case Difficulty.EASY:
        return 'Easy';
      case Difficulty.MEDIUM:
        return 'Medium';
      case Difficulty.HARD:
        return 'Hard';
    }
  }
}

class _ChooseSymbol extends GetView<CustomizeGamePageController> {
  const _ChooseSymbol({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Symbol',
          style: Styles.semibold(16, AppColors.black),
        ),
        SizedBox(height: 16),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _SymbolView(
                symbol: TicTacToeSymbol.CROSS,
                isSelected:
                    controller.selectedMarkingSymbol == TicTacToeSymbol.CROSS,
                onTap: () => controller.didSelectSymbol(TicTacToeSymbol.CROSS),
              ),
              SizedBox(width: 30),
              _SymbolView(
                symbol: TicTacToeSymbol.ZERO,
                isSelected:
                    controller.selectedMarkingSymbol == TicTacToeSymbol.ZERO,
                onTap: () => controller.didSelectSymbol(TicTacToeSymbol.ZERO),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SymbolView extends StatelessWidget {
  final TicTacToeSymbol symbol;
  final bool isSelected;
  final VoidCallback onTap;

  const _SymbolView({
    Key? key,
    required this.symbol,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.red : Colors.transparent,
            width: isSelected ? 1 : 0,
          ),
          color: !isSelected
              ? Color(0xFFFFECDC).withOpacity(0.5)
              : Colors.transparent,
          borderRadius:
              isSelected ? BorderRadius.circular(12) : BorderRadius.zero,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Container(
                color: !isSelected
                    ? Color(0xFFFFECDC).withOpacity(0.5)
                    : Colors.transparent,
              ),
            ),
            Center(
              child: Image.asset(
                imagePath,
                height: 54,
                width: 48,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get imagePath {
    switch (symbol) {
      case TicTacToeSymbol.CROSS:
        return Images.cross;
      case TicTacToeSymbol.ZERO:
        return Images.zero;
    }
  }
}
