import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.text,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.spacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gap(AppSizes.spacing),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radius),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              Gap(AppSizes.spacingMedium),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radius),
                  ),
                ),
                obscureText: true,
                textInputAction: TextInputAction.done,
              ),
              Gap(AppSizes.spacing),
              AppButton(
                'Login',
                onPressed: () => Get.offAllNamed(AppRoutes.main),
                backgroundColor: AppColors.text,
                foregroundColor: AppColors.white,
                labelColor: AppColors.white,
              ),
              Gap(AppSizes.spacingSmall),
              AppButton.text(
                'Back',
                onPressed: () => Get.back(),
                labelColor: AppColors.text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
