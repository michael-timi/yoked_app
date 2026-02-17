import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:yoked_app/core/constants/app_png_assets.dart';
import '../../core/constants/app_svg_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_sizes.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text.dart';

/// Arguments for the reusable [SuccessScreen].
/// Pass via [Get.toNamed](AppRoutes.success, arguments: args).
class SuccessScreenArgs {
  const SuccessScreenArgs({
    required this.title,
    required this.message,
    required this.continueRoute,
    this.continueLabel = 'Continue',
    this.showBackButton = true,
    this.image,
  });

  final String title;
  final String message;
  final String continueRoute;
  final String continueLabel;
  final bool showBackButton;
  /// Optional image to show. When null, the default success checkmark is used.
  final Widget? image;
}

/// Reusable success screen: logo, title, message, green checkmark, and action button.
/// Navigate with [Get.toNamed](AppRoutes.success, arguments: [SuccessScreenArgs](...)).
class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as SuccessScreenArgs?;
    final title = args?.title ?? 'Success';
    final message = args?.message ?? '';
    final continueRoute = args?.continueRoute ?? '';
    final continueLabel = args?.continueLabel ?? 'Continue';
    final showBackButton = args?.showBackButton ?? true;
    final customImage = args?.image;

    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          image: DecorationImage(
            image: AssetImage(AppPngAssets.splashBackground),
            fit: BoxFit.cover,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              if (showBackButton)
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.black,
                    ),
                    padding: EdgeInsets.only(
                      left: AppSizes.horizontalPadding,
                      top: AppSizes.spacingSmall,
                    ),
                  ),
                ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.horizontalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Gap(AppSizes.spacingLarge),
                      Center(
                        child: SvgPicture.asset(
                          AppSvgAssets.yoked,
                          width: AppSizes.logoSmall,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Gap(AppSizes.spacingLarge),
                      AppText(
                        title,
                        textAlign: TextAlign.center,
                        fontSize: Get.height * 0.03,
                        fontWeight: FontWeight.w600,
                      ),

                      if (message.isNotEmpty)
                        AppText(
                          message,
                          textAlign: TextAlign.center,
                          fontSize: Get.height * 0.018,
                          color: AppColors.black,
                        ),
                      Gap(AppSizes.spacingLarge * 1.5),

                      customImage ??
                          SvgPicture.asset(
                            AppSvgAssets.success,
                            width: Get.height * 0.2,
                            height: Get.height * 0.2,
                          ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppSizes.horizontalPadding,
                  AppSizes.spacing,
                  AppSizes.horizontalPadding,
                  AppSizes.spacingLarge + MediaQuery.of(context).padding.bottom,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    continueLabel,
                    onPressed: () {
                      if (continueRoute.isNotEmpty) {
                        Get.offAllNamed(continueRoute);
                      } else {
                        Get.back();
                      }
                    },
                    backgroundColor: AppColors.black,
                    labelColor: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
