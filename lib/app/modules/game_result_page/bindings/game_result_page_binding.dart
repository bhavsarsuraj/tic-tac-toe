import 'package:get/get.dart';

import '../controllers/game_result_page_controller.dart';

class GameResultPageBinding extends Bindings {
  @override
  void dependencies() {
    _setupArguments();
  }

  void _setupArguments() {
    final args = Get.arguments;
    GameResultPageArguments? arguments;
    if (args is GameResultPageArguments) {
      arguments = args;
    }
    Get.lazyPut<GameResultPageController>(
      () => GameResultPageController(arguments: arguments),
    );
  }
}
