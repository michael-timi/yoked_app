import 'package:flutter/material.dart';
import '../constants/app_fonts.dart';

/// A [Text] widget that uses the Hellix font family by default.
/// Pass [style] to override or merge with the default font.
class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
  }) : textSpan = null;

  const AppText.rich(
    this.textSpan, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
  }) : data = null,
       assert(textSpan != null);

  final String? data;
  final InlineSpan? textSpan;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  /// Convenience: applied to the merged style
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;

  static const String _defaultFontFamily = AppFonts.hellix;

  TextStyle _resolveStyle(BuildContext context) {
    final base = style ?? DefaultTextStyle.of(context).style;
    return base.copyWith(
      fontFamily: _defaultFontFamily,
      fontWeight: fontWeight ?? base.fontWeight,
      fontSize: fontSize ?? base.fontSize,
      color: color ?? base.color,
      letterSpacing: letterSpacing ?? base.letterSpacing,
      wordSpacing: wordSpacing ?? base.wordSpacing,
      height: height ?? base.height,
      decoration: decoration ?? base.decoration,
      decorationColor: decorationColor ?? base.decorationColor,
      decorationStyle: decorationStyle ?? base.decorationStyle,
      decorationThickness: decorationThickness ?? base.decorationThickness,
    );
  }

  @override
  Widget build(BuildContext context) {
    final resolvedStyle = _resolveStyle(context);
    if (textSpan != null) {
      return Text.rich(
        textSpan!,
        style: resolvedStyle,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      );
    }
    return Text(
      data!,
      style: resolvedStyle,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}
