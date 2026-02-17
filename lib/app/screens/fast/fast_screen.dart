import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_png_assets.dart';
import '../../../core/constants/app_svg_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/app_screen_header.dart';

class FastScreen extends StatelessWidget {
  const FastScreen({super.key});

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
                      title: 'Fasting',
                      subtitle: 'Discipline brings clarity.',
                    ),
                    SizedBox(height: Get.height * 0.13),
                  ],
                ),
                Positioned(
                  left: AppSizes.horizontalPadding,
                  right: AppSizes.horizontalPadding,
                  top: Get.height * 0.21,
                  child: _buildCurrentFastCard(context),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: _buildBody(context)),
          SliverToBoxAdapter(child: Gap(Get.height * 0.1)),
        ],
      ),
    );
  }

  Widget _buildCurrentFastCard(BuildContext context) {
    const progress = 2;
    const total = 3;
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
                  AppSvgAssets.fastNavbar,
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
                  'Social Media Fast',
                  fontSize: Get.height * 0.024,
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
            'Ends today at 1:56 AM',
            fontSize: Get.height * 0.018,
            fontWeight: FontWeight.w500,
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
          AppText(
            'Day 3: Stronger Communication',
            fontSize: Get.height * 0.018,
            fontWeight: FontWeight.w600,
          ),
          Gap(AppSizes.spacingMedium),
          _buildPurposeCard(context),
          Gap(AppSizes.spacingMedium),
          _buildFastingReflectionCard(context),
          Gap(AppSizes.spacingMedium),
          _buildRecentReflectionsSection(context),
          Gap(AppSizes.spacingLarge),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              'Plan Next Fast',
              onPressed: () {},
              backgroundColor: AppColors.black,
              labelColor: AppColors.white,
            ),
          ),
          Gap(AppSizes.spacingLarge),
        ],
      ),
    );
  }

  Widget _buildPurposeCard(BuildContext context) {
    return _FastCard(
      title: 'Purpose',
      titleColor: AppColors.activeNavBarColor,
      child: Container(
        padding: EdgeInsets.all(AppSizes.spacing),
        decoration: BoxDecoration(
          color: AppColors.textFieldFill.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(AppSizes.radius),
        ),
        child: AppText(
          'To create more space for intentional connection with God and each other, free from digital distractions.',
          fontSize: Get.height * 0.018,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildFastingReflectionCard(BuildContext context) {
    return _FastCard(
      title: 'Fasting Reflection',
      titleColor: AppColors.activeNavBarColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText(
            'How has this fast impacted you today?',
            fontSize: Get.height * 0.018,
            fontWeight: FontWeight.w600,
          ),
          Gap(AppSizes.spacingMedium),
          AppTextField(
            hintText: 'Share your thoughts and experience...',
            maxLines: 5,
            minLines: 4,
            keyboardType: TextInputType.multiline,
          ),
          Gap(AppSizes.spacingMedium),
          AppButton(
            'Save Reflection',
            onPressed: () {},
            backgroundColor: AppColors.primary,
            labelColor: AppColors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentReflectionsSection(BuildContext context) {
    final reflections = [
      (
        'Stephan',
        'Day 1',
        'Felt restless at first, but spent the extra time reading and praying. It\'s amazing how much time I was spending scrolling without realizing it.',
      ),
      (
        'Sarah',
        'Day 1',
        'Had more meaningful conversations today. We talked about things that really matter instead of just sharing what we saw online.',
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          'Recent Reflections',
          fontSize: Get.height * 0.018,
          fontWeight: FontWeight.w600,
        ),
        Gap(AppSizes.spacingMedium),
        ...reflections.map(
          (r) => Padding(
            padding: EdgeInsets.only(bottom: AppSizes.spacingSmall),
            child: _ReflectionCard(name: r.$1, day: r.$2, text: r.$3),
          ),
        ),
      ],
    );
  }
}

class _FastCard extends StatelessWidget {
  const _FastCard({
    required this.title,
    required this.titleColor,
    required this.child,
  });

  final String title;
  final Color titleColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.spacing),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText(
            title,
            fontSize: Get.height * 0.018,
            fontWeight: FontWeight.w600,
            color: titleColor,
          ),
          Gap(AppSizes.spacingSmall),
          child,
        ],
      ),
    );
  }
}

class _ReflectionCard extends StatelessWidget {
  const _ReflectionCard({
    required this.name,
    required this.day,
    required this.text,
  });

  final String name;
  final String day;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.spacing),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.activeNavBarColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: AppText(
                  name[0],
                  fontSize: Get.height * 0.018,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              Gap(AppSizes.spacingSmall),
              Expanded(
                child: Row(
                  children: [
                    AppText(
                      name,
                      fontSize: Get.height * 0.018,
                      fontWeight: FontWeight.w600,
                    ),
                    Gap(Get.height * 0.005),

                    AppText(
                      ' ·  $day',
                      fontSize: Get.height * 0.018,
                      fontWeight: FontWeight.w600,
                      color: AppColors.hint,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(Get.height * 0.01),
          AppText(
            text,
            fontSize: Get.height * 0.018,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
