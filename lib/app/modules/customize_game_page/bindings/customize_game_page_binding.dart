import 'package:get/get.dart';

import '../controllers/customize_game_page_controller.dart';

class CustomizeGamePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomizeGamePageController>(
      () => CustomizeGamePageController(),
    );
  }
}
