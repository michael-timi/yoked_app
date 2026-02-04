import 'package:flutter/material.dart';
import '../constants/app_fonts.dart';
import '../theme/app_colors.dart';
import '../utils/app_sizes.dart';

/// A [TextField] with app defaults: light fill, rounded border, Hellix font,
/// optional [suffixIcon] (e.g. password visibility toggle).
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.textInputAction = TextInputAction.next,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
    this.autofillHints,
    this.focusNode,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
  });

  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Iterable<String>? autofillHints;
  final FocusNode? focusNode;
  final bool enabled;
  final int? maxLines;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      enabled: enabled,
      maxLines: obscureText ? 1 : maxLines,
      minLines: minLines,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      autofillHints: autofillHints,
      style: TextStyle(
        fontFamily: AppFonts.hellix,
        fontSize: AppSizes.fontSizeBody,
        color: AppColors.text,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: AppFonts.hellix,
          fontSize: AppSizes.fontSizeBody,
          color: AppColors.hint,
        ),
        filled: true,
        fillColor: AppColors.textFieldFill,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalPadding,
          vertical: AppSizes.buttonPadding,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
          borderSide: const BorderSide(color: AppColors.textFieldBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
          borderSide: const BorderSide(color: AppColors.textFieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
          borderSide: const BorderSide(color: AppColors.text, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
          borderSide: const BorderSide(color: AppColors.red),
        ),
        errorStyle: const TextStyle(color: AppColors.red),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
