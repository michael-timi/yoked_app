import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_svg_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../routes/app_routes.dart';

class FocusAreasScreen extends StatefulWidget {
  const FocusAreasScreen({super.key});

  @override
  State<FocusAreasScreen> createState() => _FocusAreasScreenState();
}

class _FocusAreasScreenState extends State<FocusAreasScreen> {
  final Set<String> _selectedAreas = {};

  final List<Map<String, dynamic>> _areas = [
    {
      'key': 'parenting',
      'label': 'Parenting',
      'emoji': '👨‍👩‍👧‍👦',
      'color': AppColors.violet,
    },
    {
      'key': 'marriage',
      'label': 'Marriage',
      'emoji': '💍',
      'color': AppColors.pink,
    },
    {
      'key': 'trust',
      'label': 'Trust',
      'emoji': '👩‍❤️‍👨',
      'color': AppColors.secondary,
    },
    {
      'key': 'purpose',
      'label': 'Purpose',
      'emoji': '🎯',
      'color': AppColors.indigo,
    },
    {
      'key': 'leadership',
      'label': 'Leadership',
      'emoji': '🧠',
      'color': AppColors.sky,
    },
    {
      'key': 'communication',
      'label': 'Communication',
      'emoji': '🗣️',
      'color': AppColors.teal,
    },
    {
      'key': 'vision',
      'label': 'Vision',
      'emoji': '🔍',
      'color': AppColors.green,
    },
    {
      'key': 'finances',
      'label': 'Finances',
      'emoji': '🤑',
      'color': AppColors.emerald,
    },
    {
      'key': 'faith',
      'label': 'Faith',
      'emoji': '🙏',
      'color': AppColors.primary,
    },
    {
      'key': 'forgiveness',
      'label': 'Forgiveness',
      'emoji': '❤️',
      'color': AppColors.rose,
    },
    {
      'key': 'calling',
      'label': 'Calling',
      'emoji': '🔥',
      'color': AppColors.amber,
    },
    {
      'key': 'sexual_purity',
      'label': 'Sexual Purity',
      'emoji': '🕊️',
      'color': AppColors.cyan,
    },
    {
      'key': 'discernment',
      'label': 'Discernment',
      'emoji': '👀',
      'color': AppColors.fuchsia,
    },
    {
      'key': 'patience',
      'label': 'Patience',
      'emoji': '🤍',
      'color': AppColors.lime,
    },
    {
      'key': 'conflict_resolution',
      'label': 'Conflict Resolution',
      'emoji': '🤗',
      'color': AppColors.slate,
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
                      'What areas do you want\nGod to strengthen?',
                      textAlign: TextAlign.center,
                      fontSize: AppSizes.fontSizeTitle,
                      fontWeight: FontWeight.w600,
                    ),
                    Gap(Get.height * 0.01),
                    AppText(
                      'We\'ll recommend Bible plans and prayer prompts based on your focus.',
                      textAlign: TextAlign.center,
                      fontSize: Get.height * 0.018,
                    ),
                    Gap(AppSizes.spacingLarge),
                    Wrap(
                      spacing: Get.height * 0.01,
                      runSpacing: Get.height * 0.01,
                      children: _areas
                          .map(
                            (area) => _buildTag(
                              area['key'] as String,
                              area['label'] as String,
                              area['emoji'] as String,
                              area['color'] as Color,
                            ),
                          )
                          .toList(),
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
                  onPressed: _selectedAreas.isEmpty
                      ? () {}
                      : () => Get.toNamed(AppRoutes.prayerRhythm),
                  backgroundColor: _selectedAreas.isEmpty
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

  Widget _buildTag(String key, String label, String emoji, Color color) {
    final isSelected = _selectedAreas.contains(key);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedAreas.remove(key);
          } else {
            _selectedAreas.add(key);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Get.height * 0.015,
          vertical: Get.height * 0.01,
        ),
        decoration: BoxDecoration(
          color: isSelected ? color : AppColors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? color : AppColors.textFieldBorder,
            width: 1,
          ),
        ),
        child: AppText(
          '$emoji $label',
          fontSize: Get.height * 0.018,
          fontWeight: FontWeight.w500,
          color: isSelected ? AppColors.white : AppColors.text,
        ),
      ),
    );
  }
}
