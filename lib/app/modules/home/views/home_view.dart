import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/app/modules/home/controllers/home_controller.dart';
import 'package:tic_tac_toe/app/utils/constants/app_colors.dart';
import 'package:tic_tac_toe/app/utils/constants/images.dart';
import 'package:tic_tac_toe/app/utils/constants/styles.dart';
import 'package:tic_tac_toe/app/utils/widgets/base_scaffold.dart';
import 'package:tic_tac_toe/app/utils/widgets/buttons/primary_button.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Images.ticTacToe,
            height: 136,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 60),
          PrimaryButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: AppColors.white,
                ),
                SizedBox(width: 12),
                Text(
                  'vs',
                  style: Styles.semibold(16, AppColors.white),
                ),
                SizedBox(width: 12),
                Icon(
                  Icons.computer,
                  color: AppColors.white,
                ),
              ],
            ),
            onTap: controller.playHumanVSComputer,
            width: 240,
            imagePath: Images.play,
            imageWidth: 16,
            imageHeight: 20,
          ),
          SizedBox(height: 28),
          PrimaryButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: AppColors.white,
                ),
                SizedBox(width: 12),
                Text(
                  'vs',
                  style: Styles.semibold(16, AppColors.white),
                ),
                SizedBox(width: 12),
                Icon(
                  Icons.person,
                  color: AppColors.white,
                ),
              ],
            ),
            onTap: controller.playMultiplayer,
            width: 240,
            imagePath: Images.multiplayer,
            imageWidth: 26,
            imageHeight: 26,
          ),
          SizedBox(height: 28),
          PrimaryButton(
            text: 'How to play',
            onTap: controller.didTapHowToPlay,
            width: 240,
            imagePath: Images.help,
            imageWidth: 24,
            imageHeight: 24,
          ),
        ],
      ),
    );
  }
}
