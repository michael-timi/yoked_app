import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_png_assets.dart';
import '../../../core/constants/app_svg_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_screen_header.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppScreenHeader(
                      title: 'Progress',
                      subtitle: 'Consistency is spiritual growth.',
                    ),
                    SizedBox(height: Get.height * 0.13),
                  ],
                ),
                Positioned(
                  left: AppSizes.horizontalPadding,
                  right: AppSizes.horizontalPadding,
                  top: Get.height * 0.21,
                  child: _buildThisWeekCard(context),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: _buildBody(context)),
          const SliverToBoxAdapter(child: Gap(120)),
        ],
      ),
    );
  }

  Widget _buildThisWeekCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: Get.height * 0.025,
        top: Get.height * 0.025,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppSizes.radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
        image: DecorationImage(
          alignment: Alignment.centerLeft,
          image: AssetImage(AppPngAssets.topographic2),
          fit: BoxFit.fitHeight,
          opacity: 0.4,
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    AppSvgAssets.progressNavbar,
                    width: Get.height * 0.02,
                    height: Get.height * 0.02,
                    colorFilter: const ColorFilter.mode(
                      AppColors.text,
                      BlendMode.srcIn,
                    ),
                  ),
                  Gap(Get.height * 0.005),
                  AppText(
                    'This Week',
                    fontSize: Get.height * 0.018,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),

              AppText(
                '12',
                fontSize: Get.height * 0.05,
                fontWeight: FontWeight.w600,
              ),
              AppText(
                'Sessions completed together',
                fontSize: Get.height * 0.018,
                fontWeight: FontWeight.w500,
              ),
              Gap(Get.height * 0.025),
            ],
          ),
          SvgPicture.asset(
            AppSvgAssets.trendingUp,
            height: Get.height * 0.11,
            alignment: Alignment.bottomRight,
            fit: BoxFit.fitHeight,
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Gap(AppSizes.spacing),
          _buildActivityBreakdown(context),
          Gap(AppSizes.spacingLarge),
          _buildCalendarView(context),
          Gap(AppSizes.spacingLarge),
          _buildMilestonesSection(context),
          Gap(AppSizes.spacingLarge),
          _buildSummaryCards(context),
          Gap(AppSizes.spacingLarge),
        ],
      ),
    );
  }

  Widget _buildActivityBreakdown(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Get.height * 0.03),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText(
            'Activity Breakdown',
            fontSize: Get.height * 0.018,
            fontWeight: FontWeight.w600,
            color: AppColors.activeNavBarColor,
          ),
          Gap(AppSizes.spacingMedium),
          _ActivityItem(
            icon: AppSvgAssets.prayNavbar,
            title: 'Prayer',
            progress: 5 / 7,
            sessions: '5 sessions',
            color: AppColors.activeNavBarColor,
          ),
          Gap(AppSizes.spacing),
          _ActivityItem(
            icon: AppSvgAssets.plansNavbar,
            title: 'Bible Study',
            progress: 3 / 7,
            sessions: '3 sessions',
            color: AppColors.purple,
          ),
          Gap(AppSizes.spacing),
          _ActivityItem(
            icon: AppSvgAssets.fastNavbar,
            title: 'Fasting',
            progress: 1.0,
            sessions: 'Active',
            color: AppColors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarView(BuildContext context) {
    final days = [
      ('Mon', '6', true, false),
      ('Tue', '7', true, false),
      ('Wed', '8', false, true),
      ('Thu', '9', false, false),
      ('Fri', '10', false, false),
      ('Sat', '11', false, false),
    ];
    return Container(
      padding: EdgeInsets.all(Get.height * 0.03),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                'This Week',
                fontSize: Get.height * 0.018,
                fontWeight: FontWeight.w600,
              ),
              AppText(
                'January, 2026',
                fontSize: Get.height * 0.018,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          Gap(AppSizes.spacingMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: days.map((day) {
              final (label, number, isCompleted, isToday) = day;
              return Expanded(
                child: Column(
                  children: [
                    AppText(
                      label,
                      fontSize: Get.height * 0.014,
                      color: AppColors.hint,
                    ),
                    Gap(4),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isToday
                            ? AppColors.activeNavBarColor
                            : isCompleted
                            ? AppColors.primaryLight
                            : AppColors.white,
                        border: Border.all(
                          color: isToday || isCompleted
                              ? Colors.transparent
                              : AppColors.activeNavBarColor,
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: AppText(
                        number,
                        fontSize: Get.height * 0.016,
                        fontWeight: FontWeight.w600,
                        color: isToday || isCompleted
                            ? AppColors.text
                            : AppColors.activeNavBarColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          Gap(AppSizes.spacingSmall),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Gap(4),
              AppText(
                'Completed',
                fontSize: Get.height * 0.012,
                color: AppColors.hint,
              ),
              Gap(AppSizes.spacingMedium),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.activeNavBarColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Gap(4),
              AppText(
                'Today',
                fontSize: Get.height * 0.012,
                color: AppColors.hint,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMilestonesSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Get.height * 0.03),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText(
            'Milestones',
            fontSize: Get.height * 0.022,
            fontWeight: FontWeight.w600,
            color: AppColors.activeNavBarColor,
          ),
          Gap(AppSizes.spacingMedium),
          _MilestoneCard(
            title: '7- Day Prayer Streak',
            status: 'Achieved Jan 8, 2026',
            achieved: true,
          ),
          Gap(AppSizes.spacingSmall),
          _MilestoneCard(
            title: 'First Plan Completed',
            status: 'Achieved Jan 8, 2026',
            achieved: true,
          ),
          Gap(AppSizes.spacingSmall),
          _MilestoneCard(
            title: '14-Day Study Streak',
            status: '3/14',
            achieved: false,
            progress: 3 / 14,
          ),
          Gap(AppSizes.spacingSmall),
          _MilestoneCard(
            title: '30-Day Consistency',
            status: 'Keep going to unlock',
            achieved: false,
            isLocked: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(Get.height * 0.02),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(AppSizes.radius),
            ),
            child: Column(
              children: [
                AppText(
                  '24',
                  fontSize: Get.height * 0.038,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
                AppText(
                  'Total Days Active',
                  fontSize: Get.height * 0.018,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ],
            ),
          ),
        ),
        Gap(AppSizes.spacingMedium),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(Get.height * 0.02),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppSizes.radius),
            ),
            child: Column(
              children: [
                AppText(
                  '3',
                  fontSize: Get.height * 0.038,
                  fontWeight: FontWeight.w600,
                ),
                AppText(
                  'Plans Completed',
                  fontSize: Get.height * 0.018,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ActivityItem extends StatelessWidget {
  const _ActivityItem({
    required this.icon,
    required this.title,
    required this.progress,
    required this.sessions,
    required this.color,
  });

  final String icon;
  final String title;
  final double progress;
  final String sessions;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: Get.height * 0.05,
          height: Get.height * 0.05,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            icon,
            width: Get.height * 0.03,
            height: Get.height * 0.03,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
        ),
        Gap(Get.height * 0.01),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    title,
                    fontSize: Get.height * 0.018,
                    fontWeight: FontWeight.w500,
                  ),
                  AppText(
                    sessions,
                    fontSize: Get.height * 0.018,
                    fontWeight: FontWeight.w500,
                    color: AppColors.hint,
                  ),
                ],
              ),
              Gap(4),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 7,
                  backgroundColor: color.withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MilestoneCard extends StatelessWidget {
  const _MilestoneCard({
    required this.title,
    required this.status,
    required this.achieved,
    this.progress,
    this.isLocked = false,
  });

  final String title;
  final String status;
  final bool achieved;
  final double? progress;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    final iconColor = achieved ? AppColors.activeNavBarColor : AppColors.hint;
    return Container(
      padding: EdgeInsets.all(Get.height * 0.015),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.hint),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppSvgAssets.champion,
              width: Get.height * 0.03,
              height: Get.height * 0.03,
            ),
          ),
          Gap(AppSizes.spacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  title,
                  fontSize: Get.height * 0.018,
                  fontWeight: FontWeight.w600,
                ),
                if (progress != null) ...[
                  Gap(4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 4,
                      backgroundColor: AppColors.textFieldFill,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.green,
                      ),
                    ),
                  ),
                ],
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      status,
                      fontSize: Get.height * 0.016,
                      fontWeight: FontWeight.w500,
                      color: AppColors.hint,
                    ),
                    if (isLocked) ...[
                      Gap(4),
                      Icon(Icons.lock_outline, size: 16, color: AppColors.hint),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
