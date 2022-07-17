import 'package:get/get.dart';

import '../controllers/how_to_play_page_controller.dart';

class HowToPlayPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HowToPlayPageController>(
      () => HowToPlayPageController(),
    );
  }
}
