import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tic Tac Toe",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
