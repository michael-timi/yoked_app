import 'package:get/get.dart';

/// App-wide responsive size helpers using Get.height / Get.width.
/// Use for spacing, font sizes, and asset dimensions.
abstract final class AppSizes {
  /// Vertical spacing: 24 px ≈ 0.03 on ~800 logical height
  static double get spacing => Get.height * 0.03;
  static double get spacingSmall => Get.height * 0.015;
  static double get spacingMedium => Get.height * 0.02;
  static double get spacingLarge => Get.height * 0.04;

  /// Horizontal padding as fraction of width
  static double get horizontalPadding => Get.width * 0.06;
  static double get horizontalPaddingLarge => Get.width * 0.08;

  /// Font size from width (scales with screen)
  static double get fontSizeBody => Get.width * 0.045;
  static double get fontSizeTitle => Get.width * 0.055;

  /// Border radius (buttons, cards)
  static double get radius => Get.width * 0.06;

  /// Text field radius (pill-like)
  static double get textFieldRadius => Get.height * 0.02;

  /// Button padding
  static double get buttonPadding => Get.height * 0.015;

  /// Logo / image sizes (height-based)
  static double get logoSmall => Get.height * 0.15;
  static double get logoMedium => Get.height * 0.225;
  static double get logoWidthWide => Get.width * 0.7;
  static double get logoHeightWide => Get.height * 0.15;
  static double get logoWidthNarrow => Get.width * 0.3;
  static double get logoHeightNarrow => Get.height * 0.2;
}
