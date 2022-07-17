// @dart=2.15

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/app/utils/constants/app_colors.dart';

class BaseSheet extends StatelessWidget {
  final Color backgroundColor;
  final Widget child;

  const BaseSheet({
    Key? key,
    required this.child,
    this.backgroundColor = AppColors.bottomSheetBackground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: Get.height * 0.8,
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 20),
                child: Container(
                  height: 5,
                  width: 70,
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 6, bottom: 12),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
