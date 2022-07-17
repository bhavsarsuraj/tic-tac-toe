import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/app/utils/constants/app_colors.dart';
import 'package:tic_tac_toe/app/utils/constants/strings.dart';
import 'package:tic_tac_toe/app/utils/constants/styles.dart';
import 'package:tic_tac_toe/app/utils/widgets/base_scaffold.dart';
import '../controllers/how_to_play_page_controller.dart';

class HowToPlayPageView extends GetView<HowToPlayPageController> {
  const HowToPlayPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      titleText: 'How to Play',
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 32,
        ),
        children: [
          _WhatIsTicTacToe(),
          SizedBox(height: 40),
          _HowToPlayTicTacToe(),
        ],
      ),
    );
  }
}

class _WhatIsTicTacToe extends StatelessWidget {
  const _WhatIsTicTacToe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.whatIsTicTacToe.tr,
          style: Styles.semibold(
            20,
            AppColors.black,
          ),
        ),
        SizedBox(height: 12),
        Text(
          Strings.ticTacToeDesc.tr,
          style: Styles.regular(
            16,
            AppColors.secondaryText,
          ),
        ),
      ],
    );
  }
}

class _HowToPlayTicTacToe extends StatelessWidget {
  const _HowToPlayTicTacToe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.howToPlayTicTacToe.tr,
          style: Styles.semibold(
            20,
            AppColors.black,
          ),
        ),
        SizedBox(height: 12),
        ...Strings.rulesToPlayTicTacToe
            .asMap()
            .entries
            .map((rule) => _Rule(ruleNo: rule.key + 1, rule: rule.value))
            .toList(),
      ],
    );
  }
}

class _Rule extends StatelessWidget {
  final int ruleNo;
  final String rule;
  const _Rule({
    Key? key,
    required this.ruleNo,
    required this.rule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
            child: Text(
              '$ruleNo.',
              style: Styles.semibold(
                16,
                AppColors.secondaryText,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(width: 4),
          Flexible(
            child: Text(
              rule,
              style: Styles.regular(
                16,
                AppColors.secondaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
