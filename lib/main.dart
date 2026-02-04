import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/services/storage_service.dart';
import 'core/bindings/app_bindings.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBindings(),
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
      defaultTransition: Transition.cupertino,
      transitionDuration: AppConstants.mediumAnimation,
    );
  }
}
