// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/constants/app_svg_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../routes/app_routes.dart';

class AccountSetupScreen extends StatefulWidget {
  const AccountSetupScreen({super.key});

  @override
  State<AccountSetupScreen> createState() => _AccountSetupScreenState();
}

class _AccountSetupScreenState extends State<AccountSetupScreen> {
  int _currentTab = 0; // 0 = Account Setup form, 1 = Invite Partner
  String _gender = 'Male';
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  String? _denomination = 'Catholic';
  int? _focusedDobIndex; // 0=day, 1=month, 2=year

  static const List<String> _denominations = [
    'Catholic',
    'Protestant',
    'Non-Denominational',
    'Other',
  ];

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  Future<void> _shareQrCode() async {
    try {
      const inviteLink = 'https://yoked.app/join/partner';
      const qrSize = 512.0;

      // Create QR code painter
      final qrPainter = QrPainter(
        data: inviteLink,
        version: QrVersions.auto,
        color: AppColors.black,
        emptyColor: AppColors.white,
      );

      // Create image from painter
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      qrPainter.paint(canvas, Size(qrSize, qrSize));
      final picture = recorder.endRecording();
      final image = await picture.toImage(qrSize.toInt(), qrSize.toInt());
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      // Save to temporary file
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/qr_code.png');
      await file.writeAsBytes(pngBytes);

      // Share the file
      await Share.shareXFiles([
        XFile(file.path),
      ], text: 'Join me on Yoked! $inviteLink');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to share QR code: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: SafeArea(
        child: _currentTab == 0 ? _buildFormTab() : _buildInviteTab(),
      ),
    );
  }

  Widget _buildTabHeader() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (_currentTab == 1) setState(() => _currentTab = 0);
            },
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: _currentTab == 0
                    ? AppColors.black
                    : AppColors.textFieldBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
        Gap(AppSizes.spacingSmall),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (_currentTab == 0) setState(() => _currentTab = 1);
            },
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: _currentTab == 1
                    ? AppColors.black
                    : AppColors.textFieldBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormTab() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.horizontalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Gap(AppSizes.spacing),
                _buildTabHeader(),
                Gap(AppSizes.spacingLarge),
                AppText(
                  'Account Setup',
                  textAlign: TextAlign.center,
                  fontSize: Get.height * 0.03,
                  fontWeight: FontWeight.w600,
                ),
                Gap(Get.height * 0.01),
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'Gender',
                        fontSize: Get.height * 0.018,
                        fontWeight: FontWeight.w600,
                      ),
                      Gap(Get.height * 0.01),
                      _buildGenderOption('Male'),
                      Gap(Get.height * 0.01),
                      _buildGenderOption('Female'),
                    ],
                  ),
                ),
                Gap(AppSizes.spacingMedium),
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'Date of Birth',
                        fontSize: Get.height * 0.018,
                        fontWeight: FontWeight.w600,
                      ),
                      Gap(AppSizes.spacingSmall),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDobField(
                              'Day',
                              _dayController,
                              0,
                              maxLength: 2,
                            ),
                          ),
                          Gap(AppSizes.spacingSmall),
                          Expanded(
                            child: _buildDobField(
                              'Month',
                              _monthController,
                              1,
                              maxLength: 2,
                            ),
                          ),
                          Gap(AppSizes.spacingSmall),
                          Expanded(
                            child: _buildDobField(
                              'Year',
                              _yearController,
                              2,
                              maxLength: 4,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Gap(AppSizes.spacingMedium),
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'Denomination',
                        fontSize: Get.height * 0.018,
                        fontWeight: FontWeight.w600,
                      ),
                      Gap(AppSizes.spacingSmall),
                      _buildDenominationDropdown(),
                    ],
                  ),
                ),
                Gap(AppSizes.spacingLarge),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    'Continue',
                    onPressed: () => setState(() => _currentTab = 1),
                    backgroundColor: AppColors.primary,
                    labelColor: AppColors.black,
                  ),
                ),
                Gap(AppSizes.spacingLarge),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.spacing),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildGenderOption(String value) {
    final isSelected = _gender == value;
    return GestureDetector(
      onTap: () => setState(() => _gender = value),
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          SvgPicture.asset(
            isSelected ? AppSvgAssets.selectRadio : AppSvgAssets.unselectRadio,
            width: Get.height * 0.022,
            height: Get.height * 0.022,
          ),
          Gap(AppSizes.spacingSmall),
          AppText(value, fontSize: AppSizes.fontSizeBody),
        ],
      ),
    );
  }

  Widget _buildDobField(
    String label,
    TextEditingController controller,
    int index, {
    required int maxLength,
  }) {
    final isFocused = _focusedDobIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _focusedDobIndex = index),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(label, fontSize: Get.height * 0.016),
          Gap(Get.height * 0.006),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.spacingSmall,
              vertical: AppSizes.spacingSmall,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(Get.height * 0.015),
              border: Border.all(
                color: isFocused ? AppColors.black : AppColors.textFieldBorder,
              ),
            ),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.none,
              maxLength: maxLength,
              onTap: () => setState(() => _focusedDobIndex = index),
              style: TextStyle(
                fontSize: AppSizes.fontSizeBody,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: '',
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDenominationDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Get.height * 0.02,
        vertical: Get.height * 0.005,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Get.height * 0.015),
        border: Border.all(color: AppColors.black),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _denomination,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: AppColors.text),
          items: _denominations
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
          onChanged: (v) => setState(() => _denomination = v),
        ),
      ),
    );
  }

  Widget _buildInviteTab() {
    const inviteLink = 'https://yoked.app/join/partner';
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Gap(AppSizes.spacing),
          _buildTabHeader(),
          Gap(AppSizes.spacingLarge),
          Center(
            child: SvgPicture.asset(
              AppSvgAssets.yoked,
              width: Get.width * 0.4,
              fit: BoxFit.contain,
            ),
          ),
          Gap(AppSizes.spacingLarge),
          AppText(
            'Invite Your Partner',
            textAlign: TextAlign.center,
            fontSize: Get.height * 0.03,
            fontWeight: FontWeight.w600,
          ),
          Gap(Get.height * 0.01),
          AppText(
            'Yoked works best when both of you are connected. Your progress is shared.',
            textAlign: TextAlign.center,
            fontSize: Get.height * 0.018,
          ),
          Gap(AppSizes.spacingLarge),
          Center(
            child: SizedBox(
              width: Get.width * 0.5,
              height: Get.width * 0.5,
              child: _buildCard(
                child: Center(
                  child: QrImageView(
                    data: inviteLink,
                    version: QrVersions.auto,
                    size: Get.width * 0.4,
                    backgroundColor: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
          Gap(AppSizes.spacingLarge),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              'Share QR Code',
              onPressed: _shareQrCode,
              backgroundColor: AppColors.primary,
              labelColor: AppColors.black,
            ),
          ),
          Gap(AppSizes.spacingMedium),
          SizedBox(
            width: double.infinity,
            child: AppButton.outlined(
              'Send Invite Link',
              onPressed: () {},
              labelColor: AppColors.black,
              side: BorderSide(color: AppColors.black),
            ),
          ),
          Gap(AppSizes.spacingSmall),
          AppText(
            'Your partner will create their account\nand join your couple space.',
            textAlign: TextAlign.center,
            fontSize: Get.height * 0.018,
          ),
          Gap(AppSizes.spacingLarge),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.relationshipStage),
            child: Center(
              child: AppText(
                'Skip for now',
                fontSize: Get.height * 0.018,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Gap(AppSizes.spacingLarge),
        ],
      ),
    );
  }
}
