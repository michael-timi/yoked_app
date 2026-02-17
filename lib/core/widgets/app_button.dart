import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';
import '../utils/app_sizes.dart';
import 'app_text.dart';

/// A button widget that uses app defaults (Hellix via [AppText], padding, radius)
/// and optional style overrides.
class AppButton extends StatelessWidget {
  const AppButton(
    this.label, {
    super.key,
    required this.onPressed,
    this.child,
    this.style,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.minimumSize,
    this.maximumSize,
    this.fixedSize,
    this.side,
    this.shape,
    this.labelColor,
    this.labelFontWeight = FontWeight.w600,
    this.labelFontSize,
  }) : _variant = _ButtonVariant.filled;

  const AppButton.outlined(
    this.label, {
    super.key,
    required this.onPressed,
    this.child,
    this.style,
    this.foregroundColor,
    this.padding,
    this.minimumSize,
    this.maximumSize,
    this.fixedSize,
    this.side,
    this.shape,
    this.labelColor,
    this.labelFontWeight = FontWeight.w600,
    this.labelFontSize,
  }) : _variant = _ButtonVariant.outlined,
       backgroundColor = null;

  const AppButton.text(
    this.label, {
    super.key,
    required this.onPressed,
    this.child,
    this.style,
    this.foregroundColor,
    this.padding,
    this.minimumSize,
    this.maximumSize,
    this.fixedSize,
    this.labelColor,
    this.labelFontWeight,
    this.labelFontSize,
  }) : _variant = _ButtonVariant.text,
       backgroundColor = null,
       side = null,
       shape = null;

  final String label;
  final VoidCallback? onPressed;

  /// When non-null, shown instead of [label] (e.g. for icon-only buttons).
  final Widget? child;
  final ButtonStyle? style;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final Size? minimumSize;
  final Size? maximumSize;
  final Size? fixedSize;
  final BorderSide? side;
  final OutlinedBorder? shape;
  final Color? labelColor;
  final FontWeight? labelFontWeight;
  final double? labelFontSize;

  final _ButtonVariant _variant;

  static double get _defaultPadding => AppSizes.buttonPadding;
  static double get _defaultRadius => AppSizes.radius;

  EdgeInsetsGeometry get _resolvedPadding =>
      padding ?? EdgeInsets.symmetric(vertical: _defaultPadding);

  OutlinedBorder get _defaultShape => RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(_defaultRadius),
  );

  Widget get _label => AppText(
    label,
    color: labelColor ?? foregroundColor ?? AppColors.white,
    fontWeight: labelFontWeight,
    fontSize: labelFontSize ?? Get.height * 0.018,
  );

  Widget get _content => child ?? _label;

  @override
  Widget build(BuildContext context) {
    switch (_variant) {
      case _ButtonVariant.filled:
        return FilledButton(
          onPressed: onPressed,
          style: (style ?? FilledButton.styleFrom()).copyWith(
            backgroundColor: WidgetStateProperty.all(
              backgroundColor ?? AppColors.black,
            ),

            foregroundColor: WidgetStateProperty.all(
              foregroundColor ?? AppColors.white,
            ),
            padding: WidgetStateProperty.all(_resolvedPadding),
            minimumSize: minimumSize != null
                ? WidgetStateProperty.all(minimumSize)
                : null,
            maximumSize: maximumSize != null
                ? WidgetStateProperty.all(maximumSize)
                : null,
            fixedSize: fixedSize != null
                ? WidgetStateProperty.all(fixedSize)
                : null,
            shape: WidgetStateProperty.all(shape ?? _defaultShape),
          ),
          child: _content,
        );
      case _ButtonVariant.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: (style ?? OutlinedButton.styleFrom()).copyWith(
            foregroundColor: WidgetStateProperty.all(
              foregroundColor ?? AppColors.white,
            ),
            padding: WidgetStateProperty.all(_resolvedPadding),
            minimumSize: minimumSize != null
                ? WidgetStateProperty.all(minimumSize)
                : null,
            maximumSize: maximumSize != null
                ? WidgetStateProperty.all(maximumSize)
                : null,
            fixedSize: fixedSize != null
                ? WidgetStateProperty.all(fixedSize)
                : null,
            side: WidgetStateProperty.all(
              side ?? BorderSide(color: AppColors.text),
            ),
            shape: WidgetStateProperty.all(shape ?? _defaultShape),
          ),
          child: _content,
        );
      case _ButtonVariant.text:
        return TextButton(
          onPressed: onPressed,
          style: (style ?? TextButton.styleFrom()).copyWith(
            foregroundColor: WidgetStateProperty.all(
              foregroundColor ?? AppColors.white,
            ),
            padding: WidgetStateProperty.all(_resolvedPadding),
            minimumSize: minimumSize != null
                ? WidgetStateProperty.all(minimumSize)
                : null,
            maximumSize: maximumSize != null
                ? WidgetStateProperty.all(maximumSize)
                : null,
            fixedSize: fixedSize != null
                ? WidgetStateProperty.all(fixedSize)
                : null,
          ),
          child: _content,
        );
    }
  }
}

enum _ButtonVariant { filled, outlined, text }
