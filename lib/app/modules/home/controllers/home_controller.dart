import 'package:get/get.dart';
import 'package:tic_tac_toe/app/routes/app_pages.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';

class HomeController extends GetxController {
  final _difficulty = Difficulty.EASY.obs;
  Difficulty get difficulty => this._difficulty.value;
  set difficulty(Difficulty value) => this._difficulty.value = value;

  final _isMyTurnFirst = true.obs;
  bool get isMyTurnFirst => this._isMyTurnFirst.value;
  set isMyTurnFirst(bool value) => this._isMyTurnFirst.value = value;

  @override
  void onInit() {
    super.onInit();
  }

  void didTapPlay() {
    Get.toNamed(Routes.CUSTOMIZE_GAME_PAGE);
  }

  void didTapMultiplayer() {
    //
  }

  void didTapHowToPlay() {
    Get.toNamed(Routes.HOW_TO_PLAY_PAGE);
  }
}
