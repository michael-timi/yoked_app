import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../core/constants/app_svg_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../routes/app_routes.dart';
import '../success_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  int _currentTab = 0; // 0 = Create account, 1 = OTP
  String _emailForOtp = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      body: SafeArea(
        child: _currentTab == 0 ? _buildCreateAccountTab() : _buildOtpTab(),
      ),
    );
  }

  Widget _buildCreateAccountTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Gap(AppSizes.spacing),
          _buildTabHeader(),
          Gap(AppSizes.spacingLarge),
          SvgPicture.asset(
            AppSvgAssets.yoked,
            width: AppSizes.logoSmall,
            fit: BoxFit.contain,
          ),
          Gap(AppSizes.spacing),
          AppText(
            'Create your Account',
            textAlign: TextAlign.center,
            fontSize: Get.height * 0.03,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
          AppText(
            "Let's set up your spiritual journey as a couple.",
            textAlign: TextAlign.center,
            fontSize: Get.height * 0.014,
            color: AppColors.black,
          ),
          Gap(AppSizes.spacingLarge),
          AppTextField(
            hintText: 'First Name',
            textInputAction: TextInputAction.next,
          ),
          Gap(AppSizes.spacingMedium),
          AppTextField(
            hintText: 'Last Name',
            textInputAction: TextInputAction.next,
          ),
          Gap(AppSizes.spacingMedium),
          AppTextField(
            controller: _emailController,
            hintText: 'Email address',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          Gap(AppSizes.spacingMedium),
          AppTextField(
            hintText: 'Password',
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.hint,
                size: 22,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          Gap(AppSizes.spacingLarge),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              'Create Account',
              onPressed: _onCreateAccountTapped,
              backgroundColor: AppColors.primary,
              labelColor: AppColors.black,
            ),
          ),
          Gap(AppSizes.spacingLarge),
          _buildOrDivider(),
          Gap(AppSizes.spacingLarge),
          Row(
            children: [
              Expanded(
                child: _SocialButton(
                  assetPath: AppSvgAssets.google,
                  onPressed: () {},
                ),
              ),
              Gap(AppSizes.spacingMedium),
              Expanded(
                child: _SocialButton(
                  assetPath: AppSvgAssets.apple,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Gap(AppSizes.spacingLarge),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                'Already have an account? ',
                fontSize: AppSizes.fontSizeBody,
                color: AppColors.hint,
              ),
              GestureDetector(
                onTap: () => Get.offNamed(AppRoutes.login),
                child: AppText(
                  'Sign in',
                  fontSize: AppSizes.fontSizeBody,
                  fontWeight: FontWeight.w600,
                  color: AppColors.link,
                ),
              ),
            ],
          ),
          Gap(AppSizes.spacingLarge),
        ],
      ),
    );
  }

  void _onCreateAccountTapped() {
    _emailForOtp = _emailController.text.trim();
    if (_emailForOtp.isEmpty) _emailForOtp = 'The********thy@gmail.com';
    setState(() => _currentTab = 1);
  }

  Widget _buildTabHeader() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (_currentTab == 1) {
                setState(() => _currentTab = 0);
              } else {
                Get.offNamed(AppRoutes.login);
              }
            },
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: _currentTab == 0
                    ? AppColors.text
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
                    ? AppColors.text
                    : AppColors.textFieldBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOtpTab() {
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
                SvgPicture.asset(
                  AppSvgAssets.yoked,
                  width: AppSizes.logoSmall,
                  fit: BoxFit.contain,
                ),
                Gap(AppSizes.spacing),
                AppText(
                  'Enter 5-digit\nverification code.',
                  textAlign: TextAlign.center,
                  fontSize: AppSizes.fontSizeTitle,
                  fontWeight: FontWeight.w600,
                ),
                Gap(AppSizes.spacingSmall),
                AppText(
                  'Enter your OTP code sent to your email\nor mobile ${_maskEmail(_emailForOtp)}',
                  textAlign: TextAlign.center,
                  fontSize: Get.height * 0.016,
                ),
                Gap(AppSizes.spacingLarge),
                _buildOtpBoxes(),
                Gap(AppSizes.spacingLarge),
                ListenableBuilder(
                  listenable: _otpController,
                  builder: (context, _) {
                    final isComplete = _otpController.text.length == _otpLength;
                    return SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        isComplete ? 'Verify' : 'Next',
                        onPressed: _onOtpNextTapped,
                        backgroundColor: isComplete
                            ? AppColors.primary
                            : AppColors.textFieldFill,
                        labelColor: AppColors.black,
                      ),
                    );
                  },
                ),
                Gap(AppSizes.spacingLarge),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _maskEmail(String email) {
    if (email.isEmpty || !email.contains('@')) return '***@***.com';
    final parts = email.split('@');
    final name = parts[0];
    if (name.length <= 3) return '***@${parts[1]}';
    return '${name.substring(0, 3)}${'*' * (name.length - 3)}@${parts[1]}';
  }

  static const int _otpLength = 5;

  Widget _buildOtpBoxes() {
    final defaultPinTheme = PinTheme(
      width: Get.width * 0.14,
      height: Get.height * 0.06,
      textStyle: TextStyle(
        fontSize: AppSizes.fontSizeTitle,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      decoration: BoxDecoration(
        color: AppColors.textFieldFill,
        borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
        border: Border.all(color: AppColors.textFieldBorder),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.black),
      ),
    );
    return Pinput(
      length: _otpLength,
      controller: _otpController,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: defaultPinTheme,
      onCompleted: (_) {},
    );
  }

  Widget _buildOrDivider() {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: AppColors.textFieldBorder)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing),
          child: AppText(
            'or',
            fontSize: AppSizes.fontSizeBody,
            color: AppColors.hint,
          ),
        ),
        Expanded(child: Container(height: 1, color: AppColors.textFieldBorder)),
      ],
    );
  }

  void _onOtpNextTapped() {
    if (_otpController.text.length != _otpLength) return;
    Get.toNamed(
      AppRoutes.success,
      arguments: const SuccessScreenArgs(
        title: 'Congratulations!',
        message: 'Your email address & number has\nbeen confirmed',
        continueRoute: AppRoutes.accountSetup,
        continueLabel: 'Continue',
        showBackButton: true,
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.assetPath, required this.onPressed});

  final String assetPath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: AppSizes.spacing),
        side: BorderSide(color: AppColors.textFieldBorder),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
        ),
      ),
      child: SvgPicture.asset(assetPath, height: 24, width: 24),
    );
  }
}
