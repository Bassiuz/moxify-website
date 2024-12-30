import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const complimentaryblue = Color(0xFF1E88E5);

CustomColors lightCustomColors = const CustomColors(
  sourceComplimentaryblue: Color(0xFF1E88E5),
  complimentaryblue: Color(0xFF0060A8),
  onComplimentaryblue: Color(0xFFFFFFFF),
  complimentaryblueContainer: Color(0xFFD3E4FF),
  onComplimentaryblueContainer: Color(0xFF001C38),
);

CustomColors darkCustomColors = const CustomColors(
  sourceComplimentaryblue: Color(0xFF1E88E5),
  complimentaryblue: Color(0xFFA2C9FF),
  onComplimentaryblue: Color(0xFF00315B),
  complimentaryblueContainer: Color(0xFF004881),
  onComplimentaryblueContainer: Color(0xFFD3E4FF),
);

/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceComplimentaryblue,
    required this.complimentaryblue,
    required this.onComplimentaryblue,
    required this.complimentaryblueContainer,
    required this.onComplimentaryblueContainer,
  });

  final Color? sourceComplimentaryblue;
  final Color? complimentaryblue;
  final Color? onComplimentaryblue;
  final Color? complimentaryblueContainer;
  final Color? onComplimentaryblueContainer;

  @override
  CustomColors copyWith({
    Color? sourceComplimentaryblue,
    Color? complimentaryblue,
    Color? onComplimentaryblue,
    Color? complimentaryblueContainer,
    Color? onComplimentaryblueContainer,
  }) {
    return CustomColors(
      sourceComplimentaryblue: sourceComplimentaryblue ?? this.sourceComplimentaryblue,
      complimentaryblue: complimentaryblue ?? this.complimentaryblue,
      onComplimentaryblue: onComplimentaryblue ?? this.onComplimentaryblue,
      complimentaryblueContainer: complimentaryblueContainer ?? this.complimentaryblueContainer,
      onComplimentaryblueContainer: onComplimentaryblueContainer ?? this.onComplimentaryblueContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceComplimentaryblue: Color.lerp(sourceComplimentaryblue, other.sourceComplimentaryblue, t),
      complimentaryblue: Color.lerp(complimentaryblue, other.complimentaryblue, t),
      onComplimentaryblue: Color.lerp(onComplimentaryblue, other.onComplimentaryblue, t),
      complimentaryblueContainer: Color.lerp(complimentaryblueContainer, other.complimentaryblueContainer, t),
      onComplimentaryblueContainer: Color.lerp(onComplimentaryblueContainer, other.onComplimentaryblueContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///   * [CustomColors.sourceComplimentaryblue]
  ///   * [CustomColors.complimentaryblue]
  ///   * [CustomColors.onComplimentaryblue]
  ///   * [CustomColors.complimentaryblueContainer]
  ///   * [CustomColors.onComplimentaryblueContainer]
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
      sourceComplimentaryblue: sourceComplimentaryblue!.harmonizeWith(dynamic.primary),
      complimentaryblue: complimentaryblue!.harmonizeWith(dynamic.primary),
      onComplimentaryblue: onComplimentaryblue!.harmonizeWith(dynamic.primary),
      complimentaryblueContainer: complimentaryblueContainer!.harmonizeWith(dynamic.primary),
      onComplimentaryblueContainer: onComplimentaryblueContainer!.harmonizeWith(dynamic.primary),
    );
  }
}
