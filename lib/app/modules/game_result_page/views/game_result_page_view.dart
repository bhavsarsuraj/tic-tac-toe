import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe/app/utils/constants/animations.dart';
import 'package:tic_tac_toe/app/utils/constants/app_colors.dart';
import 'package:tic_tac_toe/app/utils/constants/images.dart';
import 'package:tic_tac_toe/app/utils/constants/styles.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';
import 'package:tic_tac_toe/app/utils/widgets/base_scaffold.dart';
import 'package:tic_tac_toe/app/utils/widgets/buttons/primary_button.dart';
import 'package:tic_tac_toe/app/widgets/scores_view.dart';
import '../controllers/game_result_page_controller.dart';

class GameResultPageView extends GetView<GameResultPageController> {
  const GameResultPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _Scaffold(),
        Obx(() {
          if (!controller.animationShown) {
            return Lottie.asset(
              Animations.congratulations,
              controller: controller.animationController,
              fit: BoxFit.fill,
              height: Get.height,
              repeat: false,
              onLoaded: (composition) {
                controller.animationController
                  ..duration = composition.duration
                  ..forward();
              },
            );
          } else {
            return Container();
          }
        }),
      ],
    );
  }
}

class _Scaffold extends GetView<GameResultPageController> {
  const _Scaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      customAppBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.scaffoldBackground,
        leadingWidth: 80,
        leading: IconButton(
          onPressed: controller.didTapHome,
          icon: Image.asset(
            Images.home,
            height: 32,
            width: 32,
            color: AppColors.brown,
          ),
        ),
        actions: [
          IconButton(
            onPressed: controller.didTapReset,
            icon: Image.asset(
              Images.reset,
              height: 32,
              width: 32,
              color: AppColors.brown,
            ),
          ),
          SizedBox(width: 18),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              SizedBox(height: 32),
              _ResultImage(),
              SizedBox(height: 16),
              _ResultText(),
              _ResultSubtitle(),
              SizedBox(height: 52),
              PrimaryButton(
                width: 240,
                text: 'Play Again',
                onTap: () {
                  controller.didTapReset();
                },
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScoresView(
                isOpponentRobot: controller.arguments!.isOpponentRobot,
                myWins: controller.arguments!.myWins,
                opponentWins: controller.arguments!.opponentWins,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ResultImage extends GetView<GameResultPageController> {
  const _ResultImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      height: 160,
      fit: BoxFit.contain,
    );
  }

  String get imagePath {
    switch (controller.arguments!.gameResult) {
      case GameResult.WON:
        return Images.congratulations;
      case GameResult.LOST:
        return controller.arguments!.isOpponentRobot
            ? Images.robotWon
            : Images.congratulations;
      case GameResult.DRAW:
        return Images.tied;
    }
  }
}

class _ResultText extends GetView<GameResultPageController> {
  const _ResultText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        result,
        style: Styles.semibold(
          40,
          AppColors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  String get result {
    switch (controller.arguments!.gameResult) {
      case GameResult.WON:
        return 'Congrats!\nYou Won';
      case GameResult.LOST:
        return controller.arguments!.isOpponentRobot
            ? 'HAHAHAHA!'
            : 'Your Friend Won';
      case GameResult.DRAW:
        return 'Match Tied!';
    }
  }
}

class _ResultSubtitle extends GetView<GameResultPageController> {
  const _ResultSubtitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return description != null
        ? Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 8.0,
              right: 20,
            ),
            child: Text(
              description!,
              style: Styles.medium(
                16,
                AppColors.black,
              ),
              textAlign: TextAlign.center,
            ),
          )
        : Container();
  }

  String? get description {
    switch (controller.arguments!.gameResult) {
      case GameResult.WON:
        return null;
      case GameResult.LOST:
        if (controller.arguments!.isOpponentRobot) {
          return 'I won, this is a good beginning of my plan to dominate the human race.';
        } else {
          return 'Better Luck Next Time 😜';
        }
      case GameResult.DRAW:
        return 'Let\'s try once again';
    }
  }
}
