import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:tic_tac_toe/app/utils/constants/app_colors.dart';
import 'package:tic_tac_toe/app/utils/constants/styles.dart';

class PrimaryButton extends StatelessWidget {
  final String? text;
  final String? imagePath;
  final VoidCallback onTap;
  final double imageHeight;
  final double imageWidth;
  final double? width;
  final Widget? child;
  const PrimaryButton({
    Key? key,
    this.text,
    this.imagePath,
    required this.onTap,
    this.imageHeight = 20,
    this.imageWidth = 20,
    this.width,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: NeoPopButton(
        color: AppColors.red,
        onTapUp: () {
          HapticFeedback.vibrate();
          onTap();
        },
        shadowColor: AppColors.black,
        rightShadowColor: AppColors.black,
        depth: 8,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: child != null
              ? child!
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (imagePath != null)
                      Image.asset(
                        imagePath!,
                        height: imageHeight,
                        width: imageWidth,
                      ),
                    SizedBox(width: 12),
                    if (text != null)
                      Flexible(
                        child: Text(
                          text!,
                          style: Styles.semibold(
                            18,
                            AppColors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
