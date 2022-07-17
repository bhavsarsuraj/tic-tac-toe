import 'package:get/get.dart';
import 'package:tic_tac_toe/app/modules/tic_tac_toe_play_page/controllers/tic_tac_toe_play_page_controller.dart';
import 'package:tic_tac_toe/app/routes/app_pages.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';

class CustomizeGamePageController extends GetxController {
  final _selectedDifficulty = Difficulty.EASY.obs;
  Difficulty get selectedDifficulty => this._selectedDifficulty.value;
  set selectedDifficulty(Difficulty value) =>
      this._selectedDifficulty.value = value;

  final _selectedMarkingSymbol = TicTacToeSymbol.CROSS.obs;
  TicTacToeSymbol get selectedMarkingSymbol =>
      this._selectedMarkingSymbol.value;
  set selectedMarkingSymbol(TicTacToeSymbol value) =>
      this._selectedMarkingSymbol.value = value;

  @override
  void onInit() {
    super.onInit();
  }

  void didSelectSymbol(TicTacToeSymbol symbol) {
    selectedMarkingSymbol = symbol;
  }

  void didChangeDifficulty(Difficulty difficulty) {
    selectedDifficulty = difficulty;
  }

  void didTapContinue() {
    Get.offNamed(
      Routes.TIC_TAC_TOE_PLAY_PAGE,
      arguments: TicTacToePlayPageArguments(
        difficulty: selectedDifficulty,
        // The person with CROSS symbol will play first move
        isMyTurnFirst:
            selectedMarkingSymbol == TicTacToeSymbol.CROSS ? true : false,
      ),
    );
  }
}
