import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:yoked_app/core/constants/app_fonts.dart';
import 'package:yoked_app/core/constants/app_svg_assets.dart';
import 'package:yoked_app/core/widgets/app_text.dart';
import '../../../core/constants/app_png_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../routes/app_routes.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: AppFonts.hellix,
      height: 1.2,
      color: AppColors.black,
      fontSize: Get.height * 0.017,
    );
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          image: DecorationImage(
            image: AssetImage(AppPngAssets.startBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.horizontalPadding,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                SvgPicture.asset(
                  AppSvgAssets.yoked,
                  width: AppSizes.logoSmall,
                  fit: BoxFit.contain,
                ),

                Gap(AppSizes.spacing),
                SvgPicture.asset(
                  AppSvgAssets.couple,
                  width: Get.width * 0.8,
                  fit: BoxFit.contain,
                ),
                Gap(AppSizes.spacingSmall),
                AppText(
                  ' Welcome to Yoked',
                  textAlign: TextAlign.center,
                  color: AppColors.black,
                  fontSize: Get.height * 0.03,
                  fontWeight: FontWeight.w700,
                ),

                AppText(
                  'Yoked helps Christian couples build\nspiritual rhythm together through\nprayer, fasting, and the Word.',
                  textAlign: TextAlign.center,
                  color: AppColors.black.withValues(alpha: 0.7),
                  fontSize: Get.height * 0.02,
                  fontWeight: FontWeight.w400,
                ),
                Gap(AppSizes.spacingSmall),
                const Spacer(flex: 2),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    'Begin Together',
                    onPressed: () => Get.toNamed(AppRoutes.register),
                    labelColor: AppColors.white,
                    labelFontSize: Get.height * 0.018,
                  ),
                ),
                Gap(AppSizes.spacingSmall),

                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: "Already have an account?",
                    style: textStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed(AppRoutes.login);
                      },
                    children: <TextSpan>[
                      TextSpan(
                        text: " Sign In",
                        style: textStyle.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
