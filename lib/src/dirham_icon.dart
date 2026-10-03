import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'formatter/dirham_formatter.dart';
import 'models/enums.dart';
import 'theme/dirham_theme.dart';
import 'widgets/animated_dirham_price.dart';
import 'widgets/dirham_badge.dart';
import 'widgets/dirham_sale_price.dart';

// Re-export enums so existing imports don't break
export 'models/enums.dart';

// ============================================================================
// CORE WIDGETS
// ============================================================================

/// Simple Dirham Icon Widget
///
/// Displays an SVG icon representing the official UAE Dirham currency symbol.
///
/// Example:
/// ```dart
/// DirhamIcon(size: 24, color: Colors.green)
/// ```
class DirhamIcon extends StatelessWidget {
  final double? size;
  final Color? color;

  const DirhamIcon({
    super.key,
    this.size = 24.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = color ?? Theme.of(context).colorScheme.onSurface;

    return SvgPicture.asset(
      'assets/uae-dirham.svg',
      package: 'dirham_symbol',
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(defaultColor, BlendMode.srcIn),
    );
  }
}

/// Dirham Symbol Widget
///
/// Shows different types of dirham symbols (icon, arabic, AED, Dh).
///
/// Example:
/// ```dart
/// DirhamSymbol(
///   type: DirhamSymbolType.arabic,
///   size: 20,
///   color: Colors.blue,
/// )
/// ```
class DirhamSymbol extends StatelessWidget {
  final DirhamSymbolType type;
  final double? size;
  final Color? color;
  final TextStyle? textStyle;

  const DirhamSymbol({
    super.key,
    this.type = DirhamSymbolType.icon,
    this.size,
    this.color,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor =
        color ?? textStyle?.color ?? Theme.of(context).colorScheme.onSurface;

    switch (type) {
      case DirhamSymbolType.icon:
        return DirhamIcon(size: size ?? 24.0, color: defaultColor);

      case DirhamSymbolType.arabic:
        return Text(
          'د.إ',
          style: textStyle?.copyWith(color: defaultColor) ??
              TextStyle(fontSize: size ?? 16, color: defaultColor),
        );

      case DirhamSymbolType.aed:
        return Text(
          'AED',
          style: textStyle?.copyWith(color: defaultColor) ??
              TextStyle(fontSize: size ?? 16, color: defaultColor),
        );

      case DirhamSymbolType.dh:
        return Text(
          'Dh',
          style: textStyle?.copyWith(color: defaultColor) ??
              TextStyle(fontSize: size ?? 16, color: defaultColor),
        );
    }
  }
}

/// Dirham Price Widget
///
/// Displays an amount with a dirham symbol. Supports various formatting options.
///
/// Example:
/// ```dart
/// DirhamPrice(
///   amount: 99.99,
///   showDecimals: true,
///   symbolType: DirhamSymbolType.arabic,
///   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
/// )
/// ```
class DirhamPrice extends StatelessWidget {
  final double amount;
  final TextStyle? style;
  final bool? showDecimals;
  final bool? formatNumber;
  final bool? symbolBefore;
  final double? iconSize;
  final Color? iconColor;
  final MainAxisAlignment alignment;
  final DirhamSymbolType? symbolType;
  final String? locale;

  const DirhamPrice({
    super.key,
    required this.amount,
    this.style,
    this.showDecimals,
    this.formatNumber,
    this.symbolBefore,
    this.iconSize,
    this.iconColor,
    this.alignment = MainAxisAlignment.start,
    this.symbolType,
    this.locale,
  });

  bool _shouldSymbolBeBefore(DirhamSymbolType type) {
    if (symbolBefore != null) return symbolBefore!;
    return type != DirhamSymbolType.arabic;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = DirhamTheme.maybeOf(context);

    final effectiveSymbolType =
        symbolType ?? themeData?.symbolType ?? DirhamSymbolType.icon;
    final effectiveShowDecimals =
        showDecimals ?? themeData?.showDecimals ?? false;
    final effectiveFormatNumber =
        formatNumber ?? themeData?.formatNumber ?? true;
    final effectiveLocale = locale ?? themeData?.locale ?? 'en_US';

    final effectiveStyle = style ??
        themeData?.style ??
        TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onSurface,
        );

    final effectiveColor =
        iconColor ?? effectiveStyle.color ?? themeData?.iconColor;

    // Clamp icon size to reasonable bounds
    final calculatedIconSize =
        (iconSize ?? (effectiveStyle.fontSize ?? 16) * 0.9).clamp(8.0, 64.0);

    // Apply formatting only if enabled, with consistent locale
    String formattedAmount;
    if (effectiveFormatNumber) {
      final formatter = NumberFormat.currency(
        decimalDigits: effectiveShowDecimals ? 2 : 0,
        symbol: '',
        locale: effectiveLocale,
      );
      formattedAmount = formatter.format(amount).trim();
    } else {
      formattedAmount = effectiveShowDecimals
          ? amount.toStringAsFixed(2)
          : amount.toStringAsFixed(0);
    }

    if (themeData?.useEasternArabicNumerals == true) {
      formattedAmount = DirhamFormatter.toEasternArabic(formattedAmount);
    }

    final spacing = themeData?.spacing ?? 4.0;
    final isBefore = _shouldSymbolBeBefore(effectiveSymbolType);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: alignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (isBefore) ...[
          DirhamSymbol(
            type: effectiveSymbolType,
            size: calculatedIconSize,
            color: effectiveColor,
            textStyle: effectiveStyle,
          ),
          SizedBox(width: spacing),
        ],
        Text(formattedAmount, style: effectiveStyle),
        if (!isBefore) ...[
          SizedBox(width: spacing),
          DirhamSymbol(
            type: effectiveSymbolType,
            size: calculatedIconSize,
            color: effectiveColor,
            textStyle: effectiveStyle,
          ),
        ],
      ],
    );
  }
}

/// Dirham Price Range Widget
///
/// Shows a price range like "د.إ 50 - د.إ 100"
///
/// Example:
/// ```dart
/// DirhamPriceRange(
///   minAmount: 50,
///   maxAmount: 100,
///   symbolType: DirhamSymbolType.arabic,
/// )
/// ```
class DirhamPriceRange extends StatelessWidget {
  final double minAmount;
  final double maxAmount;
  final TextStyle? style;
  final bool? showDecimals;
  final double? iconSize;
  final Color? iconColor;
  final DirhamSymbolType? symbolType;
  final bool? symbolBefore;
  final String? locale;

  const DirhamPriceRange({
    super.key,
    required this.minAmount,
    required this.maxAmount,
    this.style,
    this.showDecimals,
    this.iconSize,
    this.iconColor,
    this.symbolType,
    this.symbolBefore,
    this.locale,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = style ??
        TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onSurface,
        );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DirhamPrice(
          amount: minAmount,
          style: defaultStyle,
          showDecimals: showDecimals,
          iconSize: iconSize,
          iconColor: iconColor,
          symbolType: symbolType,
          symbolBefore: symbolBefore,
          locale: locale,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text('-', style: defaultStyle),
        ),
        DirhamPrice(
          amount: maxAmount,
          style: defaultStyle,
          showDecimals: showDecimals,
          iconSize: iconSize,
          iconColor: iconColor,
          symbolType: symbolType,
          symbolBefore: symbolBefore,
          locale: locale,
        ),
      ],
    );
  }
}

/// Inline Dirham Text Widget
///
/// Displays text with an embedded dirham price using Text.rich for proper inline formatting.
///
/// Example:
/// ```dart
/// InlineDirhamText(
///   prefix: 'Starting from',
///   amount: 99,
///   suffix: 'only!',
///   symbolType: DirhamSymbolType.arabic,
/// )
/// ```
class InlineDirhamText extends StatelessWidget {
  final String? prefix;
  final String? suffix;
  final double amount;
  final TextStyle? style;
  final bool? showDecimals;
  final bool? formatNumber;
  final DirhamSymbolType? symbolType;
  final bool? symbolBefore;
  final double? iconSize;
  final Color? iconColor;
  final String? locale;

  const InlineDirhamText({
    super.key,
    this.prefix,
    this.suffix,
    required this.amount,
    this.style,
    this.showDecimals,
    this.formatNumber,
    this.symbolType,
    this.symbolBefore,
    this.iconSize,
    this.iconColor,
    this.locale,
  });

  bool _shouldSymbolBeBefore(DirhamSymbolType type) {
    if (symbolBefore != null) return symbolBefore!;
    return type != DirhamSymbolType.arabic;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = DirhamTheme.maybeOf(context);

    final effectiveSymbolType =
        symbolType ?? themeData?.symbolType ?? DirhamSymbolType.icon;
    final effectiveShowDecimals =
        showDecimals ?? themeData?.showDecimals ?? false;
    final effectiveFormatNumber =
        formatNumber ?? themeData?.formatNumber ?? true;
    final effectiveLocale = locale ?? themeData?.locale ?? 'en_US';

    final textStyle = style ??
        themeData?.style ??
        TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onSurface,
        );

    // Format or not based on flag, with consistent locale
    String formattedAmount;
    if (effectiveFormatNumber) {
      final formatter = NumberFormat.currency(
        decimalDigits: effectiveShowDecimals ? 2 : 0,
        symbol: '',
        locale: effectiveLocale,
      );
      formattedAmount = formatter.format(amount).trim();
    } else {
      formattedAmount = effectiveShowDecimals
          ? amount.toStringAsFixed(2)
          : amount.toStringAsFixed(0);
    }

    if (themeData?.useEasternArabicNumerals == true) {
      formattedAmount = DirhamFormatter.toEasternArabic(formattedAmount);
    }

    // Clamp icon size to reasonable bounds
    final calculatedIconSize =
        (iconSize ?? (textStyle.fontSize ?? 16) * 0.9).clamp(8.0, 64.0);

    final symbolWidget = DirhamSymbol(
      type: effectiveSymbolType,
      size: calculatedIconSize,
      color: iconColor ?? textStyle.color,
      textStyle: textStyle,
    );

    final isBefore = _shouldSymbolBeBefore(effectiveSymbolType);

    // Build inline rich text
    return Text.rich(
      TextSpan(
        style: textStyle,
        children: [
          if (prefix != null) TextSpan(text: '$prefix '),
          if (isBefore)
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: symbolWidget,
              ),
            ),
          TextSpan(text: formattedAmount),
          if (!isBefore)
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: symbolWidget,
              ),
            ),
          if (suffix != null) TextSpan(text: ' $suffix'),
        ],
      ),
    );
  }
}

// ============================================================================
// EXTENSIONS
// ============================================================================

/// Extension on [num] (int, double) for easy Dirham formatting
extension DirhamNumExtension on num {
  /// Format number as Dirham price widget
  Widget toDirham({
    TextStyle? style,
    bool? showDecimals,
    bool? formatNumber,
    bool? symbolBefore,
    double? iconSize,
    Color? iconColor,
    MainAxisAlignment alignment = MainAxisAlignment.start,
    DirhamSymbolType? symbolType,
    String? locale,
  }) {
    return DirhamPrice(
      amount: toDouble(),
      style: style,
      showDecimals: showDecimals,
      formatNumber: formatNumber,
      symbolBefore: symbolBefore,
      iconSize: iconSize,
      iconColor: iconColor,
      alignment: alignment,
      symbolType: symbolType,
      locale: locale,
    );
  }

  /// Format number with inline text (prefix/suffix)
  Widget toDirhamText({
    String? prefix,
    String? suffix,
    TextStyle? style,
    bool? showDecimals,
    bool? formatNumber,
    DirhamSymbolType? symbolType,
    bool? symbolBefore,
    double? iconSize,
    Color? iconColor,
    String? locale,
  }) {
    return InlineDirhamText(
      prefix: prefix,
      suffix: suffix,
      amount: toDouble(),
      style: style,
      showDecimals: showDecimals,
      formatNumber: formatNumber,
      symbolType: symbolType,
      symbolBefore: symbolBefore,
      iconSize: iconSize,
      iconColor: iconColor,
      locale: locale,
    );
  }

  /// Create a price range from this number to another
  Widget toDirhamRange(
    num maxAmount, {
    TextStyle? style,
    bool? showDecimals,
    double? iconSize,
    Color? iconColor,
    DirhamSymbolType? symbolType,
    bool? symbolBefore,
    String? locale,
  }) {
    return DirhamPriceRange(
      minAmount: toDouble(),
      maxAmount: maxAmount.toDouble(),
      style: style,
      showDecimals: showDecimals,
      iconSize: iconSize,
      iconColor: iconColor,
      symbolType: symbolType,
      symbolBefore: symbolBefore,
      locale: locale,
    );
  }

  /// Format as a pure Dart String (e.g. `"AED 1,500.00"` or `"1,500 د.إ"`).
  ///
  /// Perfect for API payloads, push notifications, native integrations, or PDF receipts.
  String toDirhamString({
    DirhamSymbolType symbolType = DirhamSymbolType.aed,
    bool showDecimals = false,
    bool formatNumber = true,
    bool? symbolBefore,
    String locale = 'en_US',
    bool useEasternArabicNumerals = false,
    int? decimalDigits,
    String? customSymbol,
  }) {
    return DirhamFormatter.format(
      toDouble(),
      symbolType: symbolType,
      showDecimals: showDecimals,
      formatNumber: formatNumber,
      symbolBefore: symbolBefore,
      locale: locale,
      useEasternArabicNumerals: useEasternArabicNumerals,
      decimalDigits: decimalDigits,
      customSymbol: customSymbol,
    );
  }

  /// Compactly format large amounts (e.g. `1.5K AED`, `2.4M د.إ`).
  String toDirhamCompact({
    DirhamSymbolType symbolType = DirhamSymbolType.aed,
    bool? symbolBefore,
    String locale = 'en_US',
    int decimalDigits = 1,
    bool useEasternArabicNumerals = false,
  }) {
    return DirhamFormatter.formatCompact(
      toDouble(),
      symbolType: symbolType,
      symbolBefore: symbolBefore,
      locale: locale,
      decimalDigits: decimalDigits,
      useEasternArabicNumerals: useEasternArabicNumerals,
    );
  }

  /// Create an e-commerce sale / discount price widget
  Widget toDirhamSale(
    num saleAmount, {
    TextStyle? saleStyle,
    TextStyle? originalStyle,
    DirhamSymbolType? symbolType,
    bool? showDecimals,
    bool? formatNumber,
    bool showBadge = true,
    DirhamDiscountBadgeType badgeType = DirhamDiscountBadgeType.percentage,
    String? customBadgeText,
    Color? badgeColor,
    Color? badgeTextColor,
    Axis axis = Axis.horizontal,
  }) {
    return DirhamSalePrice(
      originalAmount: toDouble(),
      saleAmount: saleAmount.toDouble(),
      saleStyle: saleStyle,
      originalStyle: originalStyle,
      symbolType: symbolType,
      showDecimals: showDecimals,
      formatNumber: formatNumber,
      showBadge: showBadge,
      badgeType: badgeType,
      customBadgeText: customBadgeText,
      badgeColor: badgeColor,
      badgeTextColor: badgeTextColor,
      axis: axis,
    );
  }

  /// Create an animated ticker price widget
  Widget toDirhamAnimated({
    TextStyle? style,
    bool? showDecimals,
    bool? formatNumber,
    bool? symbolBefore,
    double? iconSize,
    Color? iconColor,
    MainAxisAlignment alignment = MainAxisAlignment.start,
    DirhamSymbolType? symbolType,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOutCubic,
  }) {
    return AnimatedDirhamPrice(
      amount: toDouble(),
      style: style,
      showDecimals: showDecimals,
      formatNumber: formatNumber,
      symbolBefore: symbolBefore,
      iconSize: iconSize,
      iconColor: iconColor,
      alignment: alignment,
      symbolType: symbolType,
      duration: duration,
      curve: curve,
    );
  }

  /// Create a compact badge / chip widget
  Widget toDirhamBadge({
    String? prefix,
    String? suffix,
    DirhamSymbolType? symbolType,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    BorderRadius? borderRadius,
    double fontSize = 12.0,
    FontWeight fontWeight = FontWeight.w600,
    bool? showDecimals,
    VoidCallback? onTap,
  }) {
    return DirhamBadge(
      amount: toDouble(),
      prefix: prefix,
      suffix: suffix,
      symbolType: symbolType,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderColor: borderColor,
      padding: padding,
      borderRadius: borderRadius,
      fontSize: fontSize,
      fontWeight: fontWeight,
      showDecimals: showDecimals,
      onTap: onTap,
    );
  }

  /// Converts this value in Dirhams to integer Fils (1 AED = 100 Fils).
  int toFils() => DirhamFormatter.toFils(this);
}

/// Extension on [String] for parsing and formatting as Dirham
extension DirhamStringExtension on String {
  /// Parse string to double and format as Dirham price widget
  Widget toDirham({
    TextStyle? style,
    bool? showDecimals,
    bool? formatNumber,
    bool? symbolBefore,
    double? iconSize,
    Color? iconColor,
    MainAxisAlignment alignment = MainAxisAlignment.start,
    DirhamSymbolType? symbolType,
    String? locale,
  }) {
    final amount = double.tryParse(this) ?? 0.0;
    return DirhamPrice(
      amount: amount,
      style: style,
      showDecimals: showDecimals,
      formatNumber: formatNumber,
      symbolBefore: symbolBefore,
      iconSize: iconSize,
      iconColor: iconColor,
      alignment: alignment,
      symbolType: symbolType,
      locale: locale,
    );
  }

  /// Parse string to double and format with inline text
  Widget toDirhamText({
    String? prefix,
    String? suffix,
    TextStyle? style,
    bool? showDecimals,
    bool? formatNumber,
    DirhamSymbolType? symbolType,
    bool? symbolBefore,
    double? iconSize,
    Color? iconColor,
    String? locale,
  }) {
    final amount = double.tryParse(this) ?? 0.0;
    return InlineDirhamText(
      prefix: prefix,
      suffix: suffix,
      amount: amount,
      style: style,
      showDecimals: showDecimals,
      formatNumber: formatNumber,
      symbolType: symbolType,
      symbolBefore: symbolBefore,
      iconSize: iconSize,
      iconColor: iconColor,
      locale: locale,
    );
  }

  /// Parse string and create a price range
  Widget toDirhamRange(
    String maxAmount, {
    TextStyle? style,
    bool? showDecimals,
    double? iconSize,
    Color? iconColor,
    DirhamSymbolType? symbolType,
    bool? symbolBefore,
    String? locale,
  }) {
    final minValue = double.tryParse(this) ?? 0.0;
    final maxValue = double.tryParse(maxAmount) ?? 0.0;
    return DirhamPriceRange(
      minAmount: minValue,
      maxAmount: maxValue,
      style: style,
      showDecimals: showDecimals,
      iconSize: iconSize,
      iconColor: iconColor,
      symbolType: symbolType,
      symbolBefore: symbolBefore,
      locale: locale,
    );
  }

  /// Parse string and format as pure Dart String
  String toDirhamString({
    DirhamSymbolType symbolType = DirhamSymbolType.aed,
    bool showDecimals = false,
    bool formatNumber = true,
    bool? symbolBefore,
    String locale = 'en_US',
    bool useEasternArabicNumerals = false,
    int? decimalDigits,
    String? customSymbol,
  }) {
    final amount = DirhamFormatter.parseAmount(this);
    return DirhamFormatter.format(
      amount,
      symbolType: symbolType,
      showDecimals: showDecimals,
      formatNumber: formatNumber,
      symbolBefore: symbolBefore,
      locale: locale,
      useEasternArabicNumerals: useEasternArabicNumerals,
      decimalDigits: decimalDigits,
      customSymbol: customSymbol,
    );
  }

  /// Parse string and format in compact notation (e.g. `"1.5K AED"`)
  String toDirhamCompact({
    DirhamSymbolType symbolType = DirhamSymbolType.aed,
    bool? symbolBefore,
    String locale = 'en_US',
    int decimalDigits = 1,
    bool useEasternArabicNumerals = false,
  }) {
    final amount = DirhamFormatter.parseAmount(this);
    return DirhamFormatter.formatCompact(
      amount,
      symbolType: symbolType,
      symbolBefore: symbolBefore,
      locale: locale,
      decimalDigits: decimalDigits,
      useEasternArabicNumerals: useEasternArabicNumerals,
    );
  }

  /// Extracts numeric double value from dirty string (e.g., `"AED 1,250.50"` -> `1250.50`)
  double cleanDirhamAmount({double defaultValue = 0.0}) {
    return DirhamFormatter.parseAmount(this, defaultValue: defaultValue);
  }
}

/// Extension on [int] for handling Fils (100 Fils = 1 AED)
extension DirhamFilsExtension on int {
  /// Converts Fils to UAE Dirhams double (e.g., `1500` -> `15.00`)
  double filsToDirham() => DirhamFormatter.fromFils(this);

  /// Formats Fils directly as a Dirham string (e.g., `2500` -> `"AED 25.00"`)
  String filsToDirhamString({
    DirhamSymbolType symbolType = DirhamSymbolType.aed,
    bool formatNumber = true,
    bool? symbolBefore,
    String locale = 'en_US',
    bool useEasternArabicNumerals = false,
  }) {
    return DirhamFormatter.formatFils(
      this,
      symbolType: symbolType,
      formatNumber: formatNumber,
      symbolBefore: symbolBefore,
      locale: locale,
      useEasternArabicNumerals: useEasternArabicNumerals,
    );
  }

  /// Formats Fils as a [DirhamPrice] widget
  Widget filsToDirhamWidget({
    TextStyle? style,
    bool showDecimals = true,
    bool formatNumber = true,
    bool? symbolBefore,
    double? iconSize,
    Color? iconColor,
    MainAxisAlignment alignment = MainAxisAlignment.start,
    DirhamSymbolType symbolType = DirhamSymbolType.icon,
    String locale = 'en_US',
  }) {
    return DirhamPrice(
      amount: filsToDirham(),
      style: style,
      showDecimals: showDecimals,
      formatNumber: formatNumber,
      symbolBefore: symbolBefore,
      iconSize: iconSize,
      iconColor: iconColor,
      alignment: alignment,
      symbolType: symbolType,
      locale: locale,
    );
  }
}
