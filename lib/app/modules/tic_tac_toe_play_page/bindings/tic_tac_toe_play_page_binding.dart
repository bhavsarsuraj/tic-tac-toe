import 'package:get/get.dart';
import '../controllers/tic_tac_toe_play_page_controller.dart';

class TicTacToePlayPageBinding extends Bindings {
  @override
  void dependencies() {
    _setupArguments();
  }

  void _setupArguments() {
    final args = Get.arguments;
    TicTacToePlayPageArguments? arguments;
    if (args is TicTacToePlayPageArguments) {
      arguments = args;
    }
    Get.lazyPut<TicTacToePlayPageController>(
      () => TicTacToePlayPageController(arguments: arguments),
    );
  }
}
