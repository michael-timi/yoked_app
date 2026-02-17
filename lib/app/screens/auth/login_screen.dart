import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_svg_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gap(Get.height * 0.05),
              SvgPicture.asset(
                AppSvgAssets.yoked,
                width: AppSizes.logoSmall,
                fit: BoxFit.contain,
              ),
              Gap(AppSizes.spacing),
              AppText(
                'Sign in',
                textAlign: TextAlign.center,
                fontSize: Get.height * 0.03,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
              AppText(
                'Sign in to continue your spiritual journey.',
                textAlign: TextAlign.center,
                fontSize: Get.height * 0.014,
                color: AppColors.black,
              ),
              Gap(AppSizes.spacingLarge),
              AppTextField(
                hintText: 'Email address',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              Gap(AppSizes.spacingMedium),
              AppTextField(
                hintText: 'Password',
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.done,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.hint,
                    size: 22,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              Gap(AppSizes.spacingLarge),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  'Sign in',
                  onPressed: () => Get.offAllNamed(AppRoutes.main),
                  backgroundColor: AppColors.primary,
                  labelColor: AppColors.black,
                ),
              ),
              Gap(AppSizes.spacingLarge),
              _buildOrDivider(),
              Gap(AppSizes.spacingLarge),
              Row(
                children: [
                  Expanded(
                    child: _SocialButton(
                      assetPath: AppSvgAssets.google,
                      onPressed: () {},
                    ),
                  ),
                  Gap(AppSizes.spacingMedium),
                  Expanded(
                    child: _SocialButton(
                      assetPath: AppSvgAssets.apple,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              Gap(AppSizes.spacingLarge),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    'Don\'t have an account? ',
                    fontSize: AppSizes.fontSizeBody,
                    color: AppColors.hint,
                  ),
                  GestureDetector(
                    onTap: () => Get.offNamed(AppRoutes.register),
                    child: AppText(
                      'Sign up',
                      fontSize: AppSizes.fontSizeBody,
                      fontWeight: FontWeight.w600,
                      color: AppColors.link,
                    ),
                  ),
                ],
              ),
              Gap(AppSizes.spacingLarge),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrDivider() {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: AppColors.textFieldBorder)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing),
          child: AppText(
            'or',
            fontSize: AppSizes.fontSizeBody,
            color: AppColors.hint,
          ),
        ),
        Expanded(child: Container(height: 1, color: AppColors.textFieldBorder)),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.assetPath, required this.onPressed});

  final String assetPath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: AppSizes.spacing),
        side: BorderSide(color: AppColors.textFieldBorder),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
        ),
      ),
      child: SvgPicture.asset(assetPath, height: 24, width: 24),
    );
  }
}
