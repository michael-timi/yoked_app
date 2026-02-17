import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_svg_assets.dart';
import '../../../core/theme/app_colors.dart';
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
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.transparent,
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              return TextStyle(
                color: states.contains(WidgetState.selected)
                    ? AppColors.activeNavBarColor
                    : null,
              );
            }),
            iconTheme: WidgetStateProperty.resolveWith((states) {
              return IconThemeData(
                color: states.contains(WidgetState.selected)
                    ? AppColors.activeNavBarColor
                    : null,
              );
            }),
          ),
          child: NavigationBar(
            selectedIndex: nav.currentIndex.value,
            onDestinationSelected: nav.changeTab,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: [
              _navDest(asset: AppSvgAssets.homeNavbar, label: 'Home'),
              _navDest(asset: AppSvgAssets.prayNavbar, label: 'Pray'),
              _navDest(asset: AppSvgAssets.plansNavbar, label: 'Plan'),
              _navDest(asset: AppSvgAssets.fastNavbar, label: 'Fast'),
              _navDest(asset: AppSvgAssets.progressNavbar, label: 'Progress'),
            ],
          ),
        ),
      ),
    );
  }

  static NavigationDestination _navDest({
    required String asset,
    required String label,
  }) {
    return NavigationDestination(
      icon: SvgPicture.asset(
        asset,
        width: Get.height * 0.03,
        height: Get.height * 0.03,
      ),
      selectedIcon: SvgPicture.asset(
        asset,
        width: Get.height * 0.03,
        height: Get.height * 0.03,
        colorFilter: const ColorFilter.mode(
          AppColors.activeNavBarColor,
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }
}
