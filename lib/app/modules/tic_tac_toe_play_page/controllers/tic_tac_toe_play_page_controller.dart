import 'package:get/get.dart';
import 'package:tic_tac_toe/app/data/models/tic_tac_toe/move.dart';
import 'package:tic_tac_toe/app/modules/game_result_page/controllers/game_result_page_controller.dart';
import 'package:tic_tac_toe/app/routes/app_pages.dart';
import 'package:tic_tac_toe/app/utils/Helpers/tic_tac_toe_helper.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';
import 'package:tic_tac_toe/app/utils/game/tic_tac_toe.dart';
import 'package:tic_tac_toe/app/utils/widgets/base_sheet.dart';
import 'package:tic_tac_toe/app/widgets/sheets/warning_sheet.dart';

class TicTacToePlayPageArguments {
  final bool isMyTurnFirst;
  final TicTacToeSymbol myPlayingSymbol;
  final bool isOpponentRobot;
  final int myWins;
  final int opponentWins;

  TicTacToePlayPageArguments({
    this.isMyTurnFirst = true,
    this.myPlayingSymbol = TicTacToeSymbol.CROSS,
    required this.isOpponentRobot,
    this.myWins = 0,
    this.opponentWins = 0,
  });
}

class TicTacToePlayPageController extends GetxController {
  final TicTacToePlayPageArguments? arguments;
  TicTacToePlayPageController({this.arguments});

  late Rx<TicTacToe> _ticTacToe;
  TicTacToe get ticTacToe => _ticTacToe.value;
  set ticTacToe(TicTacToe value) => this._ticTacToe.value = value;
  final boardSize = 3;

  final _isMyTurn = true.obs;
  bool get isMyTurn => this._isMyTurn.value;
  set isMyTurn(bool value) => this._isMyTurn.value = value;

  bool _isValid = true;

  final _myWins = 0.obs;
  int get myWins => this._myWins.value;
  set myWins(int value) => this._myWins.value = value;

  final _opponentWins = 0.obs;
  int get opponentWins => this._opponentWins.value;
  set opponentWins(int value) => this._opponentWins.value = value;

  @override
  void onInit() {
    configure();
    super.onInit();
  }

  @override
  void onReady() {
    if (!_isValid) {
      Get.back();
      return;
    }
    _checkFirstPlayersTurn();
    super.onReady();
  }

  void configure() {
    _isValid = arguments == null || arguments is TicTacToePlayPageArguments;
    if (!_isValid) {
      return;
    }
    _configureFirstTurn();
    _configureTicTacToe();
    _configureScore();
  }

  void _configureFirstTurn() {
    if (arguments!.isMyTurnFirst) {
      isMyTurn = true;
    } else {
      isMyTurn = false;
    }
  }

  void _configureTicTacToe() {
    _ticTacToe = TicTacToe(
      myMarkingSymbol: arguments!.myPlayingSymbol,
    ).obs;
  }

  void _configureScore() {
    myWins = arguments!.myWins;
    opponentWins = arguments!.opponentWins;
  }

  void _flipPlayerTurn() {
    isMyTurn = !isMyTurn;
  }

  void onTapBlock(int row, int col) {
    if (ticTacToe.board[row][col].value.blockStatus != BlockStatus.NONE) return;
    TicTacToeSymbol markingSymbol;
    if (arguments!.isOpponentRobot) {
      markingSymbol = arguments!.myPlayingSymbol;
    } else {
      if (isMyTurn)
        markingSymbol = arguments!.myPlayingSymbol;
      else
        markingSymbol = ticTacToe.opponentMarkingSymbol;
    }
    final gameStatus = ticTacToe.playMove(
      Move(
        row: row,
        col: col,
        blockStatus: TicTacToeHelper.getBlockStatusFromSymbol(markingSymbol),
      ),
    );

    switch (gameStatus.resultStatus) {
      case GameResultStatus.CONTINUE:
        _flipPlayerTurn();
        if (arguments!.isOpponentRobot) _playComputerMove();
        break;
      case GameResultStatus.FINISHED:
        _onFinished(
          isMeWinner: gameStatus.winningSymbol == arguments!.myPlayingSymbol,
        );
        break;
      case GameResultStatus.DRAW:
        _onDraw();
        break;
      default:
    }
  }

  void _playComputerMove() {
    Future.delayed(Duration(milliseconds: 300), () {
      final gameStatus = ticTacToe.playComputerMove();
      switch (gameStatus.resultStatus) {
        case GameResultStatus.CONTINUE:
          _flipPlayerTurn();
          break;
        case GameResultStatus.FINISHED:
          _onFinished(
            isMeWinner: gameStatus.winningSymbol == arguments!.myPlayingSymbol,
          );
          break;
        case GameResultStatus.DRAW:
          _onDraw();
          break;
      }
    });
  }

  void _onFinished({required bool isMeWinner}) async {
    if (isMeWinner) {
      myWins++;
    } else {
      opponentWins++;
    }
    Future.delayed(Duration(microseconds: 300), () {
      Get.offNamed(
        Routes.GAME_RESULT_PAGE,
        arguments: GameResultPageArguments(
          gameResult: isMeWinner ? GameResult.WON : GameResult.LOST,
          isOpponentRobot: arguments!.isOpponentRobot,
          mySymbol: arguments!.myPlayingSymbol,
          myWins: myWins,
          opponentWins: opponentWins,
        ),
      );
    });
  }

  void _onDraw() async {
    Future.delayed(Duration(milliseconds: 300), () {
      Get.offNamed(
        Routes.GAME_RESULT_PAGE,
        arguments: GameResultPageArguments(
          gameResult: GameResult.DRAW,
          isOpponentRobot: arguments!.isOpponentRobot,
          mySymbol: arguments!.myPlayingSymbol,
          myWins: myWins,
          opponentWins: opponentWins,
        ),
      );
    });
  }

  void _checkFirstPlayersTurn() {
    if (!isMyTurn) {
      if (arguments!.isOpponentRobot) {
        _playComputerMove();
      }
    }
  }

  void didTapResetGame() async {
    final reset = await Get.bottomSheet(
      BaseSheet(
        child: WarningSheet(
          title: 'Do you want to reset the game?',
          description: 'You will lose game progress by reseting the game',
          primaryButtonTitle: 'Yes, Reset',
        ),
      ),
    );
    if (reset != null && reset is bool && reset) {
      ticTacToe.resetGame();
      isMyTurn = arguments!.isMyTurnFirst;
      _checkFirstPlayersTurn();
      _ticTacToe.refresh();
    }
  }

  Future<bool> onWillPop() async {
    final exit = await Get.bottomSheet(
      BaseSheet(
        child: WarningSheet(
          title: 'Do you want to exit the game?',
          description: 'You will lose game progress by exiting the game',
          primaryButtonTitle: 'Yes, Exit',
        ),
      ),
    );
    if (exit != null && exit is bool && exit) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
