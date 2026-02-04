import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_png_assets.dart';
import '../../../core/constants/app_svg_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/widgets/app_text.dart';
import '../../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  bool _showPostFlipPhase = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: AppConstants.mediumAnimation,
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
    _fadeController = AnimationController(
      vsync: this,
      duration: AppConstants.mediumAnimation,
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));
    _runSequence();
  }

  Future<void> _runSequence() async {
    // Show upside logo briefly
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    // Flip to right-side-up logo
    await _flipController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    // Switch to post-flip phase: primaryLight background + splashBackground + yoked + tagline
    setState(() => _showPostFlipPhase = true);
    await Future.delayed(const Duration(milliseconds: 50));
    if (!mounted) return;
    await _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    Get.offNamed(AppRoutes.start);
  }

  @override
  void dispose() {
    _flipController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_showPostFlipPhase) {
      return _buildFlipPhase(context);
    }
    return _buildPostFlipPhase(context);
  }

  Widget _buildFlipPhase(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _flipAnimation,
            builder: (context, child) {
              final angle = _flipAnimation.value * 3.14159; // 0 to π
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(angle),
                child: SvgPicture.asset(
                  _flipAnimation.value < 0.5
                      ? AppSvgAssets.yokedLogo
                      : AppSvgAssets.yokedLogoUpside,
                  width: AppSizes.logoMedium,
                  height: AppSizes.logoMedium,
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPostFlipPhase(BuildContext context) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: AppColors.primaryLight,
          body: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              image: DecorationImage(
                image: AssetImage(AppPngAssets.splashBackground),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Opacity(
                opacity: _fadeAnimation.value,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.horizontalPaddingLarge,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppSvgAssets.yoked,
                          width: AppSizes.logoWidthWide,
                          fit: BoxFit.contain,
                        ),
                        Gap(AppSizes.spacingMedium),
                        AppText(
                          'Grow closer to God together.',
                          textAlign: TextAlign.center,
                          color: AppColors.text,
                          fontSize: AppSizes.fontSizeBody,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
