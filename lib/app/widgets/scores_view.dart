import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app/utils/constants/app_colors.dart';
import 'package:tic_tac_toe/app/utils/constants/images.dart';
import 'package:tic_tac_toe/app/utils/constants/styles.dart';

class ScoresView extends StatelessWidget {
  final num myScore;
  final num opponentScore;
  final bool isOpponentRobot;
  const ScoresView({
    Key? key,
    required this.myScore,
    required this.opponentScore,
    required this.isOpponentRobot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _PLayerScoreView(
          imagePath: Images.hand_wave,
          title: 'My Score',
          score: 0,
        ),
        _PLayerScoreView(
          imagePath: isOpponentRobot ? Images.robot : Images.person2,
          title: isOpponentRobot ? 'Robot Score' : 'Person 2 Score',
          score: 1,
        ),
      ],
    );
  }
}

class _PLayerScoreView extends StatelessWidget {
  final String imagePath;
  final String title;
  final num score;
  const _PLayerScoreView({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          top: 24,
          bottom: 36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  height: 24,
                  width: 24,
                ),
                SizedBox(width: 12),
                Text(
                  title,
                  style: Styles.semibold(
                    16,
                    AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 14),
            Text(
              '1',
              style: Styles.semibold(
                24,
                AppColors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
