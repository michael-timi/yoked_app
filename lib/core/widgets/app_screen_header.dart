import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../constants/app_svg_assets.dart';
import '../theme/app_colors.dart';
import 'app_text.dart';

/// Reusable dark header with topographic patterns, title, and subtitle.
/// Used across Pray, Plan, and Fast screens.
class AppScreenHeader extends StatelessWidget {
  const AppScreenHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.height,
  });

  final String title;
  final String subtitle;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final headerHeight = height ?? Get.height * 0.25;
    return Container(
      width: double.infinity,
      height: headerHeight,
      decoration: const BoxDecoration(color: AppColors.black),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            height: Get.height * 0.2,
            child: SvgPicture.asset(
              AppSvgAssets.topographic1,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            right: 0,
            top: Get.height * 0.05,
            width: Get.width * 0.7,
            child: SvgPicture.asset(
              AppSvgAssets.topographic2,
              fit: BoxFit.fitHeight,
              alignment: Alignment.centerRight,
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  title,
                  textAlign: TextAlign.center,
                  fontSize: Get.height * 0.034,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
                AppText(
                  subtitle,
                  textAlign: TextAlign.center,
                  fontSize: Get.height * 0.018,
                  color: AppColors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
