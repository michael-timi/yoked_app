import 'package:get/get.dart';
import '../../app/controllers/auth_controller.dart';
import '../../app/controllers/main_nav_controller.dart';
import '../../app/controllers/pray_controller.dart';
import '../../app/controllers/plan_controller.dart';
import '../../app/controllers/fast_controller.dart';
import '../../app/controllers/progress_controller.dart';

/// Centralized bindings for all controllers
class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Core - app-wide
    Get.put<AuthController>(AuthController(), permanent: true);

    // Tab controllers - lazy, created when first used
    Get.lazyPut<PrayController>(() => PrayController());
    Get.lazyPut<PlanController>(() => PlanController());
    Get.lazyPut<FastController>(() => FastController());
    Get.lazyPut<ProgressController>(() => ProgressController());
  }
}

/// Bindings for main shell (navbar). AuthController from AppBindings.
class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<MainNavController>(MainNavController(), permanent: false);
  }
}

/// Bindings for standalone /home route (e.g. deep link)
class HomeBindings extends Bindings {
  @override
  void dependencies() {}
}
