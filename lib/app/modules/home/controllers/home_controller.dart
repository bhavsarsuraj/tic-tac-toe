import 'package:get/get.dart';
import 'package:tic_tac_toe/app/modules/tic_tac_toe_play_page/controllers/tic_tac_toe_play_page_controller.dart';
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
    Get.toNamed(
      Routes.TIC_TAC_TOE_PLAY_PAGE,
      arguments: TicTacToePlayPageArguments(
        difficulty: difficulty,
        isMyTurnFirst: isMyTurnFirst,
      ),
    );
  }

  void changeDifficulty(Difficulty updatedDifficulty) {
    difficulty = updatedDifficulty;
  }

  void togglePlayerTurn() {
    isMyTurnFirst = !isMyTurnFirst;
  }
}
