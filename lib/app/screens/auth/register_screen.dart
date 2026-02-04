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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
              Gap(AppSizes.spacing),
              _buildTabHeader(context),
              Gap(AppSizes.spacingLarge),
              SvgPicture.asset(
                AppSvgAssets.yoked,
                width: AppSizes.logoWidthNarrow,
                height: AppSizes.logoHeightNarrow,
                fit: BoxFit.contain,
              ),
              Gap(AppSizes.spacing),
              AppText(
                'Create your Account',
                textAlign: TextAlign.center,
                fontSize: AppSizes.fontSizeTitle,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
              Gap(AppSizes.spacingSmall),
              AppText(
                "Let's set up your spiritual journey as a couple.",
                textAlign: TextAlign.center,
                fontSize: AppSizes.fontSizeBody,
                color: AppColors.hint,
              ),
              Gap(AppSizes.spacingLarge),
              AppTextField(
                hintText: 'First Name',
                textInputAction: TextInputAction.next,
              ),
              Gap(AppSizes.spacingMedium),
              AppTextField(
                hintText: 'Last Name',
                textInputAction: TextInputAction.next,
              ),
              Gap(AppSizes.spacingMedium),
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
                  'Create Account',
                  onPressed: () => Get.offAllNamed(AppRoutes.main),
                  backgroundColor: AppColors.primary,
                  labelColor: AppColors.text,
                  foregroundColor: AppColors.text,
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
                    'Already have an account? ',
                    fontSize: AppSizes.fontSizeBody,
                    color: AppColors.hint,
                  ),
                  GestureDetector(
                    onTap: () => Get.offNamed(AppRoutes.login),
                    child: AppText(
                      'Sign in',
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

  Widget _buildTabHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Get.offNamed(AppRoutes.login),
          child: Column(
            children: [
              AppText('Login', color: AppColors.hint, fontSize: AppSizes.fontSizeBody),
              Gap(4),
              Container(height: 2, width: 40, color: Colors.transparent),
            ],
          ),
        ),
        Gap(Get.width * 0.12),
        Column(
          children: [
            AppText(
              'Register',
              fontWeight: FontWeight.w600,
              color: AppColors.text,
              fontSize: AppSizes.fontSizeBody,
            ),
            Gap(4),
            Container(
              height: 3,
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.text,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.textFieldBorder,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.spacingMedium),
          child: AppText('or', color: AppColors.hint, fontSize: AppSizes.fontSizeBody * 0.9),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.textFieldBorder,
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.assetPath,
    required this.onPressed,
  });

  final String assetPath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppSizes.radius),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppSizes.radius),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppSizes.buttonPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radius),
            border: Border.all(color: AppColors.textFieldBorder),
          ),
          child: Center(
            child: SvgPicture.asset(
              assetPath,
              width: 28,
              height: 28,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
