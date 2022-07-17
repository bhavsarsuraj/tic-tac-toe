import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/app/utils/constants/app_colors.dart';
import 'package:tic_tac_toe/app/utils/constants/styles.dart';
import 'package:tic_tac_toe/app/utils/widgets/base_sheet.dart';

class WarningSheet extends StatelessWidget {
  final String title;
  final String description;
  final String primaryButtonTitle;
  final String secondaryButtonTitle;
  const WarningSheet({
    Key? key,
    required this.title,
    required this.description,
    this.primaryButtonTitle = 'Yes',
    this.secondaryButtonTitle = 'Cancel',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseSheet(
      child: Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: Styles.semibold(
                20,
                AppColors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: Styles.regular(
                16,
                AppColors.secondaryText,
              ),
            ),
            SizedBox(height: 40),
            _PrimaryCTA(primaryButtonTitle: primaryButtonTitle),
            SizedBox(height: 12),
            _SecondaryCTA(secondaryButtonTitle: secondaryButtonTitle),
          ],
        ),
      ),
    );
  }
}

class _PrimaryCTA extends StatelessWidget {
  final String primaryButtonTitle;
  const _PrimaryCTA({
    Key? key,
    required this.primaryButtonTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Get.back(result: true),
      child: Text(
        primaryButtonTitle,
        style: Styles.semibold(
          20,
          AppColors.black,
        ),
        textAlign: TextAlign.center,
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: AppColors.red,
            width: 1,
          ),
        ),
        primary: AppColors.scaffoldBackground,
      ),
    );
  }
}

class _SecondaryCTA extends StatelessWidget {
  final String secondaryButtonTitle;
  const _SecondaryCTA({
    Key? key,
    required this.secondaryButtonTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Get.back(result: false),
      child: Text(
        secondaryButtonTitle,
        style: Styles.semibold(
          20,
          AppColors.white,
        ),
        textAlign: TextAlign.center,
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        primary: AppColors.black,
      ),
    );
  }
}
