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

class RelationshipStageScreen extends StatefulWidget {
  const RelationshipStageScreen({super.key});

  @override
  State<RelationshipStageScreen> createState() =>
      _RelationshipStageScreenState();
}

class _RelationshipStageScreenState extends State<RelationshipStageScreen> {
  String? _selectedStage;

  final List<Map<String, String>> _stages = [
    {'key': 'dating', 'label': 'Dating', 'image': AppPngAssets.dating},
    {'key': 'courting', 'label': 'Courting', 'image': AppPngAssets.courting},
    {'key': 'engaged', 'label': 'Engaged', 'image': AppPngAssets.engaged},
    {'key': 'married', 'label': 'Married', 'image': AppPngAssets.married},
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
                      'What stage are you in?',
                      textAlign: TextAlign.center,
                      fontSize: Get.height * 0.03,
                      fontWeight: FontWeight.w600,
                    ),
                    Gap(Get.height * 0.01),
                    AppText(
                      'This helps us personalise plans and\nguidance for your season.',
                      textAlign: TextAlign.center,
                      fontSize: Get.height * 0.018,
                    ),
                    Gap(AppSizes.spacingLarge),
                    ..._stages.map(
                      (stage) => Padding(
                        padding: EdgeInsets.only(
                          bottom: AppSizes.spacingMedium,
                        ),
                        child: _buildStageOption(
                          stage['key']!,
                          stage['label']!,
                          stage['image']!,
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
                  onPressed: _selectedStage == null
                      ? () {}
                      : () => Get.toNamed(AppRoutes.coupleGoals),
                  backgroundColor: _selectedStage == null
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

  Widget _buildStageOption(String key, String label, String imagePath) {
    final isSelected = _selectedStage == key;
    return GestureDetector(
      onTap: () => setState(() => _selectedStage = key),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Get.height * 0.02,
          vertical: Get.height * 0.015,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.green : AppColors.textFieldBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Image.asset(imagePath, width: 40, height: 40, fit: BoxFit.contain),
            Gap(AppSizes.spacing),
            Expanded(
              child: AppText(
                label,
                fontSize: Get.height * 0.022,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
