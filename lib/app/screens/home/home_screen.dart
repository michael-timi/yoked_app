import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppConstants.appName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Gap(AppSizes.spacingSmall),
              Text(
                authController.isLoggedIn.value ? 'Logged in' : 'Logged out',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
