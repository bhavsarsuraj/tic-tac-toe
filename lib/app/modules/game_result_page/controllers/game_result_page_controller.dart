import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/app/routes/app_pages.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';

class GameResultPageArguments {
  final GameResult gameResult;
  final bool isOpponentRobot;

  GameResultPageArguments({
    required this.gameResult,
    required this.isOpponentRobot,
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
    if (arguments!.gameResult == GameResult.WON) {
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

  void didTapReset() {
    Get.offNamed(Routes.CUSTOMIZE_GAME_PAGE);
  }

  void didTapHome() {
    Get.offAllNamed(Routes.HOME);
  }

  void onAnimationCompletion() {
    animationShown = true;
  }
}
