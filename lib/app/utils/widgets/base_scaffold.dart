import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/app/utils/constants/app_colors.dart';
import 'package:tic_tac_toe/app/utils/constants/images.dart';
import 'package:tic_tac_toe/app/utils/constants/styles.dart';

class BaseScaffold extends StatelessWidget {
  final PreferredSizeWidget? bottom;
  final PreferredSizeWidget? customAppBar;
  final String? titleText;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget body;
  final Color? backgroundColor;
  final FloatingActionButton? floatingActionButton;
  final Color? appBarColor;
  final String? backgroundImage;
  final bool resizeToAvoidBottomInset;
  final bool showBack;

  const BaseScaffold({
    Key? key,
    required this.body,
    this.customAppBar,
    this.titleText,
    this.titleWidget,
    this.actions,
    this.backgroundColor = AppColors.scaffoldBackground,
    this.floatingActionButton,
    this.appBarColor,
    this.backgroundImage,
    this.resizeToAvoidBottomInset = true,
    this.bottom,
    this.showBack = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      key: key,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButton: floatingActionButton,
      appBar: _appBar(context),
      body: Container(
        color: backgroundColor,
        child: Stack(
          children: [
            if (backgroundImage != null) ...[
              Positioned.fill(
                child: Image.asset(
                  backgroundImage!,
                  fit: BoxFit.cover,
                ),
              )
            ],
            Positioned.fill(
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: SafeArea(child: body),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    if (customAppBar != null) {
      return customAppBar!;
    } else {
      return PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          bottom: (bottom != null) ? bottom : null,
          iconTheme: IconThemeData(color: AppColors.brown),
          leadingWidth: Navigator.canPop(context) ? 80 : 0,
          titleSpacing: Navigator.canPop(Get.context!) ? 0 : 20,
          leading: _leading(context),
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          title: _title(context),
          actions: [
            ...(actions ?? []),
            SizedBox(width: 18),
          ],
          centerTitle: true,
        ),
      );
    }
  }

  Widget _title(BuildContext context) {
    if (titleText != null) {
      return Text(
        titleText!,
        style: Styles.semibold(24, AppColors.black),
        overflow: TextOverflow.clip,
        maxLines: 1,
      );
    } else if (titleWidget != null) {
      return titleWidget!;
    } else {
      return Container();
    }
  }

  Widget _leading(BuildContext context) {
    if (Navigator.canPop(context) && showBack) {
      return IconButton(
        icon: Image.asset(
          Images.back,
          color: AppColors.brown,
          height: 32,
          width: 32,
        ),
        onPressed: () {
          Navigator.of(Get.context!).maybePop();
        },
      );
    } else {
      return Container();
    }
  }
}
