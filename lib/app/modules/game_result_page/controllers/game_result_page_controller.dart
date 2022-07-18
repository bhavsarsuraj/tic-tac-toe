import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/app/modules/tic_tac_toe_play_page/controllers/tic_tac_toe_play_page_controller.dart';
import 'package:tic_tac_toe/app/routes/app_pages.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';

class GameResultPageArguments {
  final GameResult gameResult;
  final bool isOpponentRobot;
  final TicTacToeSymbol mySymbol;
  final int myWins;
  final int opponentWins;
  GameResultPageArguments({
    required this.gameResult,
    required this.isOpponentRobot,
    required this.mySymbol,
    required this.myWins,
    required this.opponentWins,
  });
}

class GameResultPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final GameResultPageArguments? arguments;

  GameResultPageController({this.arguments});

  late AnimationController animationController;

  final _animationShown = true.obs;
  bool get animationShown => this._animationShown.value;
  set animationShown(bool value) => this._animationShown.value = value;

  bool _isValid = true;

  @override
  void onInit() {
    configure();
    super.onInit();
  }

  void configure() {
    animationController = AnimationController(vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) onAnimationCompletion();
      });
    _isValid = arguments != null && arguments is GameResultPageArguments;
    if (!_isValid) {
      return;
    }
    if (arguments!.gameResult == GameResult.WON ||
        (!arguments!.isOpponentRobot &&
            arguments!.gameResult == GameResult.LOST)) {
      animationShown = false;
    }
  }

  @override
  void onReady() {
    if (!_isValid) {
      Get.back();
      return;
    }
    super.onReady();
  }

  void didTapReset() async {
    Get.offNamed(
      Routes.TIC_TAC_TOE_PLAY_PAGE,
      arguments: TicTacToePlayPageArguments(
        // The person with CROSS symbol will play first move
        isMyTurnFirst:
            arguments!.mySymbol == TicTacToeSymbol.CROSS ? true : false,
        isOpponentRobot: arguments!.isOpponentRobot,
        myPlayingSymbol: arguments!.mySymbol,
        myWins: arguments!.myWins,
        opponentWins: arguments!.opponentWins,
      ),
    );
  }

  void didTapHome() {
    Get.offAllNamed(Routes.HOME);
  }

  void onAnimationCompletion() {
    animationShown = true;
  }
}
