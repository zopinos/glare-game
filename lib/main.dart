import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glare_game/controllers/navigation_controller.dart';
import 'package:glare_game/screens/start_screen.dart';
import 'package:glare_game/services/level_service.dart';
import 'dart:ui';
import 'package:hive_ce_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox("storage");
  Get.put(NavigationController());
  Get.put(LevelService());
  runApp(GameApp());
}

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: CustomScrollBehavior(),
      defaultTransition: Transition.noTransition,
      transitionDuration: Duration.zero,
      home: StartScreen(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
