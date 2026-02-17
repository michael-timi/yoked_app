import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_png_assets.dart';
import '../../../core/constants/app_svg_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../routes/app_routes.dart';

class CoupleGoalsScreen extends StatefulWidget {
  const CoupleGoalsScreen({super.key});

  @override
  State<CoupleGoalsScreen> createState() => _CoupleGoalsScreenState();
}

class _CoupleGoalsScreenState extends State<CoupleGoalsScreen> {
  final Set<String> _selectedGoals = {};

  final List<Map<String, dynamic>> _goals = [
    {
      'key': 'pray',
      'label': 'Pray more together',
      'image': AppPngAssets.pray,
      'color': AppColors.green,
    },
    {
      'key': 'read',
      'label': 'Read the Word together',
      'image': AppPngAssets.openBook,
      'color': AppColors.secondary,
    },
    {
      'key': 'fast',
      'label': 'Fast more together',
      'image': AppPngAssets.fast,
      'color': AppColors.cyan,
    },
    {
      'key': 'goals',
      'label': 'Set spiritual goals together',
      'image': AppPngAssets.setGoal,
      'color': AppColors.primary,
    },
    {
      'key': 'conversations',
      'label': 'Faith-based conversations',
      'image': AppPngAssets.speechBalloon,
      'color': AppColors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back, color: AppColors.black),
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
                    Gap(AppSizes.spacingMedium),
                    AppText(
                      'What do you want to\ngrow in together?',
                      textAlign: TextAlign.center,
                      fontSize: Get.height * 0.03,
                      fontWeight: FontWeight.w600,
                    ),
                    Gap(Get.height * 0.01),
                    AppText(
                      'Select as many as you like.',
                      textAlign: TextAlign.center,
                      fontSize: Get.height * 0.018,
                    ),
                    Gap(AppSizes.spacingLarge),
                    ..._goals.map(
                      (goal) => Padding(
                        padding: EdgeInsets.only(
                          bottom: AppSizes.spacingMedium,
                        ),
                        child: _buildGoalOption(
                          goal['key'] as String,
                          goal['label'] as String,
                          goal['image'] as String,
                          goal['color'] as Color,
                        ),
                      ),
                    ),
                    Gap(AppSizes.spacingLarge),
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
                  'Continue',
                  onPressed: _selectedGoals.isEmpty
                      ? () {}
                      : () => Get.toNamed(AppRoutes.focusAreas),
                  backgroundColor: _selectedGoals.isEmpty
                      ? AppColors.textFieldFill
                      : AppColors.black,
                  labelColor: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalOption(
    String key,
    String label,
    String imagePath,
    Color borderColor,
  ) {
    final isSelected = _selectedGoals.contains(key);
    final displayColor = isSelected ? borderColor : AppColors.textFieldBorder;

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedGoals.remove(key);
          } else {
            _selectedGoals.add(key);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Get.height * 0.02,
          vertical: Get.height * 0.015,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: displayColor, width: isSelected ? 2 : 1),
        ),
        child: Row(
          children: [
            Image.asset(imagePath, width: 24, height: 24, fit: BoxFit.contain),
            Gap(AppSizes.spacing),
            Expanded(
              child: AppText(
                label,
                fontSize: AppSizes.fontSizeBody,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            Container(
              width: Get.height * 0.019,
              height: Get.height * 0.019,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? displayColor : Colors.transparent,
              ),
              alignment: Alignment.center,
              child: isSelected
                  ? Icon(
                      Icons.radio_button_off,
                      size: Get.height * 0.018,
                      color: AppColors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
