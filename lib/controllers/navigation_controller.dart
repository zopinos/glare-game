import 'package:get/get.dart';
import 'package:glare_game/constants/destinations.dart';

class NavigationController extends GetxController {
  static NavigationController get to => Get.find();
  var currentIndex = 0.obs;

  final destinations = [
    Destinations.start,
    Destinations.levels,
    Destinations.game,
    Destinations.results,
  ];

  void changePage(int index) {
    currentIndex.value = index;
    Get.offAllNamed(destinations[index]);
  }
}
