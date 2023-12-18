import 'package:flutter/material.dart';

import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargeExtraLight => theme.textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.w200,
      );
  static get bodyLargeOnPrimary => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontWeight: FontWeight.w200,
        fontSize: 15,
      );
  // Display text style
  static get displayMediumPinkA100 => theme.textTheme.displayMedium!.copyWith(
        color: appTheme.pinkA100,
        fontWeight: FontWeight.w700,
      );
  static get displayMediumYellow200 => theme.textTheme.displayMedium!.copyWith(
        color: appTheme.yellow200,
      );
  // Headline text style
  static get headlineSmallOnPrimaryContainer =>
      theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w500,
      );
  static get headlineSmallPrimary => theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w300,
      );
  // Title text style
  static get titleLargeOnPrimary => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
}

extension on TextStyle {
  TextStyle get publicSans {
    return copyWith(
      fontFamily: 'Public Sans',
    );
  }
}
