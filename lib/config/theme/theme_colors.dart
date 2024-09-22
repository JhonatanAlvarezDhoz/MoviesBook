import 'dart:ui';

import 'package:flutter/material.dart';

/// A utility class for defining theme colors used throughout the application.
class ThemeColors extends Color {
  /// Private constructor to prevent instantiation of this class.
  ThemeColors._(super.value);

  //Ligth Theme
  /// Defines the primary color used in the application, typically used for primary elements.
  static const Color primaryLight = Color(0xFF448AFF);
  static const Color hintColor = Color(0xFF00adfe);
  static const Color textPrimaryLightColor = Color(0xFF000000);
  static const Color textSecundaryLightColor = Color(0xDD000000);

  //Darck Theme
  /// Defines the primary color used in the application, typically used for primary elements.
  static const Color primaryDark = Color(0xFF252525);

  /// Defines a lighter shade of the primary color, often used for highlights or accents.

  /// Defines a secondary color used in the application, typically for secondary elements.

  /// Defines the white color used in the application, primarily for backgrounds or
  /// text on dark backgrounds.
  static const Color white = Color(0xffFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color textSecundaryDarckColor = Color(0xB3FFFFFF);

  static const Color greenColor = Color(0xFF4CAF50);

  /// Defines a light gray color used in the application, primarily for backgrounds.
  static const Color whiteGray = Color(0xffEAEAEA);

  /// Defines a blue accent color used in the application, typically for highlighting
  /// or indicating actions.
}
