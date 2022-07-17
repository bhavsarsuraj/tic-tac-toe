import 'package:get/get.dart';

import '../modules/customize_game_page/bindings/customize_game_page_binding.dart';
import '../modules/customize_game_page/views/customize_game_page_view.dart';
import '../modules/game_result_page/bindings/game_result_page_binding.dart';
import '../modules/game_result_page/views/game_result_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/splash_page/bindings/splash_page_binding.dart';
import '../modules/splash_page/views/splash_page_view.dart';
import '../modules/tic_tac_toe_play_page/bindings/tic_tac_toe_play_page_binding.dart';
import '../modules/tic_tac_toe_play_page/views/tic_tac_toe_play_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.TIC_TAC_TOE_PLAY_PAGE,
      page: () => const TicTacToePlayPageView(),
      binding: TicTacToePlayPageBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_PAGE,
      page: () => const SplashPageView(),
      binding: SplashPageBinding(),
    ),
    GetPage(
      name: _Paths.GAME_RESULT_PAGE,
      page: () => const GameResultPageView(),
      binding: GameResultPageBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMIZE_GAME_PAGE,
      page: () => const CustomizeGamePageView(),
      binding: CustomizeGamePageBinding(),
    ),
  ];
}
