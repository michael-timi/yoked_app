import 'dart:ui';

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

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

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
                      title: 'Bible Plans',
                      subtitle: 'Let the Word shape your relationship.',
                    ),
                    SizedBox(height: Get.height * 0.13),
                  ],
                ),
                Positioned(
                  left: AppSizes.horizontalPadding,
                  right: AppSizes.horizontalPadding,
                  top: Get.height * 0.21,
                  child: _buildFloatingPlanCard(context),
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

  Widget _buildFloatingPlanCard(BuildContext context) {
    const progress = 2;
    const total = 7;
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
                  AppSvgAssets.plansNavbar,
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
                  'Stronger Communication',
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
            '7-day couples study',
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
          Gap(Get.height * 0.01),
          _buildTodaysScriptureCard(context),
          Gap(AppSizes.spacingMedium),
          _buildReflectionQuestionCard(context),
          Gap(AppSizes.spacingMedium),
          _buildPartnersResponseCard(context),
          Gap(AppSizes.spacingLarge),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              'Mark Complete & Continue',
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

  Widget _buildTodaysScriptureCard(BuildContext context) {
    return _PlanCard(
      title: 'Today\'s Scripture',
      subtitle: 'James 1:19',
      message:
          '"My dear brothers and sisters, take note of this: Everyone should be quick to listen, slow to speak and slow to become angry."',
      titleColor: AppColors.activeNavBarColor,
    );
  }

  Widget _buildReflectionQuestionCard(BuildContext context) {
    return _ReflectionQuestionCard(
      title: 'Reflection Question',
      subtitle:
          'What does it look like to listen before responding in your relationship?',
      titleColor: AppColors.activeNavBarColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            hintText: 'Write your reflection....',
            maxLines: 4,
            minLines: 3,
            keyboardType: TextInputType.multiline,
          ),
          Gap(AppSizes.spacingMedium),
          AppButton(
            'Submit Response',
            onPressed: () {},
            backgroundColor: AppColors.primary,
            labelColor: AppColors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildPartnersResponseCard(BuildContext context) {
    return const _PartnersResponseCard();
  }
}

class _PartnersResponseCard extends StatelessWidget {
  const _PartnersResponseCard();

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                'Partners Response',
                fontSize: Get.height * 0.018,
                fontWeight: FontWeight.w600,
                color: AppColors.activeNavBarColor,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    'Locked',
                    fontSize: Get.height * 0.018,
                    fontWeight: FontWeight.w500,
                  ),
                  Gap(Get.height * 0.005),
                  SvgPicture.asset(
                    AppSvgAssets.lock,
                    width: Get.height * 0.015,
                    height: Get.height * 0.015,
                    colorFilter: const ColorFilter.mode(
                      AppColors.text,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Gap(AppSizes.spacingSmall),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(AppSizes.spacing),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppSizes.textFieldRadius,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        '"My dear brothers and sisters, take note of this: Everyone should be quick to listen, slow to speak and slow to become angry."',
                        fontSize: Get.height * 0.016,
                        color: AppColors.text,
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppSizes.textFieldRadius,
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.06),
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: SizedBox(
                          width: Get.width * 0.7,
                          child: AppButton(
                            'Submit your response',
                            onPressed: () {},
                            backgroundColor: AppColors.white,
                            labelColor: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.title,
    required this.subtitle,
    required this.titleColor,
    required this.message,
  });

  final String title;
  final String subtitle;
  final Color titleColor;
  final String message;

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
          Row(
            children: [
              AppText(
                title,
                fontSize: Get.height * 0.018,
                fontWeight: FontWeight.w600,
                color: titleColor,
              ),
              Gap(Get.height * 0.005),
              AppText(
                subtitle,
                fontSize: Get.height * 0.018,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          Gap(AppSizes.spacingSmall),
          Container(
            padding: EdgeInsets.all(Get.height * 0.02),
            decoration: BoxDecoration(
              color: AppColors.textFieldFill.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(AppSizes.radius),
            ),
            child: AppText(
              message,
              fontSize: Get.height * 0.018,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReflectionQuestionCard extends StatelessWidget {
  const _ReflectionQuestionCard({
    required this.title,
    required this.subtitle,
    required this.titleColor,
    required this.child,
  });

  final String title;
  final String subtitle;
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
          Gap(Get.height * 0.005),
          AppText(
            subtitle,
            fontSize: Get.height * 0.018,
            fontWeight: FontWeight.w600,
          ),
          Gap(AppSizes.spacingSmall),
          child,
        ],
      ),
    );
  }
}
