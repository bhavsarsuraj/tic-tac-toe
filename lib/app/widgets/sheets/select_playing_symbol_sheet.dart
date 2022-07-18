import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/app/utils/constants/app_colors.dart';
import 'package:tic_tac_toe/app/utils/constants/images.dart';
import 'package:tic_tac_toe/app/utils/constants/styles.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';
import 'package:tic_tac_toe/app/utils/widgets/base_sheet.dart';
import 'package:tic_tac_toe/app/utils/widgets/buttons/primary_button.dart';

class SelectPlayingSymbolSheetController extends GetxController {
  TicTacToeSymbol selectedMarkingSymbol = TicTacToeSymbol.CROSS;

  @override
  void onInit() {
    super.onInit();
  }

  void didSelectSymbol(TicTacToeSymbol symbol) {
    selectedMarkingSymbol = symbol;
    update();
  }

  void didTapContinue() {
    Get.back(result: selectedMarkingSymbol);
  }
}

class SelectPlayingSymbolSheet extends StatelessWidget {
  const SelectPlayingSymbolSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectPlayingSymbolSheetController>(
      init: SelectPlayingSymbolSheetController(),
      builder: (controller) {
        return BaseSheet(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose Symbol',
                  style: Styles.semibold(16, AppColors.black),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _SymbolView(
                      symbol: TicTacToeSymbol.CROSS,
                      isSelected: controller.selectedMarkingSymbol ==
                          TicTacToeSymbol.CROSS,
                      onTap: () =>
                          controller.didSelectSymbol(TicTacToeSymbol.CROSS),
                    ),
                    SizedBox(width: 30),
                    _SymbolView(
                      symbol: TicTacToeSymbol.ZERO,
                      isSelected: controller.selectedMarkingSymbol ==
                          TicTacToeSymbol.ZERO,
                      onTap: () =>
                          controller.didSelectSymbol(TicTacToeSymbol.ZERO),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                PrimaryButton(
                  width: Get.width,
                  text: 'Continue',
                  onTap: controller.didTapContinue,
                ),
              ],
            ),
          ),
        );
      },
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
