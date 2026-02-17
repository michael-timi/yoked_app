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

class PrayerIntentionScreen extends StatefulWidget {
  const PrayerIntentionScreen({super.key});

  @override
  State<PrayerIntentionScreen> createState() => _PrayerIntentionScreenState();
}

class _PrayerIntentionScreenState extends State<PrayerIntentionScreen> {
  final Set<String> _selectedIntentions = {};
  final TextEditingController _customRequestController =
      TextEditingController();

  final List<Map<String, dynamic>> _intentions = [
    {
      'key': 'relationship',
      'label': 'Our Relationship',
      'color': const Color(0xFF60A5FA),
    }, // Light blue
    {'key': 'wisdom', 'label': 'Wisdom & guidance', 'color': AppColors.green},
    {'key': 'finances', 'label': 'Finances', 'color': AppColors.red},
    {
      'key': 'family',
      'label': 'Family',
      'color': AppColors.secondary,
    }, // Orange
    {
      'key': 'spiritual_growth',
      'label': 'Spiritual Growth',
      'color': const Color(0xFF8B5CF6),
    }, // Purple
  ];

  @override
  void dispose() {
    _customRequestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
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
                      'What are you praying for?',
                      textAlign: TextAlign.center,
                      fontSize: Get.height * 0.03,
                      fontWeight: FontWeight.w600,
                    ),
                    Gap(Get.height * 0.01),
                    AppText(
                      'Your answers stay private between you\nand your partner.',
                      textAlign: TextAlign.center,
                      fontSize: Get.height * 0.018,
                    ),
                    Gap(Get.height * 0.02),
                    ..._intentions.map(
                      (intention) => Padding(
                        padding: EdgeInsets.only(
                          bottom: AppSizes.spacingMedium,
                        ),
                        child: _buildIntentionOption(
                          intention['key'] as String,
                          intention['label'] as String,
                          intention['color'] as Color,
                        ),
                      ),
                    ),
                    Gap(AppSizes.spacingMedium),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            controller: _customRequestController,
                            hintText: 'Add a prayer request',
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                        Gap(AppSizes.spacingSmall),
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (_customRequestController.text
                                  .trim()
                                  .isNotEmpty) {
                                // Add custom request logic here
                                _customRequestController.clear();
                              }
                            },
                            icon: const Icon(Icons.add, color: AppColors.black),
                          ),
                        ),
                      ],
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
                  onPressed: () => Get.toNamed(AppRoutes.fastingSetup),
                  backgroundColor: AppColors.black,
                  labelColor: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntentionOption(String key, String label, Color color) {
    final isSelected = _selectedIntentions.contains(key);
    final displayColor = isSelected ? color : AppColors.textFieldBorder;

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedIntentions.remove(key);
          } else {
            _selectedIntentions.add(key);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.all(Get.height * 0.018),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: displayColor, width: isSelected ? 2 : 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: AppText(
                label,
                fontSize: AppSizes.fontSizeBody,
                fontWeight: FontWeight.w600,
              ),
            ),
            SvgPicture.asset(
              isSelected
                  ? AppSvgAssets.selectRadio
                  : AppSvgAssets.unselectRadio,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(displayColor, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}
