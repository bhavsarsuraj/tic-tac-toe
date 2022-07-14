import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/app/data/models/tic_tac_toe/move.dart';
import 'package:tic_tac_toe/app/utils/Helpers/tic_tac_toe_helper.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';
import 'package:tic_tac_toe/app/utils/game/tic_tac_toe.dart';

class TicTacToePlayPageArguments {
  final bool isMyTurnFirst;
  final Difficulty difficulty;

  TicTacToePlayPageArguments({
    this.isMyTurnFirst = true,
    this.difficulty = Difficulty.EASY,
  });
}

class TicTacToePlayPageController extends GetxController {
  final TicTacToePlayPageArguments? arguments;
  TicTacToePlayPageController({this.arguments});

  late TicTacToe ticTacToe;
  late int gridSize;

  final _isMyTurn = true.obs;
  bool get isMyTurn => this._isMyTurn.value;
  set isMyTurn(bool value) => this._isMyTurn.value = value;

  bool _isValid = true;

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
    _configureGridSize();
  }

  void _configureFirstTurn() {
    if (arguments!.isMyTurnFirst) {
      isMyTurn = true;
    } else {
      isMyTurn = false;
    }
  }

  void _configureTicTacToe() {
    ticTacToe = TicTacToe(
      difficulty: arguments!.difficulty,
      myMarkingSymbol: BlockStatus.CROSS,
    );
  }

  void _configureGridSize() {
    gridSize = TicTacToeHelper.getSizeFromDifficulty(
      arguments!.difficulty,
    );
  }

  void _flipPlayerTurn() {
    isMyTurn = !isMyTurn;
  }

  void onTapBlock(int row, int col) {
    if (ticTacToe.board[row][col].value.blockStatus != BlockStatus.none) return;
    final gameStatus = ticTacToe.playMove(
      Move(
        row: row,
        col: col,
        blockStatus: BlockStatus.CROSS,
      ),
    );

    switch (gameStatus) {
      case GameStatus.CONTINUE:
        _flipPlayerTurn();
        _playComputerMove();
        break;
      case GameStatus.FINISHED:
        _onFinished();
        break;
      case GameStatus.DRAW:
        _onDraw();
        break;
      default:
    }
  }

  void _playComputerMove() {
    Future.delayed(Duration(milliseconds: 500), () {
      final status = ticTacToe.playComputerMove();
      switch (status) {
        case GameStatus.CONTINUE:
          _flipPlayerTurn();
          break;
        case GameStatus.FINISHED:
          _onFinished();
          break;
        case GameStatus.DRAW:
          _onDraw();
          break;
      }
    });
  }

  void _onFinished() async {
    await Get.bottomSheet(
      Container(
        height: 200,
        color: Colors.white,
        child: Center(
          child: Text(
            'Game Finished',
          ),
        ),
      ),
    );
    ticTacToe.resetGame();
  }

  void _onDraw() async {
    await Get.bottomSheet(
      Container(
        height: 200,
        color: Colors.white,
        child: Center(
          child: Text(
            'Game Draw',
          ),
        ),
      ),
    );
    ticTacToe.resetGame();
  }

  void _checkFirstPlayersTurn() {
    if (!isMyTurn) {
      _playComputerMove();
    }
  }
}
