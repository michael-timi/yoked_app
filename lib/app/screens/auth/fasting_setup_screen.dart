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
import '../success_screen.dart';

class FastingSetupScreen extends StatefulWidget {
  const FastingSetupScreen({super.key});

  @override
  State<FastingSetupScreen> createState() => _FastingSetupScreenState();
}

class _FastingSetupScreenState extends State<FastingSetupScreen> {
  bool? _wantsToFast; // null = not answered, true = yes, false = not right now
  String? _selectedDuration;
  String? _selectedFastType;

  final List<String> _durations = ['1 day', '3 days', '7 days'];
  final List<Map<String, String>> _fastTypes = [
    {'key': 'social_media', 'label': 'Social media'},
    {'key': 'entertainment', 'label': 'Entertainment'},
    {'key': 'food', 'label': 'Food'},
  ];

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
                      'Do you want to fast together?',
                      textAlign: TextAlign.center,
                      fontSize: Get.height * 0.03,
                      fontWeight: FontWeight.w600,
                    ),
                    Gap(AppSizes.spacingSmall),
                    AppText(
                      'Fasting is optional—but powerful when\ndone in unity.',
                      textAlign: TextAlign.center,
                      fontSize: Get.height * 0.018,
                    ),
                    Gap(AppSizes.spacingLarge),
                    if (_wantsToFast == null) ...[
                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          'Yes, let\'s do it',
                          onPressed: () => _showFastTypeDialog(),
                          backgroundColor: AppColors.green,
                          labelColor: AppColors.white,
                        ),
                      ),
                      Gap(AppSizes.spacingMedium),
                      SizedBox(
                        width: double.infinity,
                        child: AppButton.outlined(
                          'Not right now',
                          onPressed: () => setState(() => _wantsToFast = false),
                          labelColor: AppColors.text,
                          side: BorderSide(color: AppColors.textFieldBorder),
                        ),
                      ),
                    ],
                    Gap(AppSizes.spacingLarge),
                  ],
                ),
              ),
            ),
            if (_wantsToFast != null)
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
                    _wantsToFast == false ? 'Continue' : 'Save Fasting Goal',
                    onPressed: _canContinue()
                        ? () => Get.offAllNamed(AppRoutes.main)
                        : () {},
                    backgroundColor: _canContinue()
                        ? AppColors.black
                        : AppColors.textFieldFill,
                    labelColor: AppColors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  bool _canContinue() {
    if (_wantsToFast == false) return true;
    if (_wantsToFast == true) {
      return _selectedDuration != null && _selectedFastType != null;
    }
    return false;
  }

  void _showFastTypeDialog() {
    Get.dialog<void>(
      _FastTypeDialog(
        initialDuration: _selectedDuration,
        initialFastType: _selectedFastType,
        durations: _durations,
        fastTypes: _fastTypes,
        onSave: (duration, fastType) {
          Get.back(); // close dialog first
          setState(() {
            _wantsToFast = true;
            _selectedDuration = duration;
            _selectedFastType = fastType;
          });
          Get.offNamed(
            AppRoutes.success,
            arguments: SuccessScreenArgs(
              title: ' You’re officially\nyoked 🎉',
              message:
                  'Your couple space is ready. Your\nfirst spiritual step begins today.',
              continueRoute: AppRoutes.main,
              continueLabel: 'Continue',
              showBackButton: false,
              image: SvgPicture.asset(
                AppSvgAssets.yokedSuccess,
                width: Get.height * 0.2,
                height: Get.height * 0.2,
              ),
            ),
          );
        },
      ),
      barrierDismissible: false,
    );
  }
}

class _FastTypeDialog extends StatefulWidget {
  const _FastTypeDialog({
    required this.initialDuration,
    required this.initialFastType,
    required this.durations,
    required this.fastTypes,
    required this.onSave,
  });

  final String? initialDuration;
  final String? initialFastType;
  final List<String> durations;
  final List<Map<String, String>> fastTypes;
  final Function(String?, String?) onSave;

  @override
  State<_FastTypeDialog> createState() => _FastTypeDialogState();
}

class _FastTypeDialogState extends State<_FastTypeDialog> {
  int _step = 0; // 0 = duration, 1 = fast type (what to fast from)
  String? _selectedDuration;
  String? _selectedFastType;
  bool _showCustomInput = false;
  final TextEditingController _customDurationController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDuration = widget.initialDuration;
    _selectedFastType = widget.initialFastType;
  }

  @override
  void dispose() {
    _customDurationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Container(
        margin: EdgeInsets.only(top: Get.height * 0.3),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSizes.radius * 1.5),
            topRight: Radius.circular(AppSizes.radius * 1.5),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppSizes.spacingLarge),
                child: _step == 0 ? _buildDurationStep() : _buildFastTypeStep(),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSizes.spacingLarge,
                AppSizes.spacing,
                AppSizes.spacingLarge,
                AppSizes.spacingLarge + MediaQuery.of(context).padding.bottom,
              ),
              child: SizedBox(
                width: double.infinity,
                child: AppButton(
                  _step == 0 ? 'Continue' : 'Save Fasting Goal',
                  onPressed: _step == 0
                      ? (_selectedDuration != null
                            ? () => setState(() => _step = 1)
                            : () {})
                      : (_selectedFastType != null
                            ? () => widget.onSave(
                                _selectedDuration,
                                _selectedFastType,
                              )
                            : () {}),
                  backgroundColor: _step == 0
                      ? (_selectedDuration != null
                            ? AppColors.black
                            : AppColors.textFieldFill)
                      : (_selectedFastType != null
                            ? AppColors.black
                            : AppColors.textFieldFill),
                  labelColor: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          'Fast type',
          fontSize: Get.height * 0.022,
          fontWeight: FontWeight.w600,
        ),

        Gap(Get.height * 0.01),
        ...widget.durations.map(
          (duration) => Padding(
            padding: EdgeInsets.only(bottom: AppSizes.spacingMedium),
            child: _buildDurationOption(duration),
          ),
        ),
        if (_showCustomInput) ...[
          Gap(AppSizes.spacingSmall),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: _customDurationController,
                  hintText: 'Enter days',
                  keyboardType: TextInputType.number,
                ),
              ),
              Gap(AppSizes.spacingSmall),
              IconButton(
                onPressed: () {
                  if (_customDurationController.text.trim().isNotEmpty) {
                    setState(() {
                      _selectedDuration = _customDurationController.text.trim();
                      _showCustomInput = false;
                    });
                  }
                },
                icon: const Icon(Icons.check, color: AppColors.green),
              ),
            ],
          ),
        ] else ...[
          Padding(
            padding: EdgeInsets.only(bottom: AppSizes.spacingMedium),
            child: _buildAddCustomOption(),
          ),
        ],
      ],
    );
  }

  Widget _buildFastTypeStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          'What will you fast from?',
          fontSize: Get.height * 0.022,
          fontWeight: FontWeight.w600,
        ),
        Gap(Get.height * 0.01),
        ...widget.fastTypes.map(
          (type) => Padding(
            padding: EdgeInsets.only(bottom: AppSizes.spacingMedium),
            child: _buildFastTypeOption(type['key']!, type['label']!),
          ),
        ),
      ],
    );
  }

  Widget _buildDurationOption(String duration) {
    final isSelected = _selectedDuration == duration;
    final displayColor = isSelected
        ? AppColors.green
        : AppColors.textFieldBorder;

    return GestureDetector(
      onTap: () => setState(() => _selectedDuration = duration),
      child: Container(
        padding: EdgeInsets.all(Get.height * 0.018),
        decoration: BoxDecoration(
          color: AppColors.textFieldFill,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: displayColor, width: isSelected ? 2 : 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: AppText(
                duration,
                fontSize: Get.height * 0.018,
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

  Widget _buildAddCustomOption() {
    return GestureDetector(
      onTap: () => setState(() => _showCustomInput = true),
      child: Container(
        padding: EdgeInsets.all(Get.height * 0.018),
        decoration: BoxDecoration(
          color: AppColors.textFieldFill,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.textFieldBorder, width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: AppText(
                'Add Custom',
                fontSize: Get.height * 0.018,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.textFieldBorder,
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.add, size: 16, color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFastTypeOption(String key, String label) {
    final isSelected = _selectedFastType == key;
    final displayColor = isSelected
        ? AppColors.green
        : AppColors.textFieldBorder;

    return GestureDetector(
      onTap: () => setState(() => _selectedFastType = key),
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
                fontSize: Get.height * 0.018,
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
