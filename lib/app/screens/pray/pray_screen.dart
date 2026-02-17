import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:yoked_app/core/constants/app_png_assets.dart';
import '../../../core/constants/app_svg_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/app_screen_header.dart';

class PrayScreen extends StatelessWidget {
  const PrayScreen({super.key});

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
                  children: [
                    AppScreenHeader(
                      title: 'Prayer',
                      subtitle: 'Build a prayer altar for your relationship.',
                    ),
                    SizedBox(height: Get.height * 0.13),
                  ],
                ),
                Positioned(
                  left: AppSizes.horizontalPadding,
                  right: AppSizes.horizontalPadding,
                  top: Get.height * 0.21,
                  child: _buildWeeklyGoalCard(context),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: _buildPrayNowButton(context)),
          SliverToBoxAdapter(child: _buildPrayerRequestsSection(context)),
          SliverToBoxAdapter(child: Gap(Get.height * 0.1)),
        ],
      ),
    );
  }


  Widget _buildWeeklyGoalCard(BuildContext context) {
    const progress = 3;
    const total = 5;
    return Container(
      padding: EdgeInsets.all(Get.height * 0.025),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppText(
                '$progress of $total',
                fontSize: Get.height * 0.018,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
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
              Expanded(
                child: AppText(
                  'Weekly Goal',
                  fontSize: Get.height * 0.026,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Gap(AppSizes.spacingSmall),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress / total,
              minHeight: Get.height * 0.007,
              backgroundColor: AppColors.black.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.black),
            ),
          ),
          Gap(Get.height * 0.005),
          AppText(
            '${total - progress} more sessions to reach your goal',
            fontSize: Get.height * 0.018,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Widget _buildPrayNowButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSizes.horizontalPadding,
        AppSizes.spacing,
        AppSizes.horizontalPadding,
        AppSizes.spacingMedium,
      ),
      child: SizedBox(
        width: double.infinity,
        child: AppButton(
          'Pray Now',
          onPressed: () {},
          backgroundColor: AppColors.black,
          labelColor: AppColors.white,
        ),
      ),
    );
  }

  Widget _buildPrayerRequestsSection(BuildContext context) {
    final requests = [
      ('Peace in communication', 'Added by both • 2 days ago'),
      ('Financial wisdom', 'Added by Stephan • 5 days ago'),
      ('Strength in purity', 'Added by Sarah • 2 days ago'),
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText(
            'Prayer Requests',
            fontSize: Get.height * 0.018,
            fontWeight: FontWeight.w600,
          ),
          Gap(AppSizes.spacingMedium),
          ...requests.map(
            (r) => Padding(
              padding: EdgeInsets.only(bottom: AppSizes.spacingSmall),
              child: _PrayerRequestCard(title: r.$1, subtitle: r.$2),
            ),
          ),
          Gap(AppSizes.spacingMedium),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              'Add Prayer Request',
              onPressed: () => _showAddPrayerRequestModal(context),
              backgroundColor: AppColors.primary,
              labelColor: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddPrayerRequestModal(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AddPrayerRequestSheet(),
    );
  }
}

class _AddPrayerRequestSheet extends StatefulWidget {
  @override
  State<_AddPrayerRequestSheet> createState() => _AddPrayerRequestSheetState();
}

class _AddPrayerRequestSheetState extends State<_AddPrayerRequestSheet> {
  final TextEditingController _controller = TextEditingController();
  bool _shareWithPartner = true;
  bool _keepPrivate = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.radius * 1.5),
          topRight: Radius.circular(AppSizes.radius * 1.5),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        AppSizes.horizontalPadding,
        AppSizes.spacingLarge,
        AppSizes.horizontalPadding,
        AppSizes.spacingLarge + MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            controller: _controller,
            hintText: 'What would you like to pray for?',
            maxLines: 4,
            minLines: 3,
            keyboardType: TextInputType.multiline,
          ),
          Gap(AppSizes.spacingLarge),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Switch(
                    padding: EdgeInsets.zero,
                    value: _shareWithPartner,
                    onChanged: (v) {
                      setState(() {
                        _shareWithPartner = v;
                        if (v) _keepPrivate = false;
                      });
                    },
                    activeThumbColor: AppColors.primary,
                    activeTrackColor: AppColors.primary.withValues(alpha: 0.6),
                  ),
                  Gap(Get.height * 0.01),
                  AppText(
                    'Share with partner',
                    fontSize: Get.height * 0.018,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Switch(
                    padding: EdgeInsets.zero,
                    value: _keepPrivate,
                    onChanged: (v) {
                      setState(() {
                        _keepPrivate = v;
                        if (v) _shareWithPartner = false;
                      });
                    },
                    activeThumbColor: AppColors.primary,
                    activeTrackColor: AppColors.primary.withValues(alpha: 0.6),
                  ),
                  Gap(Get.height * 0.01),
                  AppText(
                    'Keep private',
                    fontSize: Get.height * 0.018,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),
          Gap(AppSizes.spacingLarge),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  'Close',
                  onPressed: () => Navigator.of(context).pop(),
                  backgroundColor: AppColors.black,
                  labelColor: AppColors.white,
                ),
              ),
              Gap(AppSizes.spacingMedium),
              Expanded(
                child: AppButton(
                  'Save Request',
                  onPressed: () {
                    // TODO: save request
                    Navigator.of(context).pop();
                  },
                  backgroundColor: AppColors.primary,
                  labelColor: AppColors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrayerRequestCard extends StatelessWidget {
  const _PrayerRequestCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Get.height * 0.025),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius),
        border: Border.all(color: AppColors.black.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AppSvgAssets.peopleIcon,
            width: Get.height * 0.04,
            height: Get.height * 0.04,
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
                  fontSize: Get.height * 0.016,
                  fontWeight: FontWeight.w600,
                  color: AppColors.hint,
                ),
              ],
            ),
          ),
          Icon(
            Icons.favorite_border,
            color: AppColors.activeNavBarColor,
            size: Get.height * 0.03,
          ),
        ],
      ),
    );
  }
}
