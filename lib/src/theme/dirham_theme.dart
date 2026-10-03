import 'package:flutter/material.dart';
import '../models/enums.dart';

/// Configuration data for [DirhamTheme]
@immutable
class DirhamThemeData {
  /// Default symbol type to use when not specified on individual widgets
  final DirhamSymbolType symbolType;

  /// Whether to show decimals by default
  final bool showDecimals;

  /// Whether to format numbers with thousand separators by default
  final bool formatNumber;

  /// Default locale for formatting (e.g., 'en_US', 'ar_AE')
  final String locale;

  /// Default icon/symbol color
  final Color? iconColor;

  /// Default text style for price amounts
  final TextStyle? style;

  /// Force symbol before/after amount, or null for smart auto-positioning
  final bool? symbolBefore;

  /// Whether to display Eastern Arabic numerals (٠١٢٣٤٥٦٧٨٩) for Arabic locale
  final bool useEasternArabicNumerals;

  /// Spacing between symbol and amount in price widgets
  final double spacing;

  const DirhamThemeData({
    this.symbolType = DirhamSymbolType.icon,
    this.showDecimals = false,
    this.formatNumber = true,
    this.locale = 'en_US',
    this.iconColor,
    this.style,
    this.symbolBefore,
    this.useEasternArabicNumerals = false,
    this.spacing = 4.0,
  });

  /// Create a copy with modified properties
  DirhamThemeData copyWith({
    DirhamSymbolType? symbolType,
    bool? showDecimals,
    bool? formatNumber,
    String? locale,
    Color? iconColor,
    TextStyle? style,
    bool? symbolBefore,
    bool? useEasternArabicNumerals,
    double? spacing,
  }) {
    return DirhamThemeData(
      symbolType: symbolType ?? this.symbolType,
      showDecimals: showDecimals ?? this.showDecimals,
      formatNumber: formatNumber ?? this.formatNumber,
      locale: locale ?? this.locale,
      iconColor: iconColor ?? this.iconColor,
      style: style ?? this.style,
      symbolBefore: symbolBefore ?? this.symbolBefore,
      useEasternArabicNumerals:
          useEasternArabicNumerals ?? this.useEasternArabicNumerals,
      spacing: spacing ?? this.spacing,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DirhamThemeData &&
        other.symbolType == symbolType &&
        other.showDecimals == showDecimals &&
        other.formatNumber == formatNumber &&
        other.locale == locale &&
        other.iconColor == iconColor &&
        other.style == style &&
        other.symbolBefore == symbolBefore &&
        other.useEasternArabicNumerals == useEasternArabicNumerals &&
        other.spacing == spacing;
  }

  @override
  int get hashCode => Object.hash(
        symbolType,
        showDecimals,
        formatNumber,
        locale,
        iconColor,
        style,
        symbolBefore,
        useEasternArabicNumerals,
        spacing,
      );
}

/// An [InheritedTheme] widget that provides default [DirhamThemeData] to its descendants.
class DirhamTheme extends InheritedTheme {
  /// The configuration data for descendant Dirham widgets
  final DirhamThemeData data;

  const DirhamTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Retrieves the closest [DirhamThemeData] in the widget tree, or a default instance if none exists.
  static DirhamThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<DirhamTheme>();
    return theme?.data ?? const DirhamThemeData();
  }

  /// Retrieves the closest [DirhamThemeData] in the widget tree, or null if none exists.
  static DirhamThemeData? maybeOf(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<DirhamTheme>();
    return theme?.data;
  }

  @override
  bool updateShouldNotify(DirhamTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return DirhamTheme(data: data, child: child);
  }
}
