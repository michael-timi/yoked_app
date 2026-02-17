import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_png_assets.dart';
import '../../../core/constants/app_svg_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/widgets/app_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          image: DecorationImage(
            image: AssetImage(AppPngAssets.splashBackground),
            fit: BoxFit.cover,
            opacity: 0.08,
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeaderWithFloatingCard(context)),
              SliverToBoxAdapter(child: _buildActionButtons(context)),
              SliverToBoxAdapter(child: _buildQuoteCard(context)),
              SliverToBoxAdapter(child: _buildStreaksSection(context)),
              const SliverToBoxAdapter(child: Gap(100)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderWithFloatingCard(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            SizedBox(height: Get.height * 0.1),
          ],
        ),
        Positioned(
          left: AppSizes.horizontalPadding,
          right: AppSizes.horizontalPadding,
          top: Get.height * 0.18,
          child: _buildTodaysFocusCard(context),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: Get.height * 0.3,
      width: double.infinity,
      padding: EdgeInsets.all(Get.height * 0.025),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.1),
            AppColors.primaryLight,
            AppColors.primaryLight,
            AppColors.primaryLight,
          ],
          begin: Alignment.bottomLeft,
          // end: Alignment.bottomRight,
        ),
        image: DecorationImage(
          alignment: Alignment.centerLeft,
          image: AssetImage(AppPngAssets.topographic4),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.textFieldFill,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.black.withValues(alpha: 0.15),
                  ),
                ),
                child: SvgPicture.asset(
                  AppSvgAssets.bell,
                  width: Get.height * 0.035,
                  height: Get.height * 0.035,
                ),
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                'Good morning,',
                fontSize: Get.height * 0.03,
                color: AppColors.black.withValues(alpha: 0.6),
                fontWeight: FontWeight.w500,
              ),
              AppText(
                'Stephan & Sarah 👋',
                fontSize: Get.height * 0.03,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTodaysFocusCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Get.height * 0.02),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppSizes.radius),
        image: DecorationImage(
          alignment: Alignment.centerLeft,
          image: AssetImage(AppPngAssets.topographic2),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppSvgAssets.prayNavbar,
                  width: Get.height * 0.03,
                  height: Get.height * 0.03,
                  colorFilter: const ColorFilter.mode(
                    AppColors.activeNavBarColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Gap(AppSizes.spacingSmall),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'Today\'s Focus',
                    fontSize: Get.height * 0.018,
                    fontWeight: FontWeight.w500,
                  ),
                  AppText(
                    'Pray Together',
                    fontSize: Get.height * 0.034,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ],
          ),

          AppText(
            'Day 3 of plan',
            fontSize: Get.height * 0.018,
            fontWeight: FontWeight.w500,
          ),
          Gap(AppSizes.spacingSmall),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 1 / 3,
              minHeight: Get.height * 0.007,
              backgroundColor: AppColors.black.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.black),
            ),
          ),
          Gap(Get.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _dot(active: true),
              Gap(6),
              _dot(active: false),
              Gap(6),
              _dot(active: false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dot({required bool active}) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active
            ? AppColors.white
            : AppColors.white.withValues(alpha: 0.2),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final assets = [
      (AppSvgAssets.prayNow, 'Pray Now'),
      (AppSvgAssets.readPlan, 'Read Plan'),
      (AppSvgAssets.startFast, 'Start a Fast'),
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding),
      child: Row(
        children: List.generate(3, (i) {
          final (asset, label) = assets[i];
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: i < 2 ? AppSizes.spacingSmall : 0,
              ),
              child: _ActionCard(asset: asset, label: label),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildQuoteCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.horizontalPadding),
      child: Container(
        padding: EdgeInsets.all(Get.height * 0.025),
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(AppSizes.radius),
          image: DecorationImage(
            alignment: Alignment.centerRight,
            image: AssetImage(AppPngAssets.topographic3),
            fit: BoxFit.fitHeight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.bookmark, color: AppColors.primary, size: 22),
                AppText(
                  '"As for me and my house,\nwe will serve the Lord."\nJoshua 24:15',
                  textAlign: TextAlign.center,
                  fontSize: Get.height * 0.02,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
                Gap(AppSizes.spacingSmall),
              ],
            ),

            Gap(Get.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _dot(active: true),
                Gap(6),
                _dot(active: false),
                Gap(6),
                _dot(active: false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreaksSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                'Your Streaks',
                fontSize: Get.height * 0.018,
                fontWeight: FontWeight.w600,
              ),
              GestureDetector(
                onTap: () {},
                child: AppText(
                  'View All  >',
                  fontSize: Get.height * 0.016,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Gap(AppSizes.spacingMedium),
          _StreakTile(
            emoji: '🔥',
            title: 'Prayer',
            subtitle: '20 Min . 8:00 PM . Daily',
            streakLabel: '7 Streak',
            completed: true,
          ),
          Gap(AppSizes.spacingSmall),
          _StreakTile(
            emoji: '📚',
            title: 'Bible plan',
            subtitle: '20 Min . 8:00 PM . Daily',
            streakLabel: '4 Streak',
            completed: true,
          ),
          Gap(AppSizes.spacingSmall),
          _StreakTile(
            emoji: '🙏',
            title: 'Fasting',
            subtitle: '20 Min . 8:00 PM . Daily',
            streakLabel: '3 Streak',
            completed: false,
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.asset, required this.label});

  final String asset;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppSizes.radius),
      elevation: 0,
      shadowColor: AppColors.black.withValues(alpha: 0.06),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(AppSizes.radius),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.025),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(asset, width: 40, height: 40),
              Gap(Get.height * 0.01),
              AppText(
                label,
                fontSize: Get.height * 0.018,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StreakTile extends StatelessWidget {
  const _StreakTile({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.streakLabel,
    required this.completed,
  });

  final String emoji;
  final String title;
  final String subtitle;
  final String streakLabel;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Get.height * 0.02),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.textFieldBorder),
      ),
      child: Row(
        children: [
          Container(
            width: Get.height * 0.06,
            height: Get.height * 0.06,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.orange, width: 4),
            ),
            alignment: Alignment.center,
            child: Text(emoji, style: TextStyle(fontSize: 24)),
          ),
          Gap(Get.height * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  title,
                  fontSize: Get.height * 0.018,
                  fontWeight: FontWeight.w600,
                ),
                AppText(
                  subtitle,
                  fontSize: Get.height * 0.014,
                  fontWeight: FontWeight.w600,
                  color: AppColors.hint,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.textFieldFill,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AppText(
                  streakLabel,
                  fontSize: Get.height * 0.014,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gap(Get.height * 0.01),
              Icon(
                completed ? Icons.check_circle : Icons.radio_button_unchecked,
                color: completed ? AppColors.green : AppColors.textFieldBorder,
                size: 22,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
