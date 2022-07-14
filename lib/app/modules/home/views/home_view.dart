import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/app/modules/home/controllers/home_controller.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 160,
              child: ElevatedButton(
                onPressed: controller.didTapPlay,
                child: Text('PLAY'),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 160,
              child: ElevatedButton(
                onPressed: _didTapChangeDifficulty,
                child: Text('DIFFICULTY'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _didTapChangeDifficulty() {
    controller.changeDifficulty(Difficulty.EASY);
  }
}
