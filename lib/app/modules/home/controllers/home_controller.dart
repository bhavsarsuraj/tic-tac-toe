import 'package:get/get.dart';
import 'package:tic_tac_toe/app/modules/tic_tac_toe_play_page/controllers/tic_tac_toe_play_page_controller.dart';
import 'package:tic_tac_toe/app/routes/app_pages.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';
import 'package:tic_tac_toe/app/widgets/sheets/select_playing_symbol_sheet.dart';

class HomeController extends GetxController {
  final _isMyTurnFirst = true.obs;
  bool get isMyTurnFirst => this._isMyTurnFirst.value;
  set isMyTurnFirst(bool value) => this._isMyTurnFirst.value = value;

  @override
  void onInit() {
    super.onInit();
  }

  void playHumanVSComputer() async {
    final mySymbol = await Get.bottomSheet(
      SelectPlayingSymbolSheet(),
    );
    if (mySymbol != null && mySymbol is TicTacToeSymbol) {
      Get.toNamed(
        Routes.TIC_TAC_TOE_PLAY_PAGE,
        arguments: TicTacToePlayPageArguments(
          // The person with CROSS symbol will play first move
          isMyTurnFirst: mySymbol == TicTacToeSymbol.CROSS ? true : false,
          isOpponentRobot: true,
          myPlayingSymbol: mySymbol,
        ),
      );
    }
  }

  void playMultiplayer() async {
    final mySymbol = await Get.bottomSheet(
      SelectPlayingSymbolSheet(),
    );
    if (mySymbol != null && mySymbol is TicTacToeSymbol) {
      Get.toNamed(
        Routes.TIC_TAC_TOE_PLAY_PAGE,
        arguments: TicTacToePlayPageArguments(
          // The person with CROSS symbol will play first move
          isMyTurnFirst: mySymbol == TicTacToeSymbol.CROSS ? true : false,
          isOpponentRobot: false,
          myPlayingSymbol: mySymbol,
        ),
      );
    }
  }

  void didTapHowToPlay() {
    Get.toNamed(Routes.HOW_TO_PLAY_PAGE);
  }
}
