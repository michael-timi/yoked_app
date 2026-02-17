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

class PrayerRhythmScreen extends StatefulWidget {
  const PrayerRhythmScreen({super.key});

  @override
  State<PrayerRhythmScreen> createState() => _PrayerRhythmScreenState();
}

class _PrayerRhythmScreenState extends State<PrayerRhythmScreen> {
  String? _selectedFrequency;
  String? _selectedTime;

  final List<Map<String, String>> _frequencies = [
    {'key': 'daily', 'label': 'Daily'},
    {'key': '3times', 'label': '3 times a week'},
    {'key': 'weekly', 'label': 'Weekly'},
  ];

  final List<Map<String, String>> _times = [
    {'key': 'morning', 'label': 'Morning'},
    {'key': 'evening', 'label': 'Evening'},
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
                      'Set your prayer Rhythm?',
                      textAlign: TextAlign.center,
                      fontSize: Get.height * 0.03,
                      fontWeight: FontWeight.w600,
                    ),
                    Gap(Get.height * 0.01),
                    AppText(
                      'Pick a consistent time you can both\ncommit to.',
                      textAlign: TextAlign.center,
                      fontSize: Get.height * 0.018,
                    ),
                    Gap(Get.height * 0.01),
                    AppText(
                      'Pick frequency',
                      fontSize: Get.height * 0.022,
                      fontWeight: FontWeight.w600,
                    ),
                    Gap(Get.height * 0.01),
                    ..._frequencies.map(
                      (freq) => Padding(
                        padding: EdgeInsets.only(bottom: Get.height * 0.015),
                        child: _buildOption(
                          freq['key']!,
                          freq['label']!,
                          _selectedFrequency,
                          (key) => setState(() => _selectedFrequency = key),
                        ),
                      ),
                    ),
                    AppText(
                      'Pick time',
                      fontSize: Get.height * 0.022,
                      fontWeight: FontWeight.w600,
                    ),
                    Gap(Get.height * 0.01),
                    ..._times.map(
                      (time) => Padding(
                        padding: EdgeInsets.only(bottom: Get.height * 0.015),
                        child: _buildOption(
                          time['key']!,
                          time['label']!,
                          _selectedTime,
                          (key) => setState(() => _selectedTime = key),
                        ),
                      ),
                    ),
                    Gap(Get.height * 0.02),
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
                  onPressed: _selectedFrequency == null || _selectedTime == null
                      ? () {}
                      : () => Get.toNamed(AppRoutes.prayerIntention),
                  backgroundColor:
                      _selectedFrequency == null || _selectedTime == null
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

  Widget _buildOption(
    String key,
    String label,
    String? selectedKey,
    ValueChanged<String> onSelect,
  ) {
    final isSelected = selectedKey == key;
    final displayColor = isSelected
        ? AppColors.green
        : AppColors.textFieldBorder;

    return GestureDetector(
      onTap: () => onSelect(key),
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
