import 'package:get/get.dart';

/// Tracks the selected tab in the main bottom navbar.
/// Tabs: 0 = Home, 1 = Pray, 2 = Plan, 3 = Fast, 4 = Progress
class MainNavController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeTab(int index) {
    if (index >= 0 && index <= 4) {
      currentIndex.value = index;
    }
  }
}
