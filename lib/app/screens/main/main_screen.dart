import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/home_screen.dart';
import '../pray/pray_screen.dart';
import '../plan/plan_screen.dart';
import '../fast/fast_screen.dart';
import '../progress/progress_screen.dart';
import '../../controllers/main_nav_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const List<Widget> _tabs = [
    HomeScreen(),
    PrayScreen(),
    PlanScreen(),
    FastScreen(),
    ProgressScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final nav = Get.find<MainNavController>();
    return Obx(
      () => Scaffold(
        body: IndexedStack(index: nav.currentIndex.value, children: _tabs),
        bottomNavigationBar: NavigationBar(
          selectedIndex: nav.currentIndex.value,
          onDestinationSelected: nav.changeTab,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline),
              selectedIcon: Icon(Icons.favorite),
              label: 'Pray',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_today_outlined),
              selectedIcon: Icon(Icons.calendar_today),
              label: 'Plan',
            ),
            NavigationDestination(
              icon: Icon(Icons.timer_outlined),
              selectedIcon: Icon(Icons.timer),
              label: 'Fast',
            ),
            NavigationDestination(
              icon: Icon(Icons.trending_up_outlined),
              selectedIcon: Icon(Icons.trending_up),
              label: 'Progress',
            ),
          ],
        ),
      ),
    );
  }
}
