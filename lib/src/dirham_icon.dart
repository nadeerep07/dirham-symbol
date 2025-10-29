import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

// ============================================================================
// ENUMS
// ============================================================================

/// Enum for different Dirham symbol types
enum DirhamSymbolType {
  /// SVG icon with D and two horizontal lines
  icon,

  /// Arabic text symbol: د.إ
  arabic,

  /// Latin text symbol: AED
  aed,

  /// Dh symbol
  dh,
}

// ============================================================================
// CORE WIDGETS
// ============================================================================

/// Simple Dirham Icon Widget
///
/// Displays an SVG icon representing the Dirham currency symbol.
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
  final bool showDecimals;
  final bool formatNumber;
  final bool? symbolBefore;
  final double? iconSize;
  final Color? iconColor;
  final MainAxisAlignment alignment;
  final DirhamSymbolType symbolType;
  final String locale;

  const DirhamPrice({
    super.key,
    required this.amount,
    this.style,
    this.showDecimals = false,
    this.formatNumber = true,
    this.symbolBefore,
    this.iconSize,
    this.iconColor,
    this.alignment = MainAxisAlignment.start,
    this.symbolType = DirhamSymbolType.icon,
    this.locale = 'en_US',
  });

  bool get _shouldSymbolBeBefore {
    if (symbolBefore != null) return symbolBefore!;
    return symbolType != DirhamSymbolType.arabic;
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = style ??
        TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onSurface,
        );

    // Clamp icon size to reasonable bounds
    final calculatedIconSize =
        (iconSize ?? (textStyle.fontSize ?? 16) * 0.9).clamp(8.0, 64.0);

    // Apply formatting only if enabled, with consistent locale
    String formattedAmount;
    if (formatNumber) {
      final formatter = NumberFormat.currency(
        decimalDigits: showDecimals ? 2 : 0,
        symbol: '',
        locale: locale,
      );
      formattedAmount = formatter.format(amount);
    } else {
      formattedAmount =
          showDecimals ? amount.toStringAsFixed(2) : amount.toStringAsFixed(0);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: alignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (_shouldSymbolBeBefore) ...[
          DirhamSymbol(
            type: symbolType,
            size: calculatedIconSize,
            color: iconColor ?? textStyle.color,
            textStyle: textStyle,
          ),
          const SizedBox(width: 4),
        ],
        Text(formattedAmount, style: textStyle),
        if (!_shouldSymbolBeBefore) ...[
          const SizedBox(width: 4),
          DirhamSymbol(
            type: symbolType,
            size: calculatedIconSize,
            color: iconColor ?? textStyle.color,
            textStyle: textStyle,
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
  final bool showDecimals;
  final double? iconSize;
  final Color? iconColor;
  final DirhamSymbolType symbolType;
  final bool? symbolBefore;
  final String locale;

  const DirhamPriceRange({
    super.key,
    required this.minAmount,
    required this.maxAmount,
    this.style,
    this.showDecimals = false,
    this.iconSize,
    this.iconColor,
    this.symbolType = DirhamSymbolType.icon,
    this.symbolBefore,
    this.locale = 'en_US',
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
  final bool showDecimals;
  final bool formatNumber;
  final DirhamSymbolType symbolType;
  final bool? symbolBefore;
  final double? iconSize;
  final Color? iconColor;
  final String locale;

  const InlineDirhamText({
    super.key,
    this.prefix,
    this.suffix,
    required this.amount,
    this.style,
    this.showDecimals = false,
    this.formatNumber = true,
    this.symbolType = DirhamSymbolType.icon,
    this.symbolBefore,
    this.iconSize,
    this.iconColor,
    this.locale = 'en_US',
  });

  bool get _shouldSymbolBeBefore {
    if (symbolBefore != null) return symbolBefore!;
    return symbolType != DirhamSymbolType.arabic;
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = style ??
        TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onSurface,
        );

    // Format or not based on flag, with consistent locale
    String formattedAmount;
    if (formatNumber) {
      final formatter = NumberFormat.currency(
        decimalDigits: showDecimals ? 2 : 0,
        symbol: '',
        locale: locale,
      );
      formattedAmount = formatter.format(amount);
    } else {
      formattedAmount =
          showDecimals ? amount.toStringAsFixed(2) : amount.toStringAsFixed(0);
    }

    // Clamp icon size to reasonable bounds
    final calculatedIconSize =
        (iconSize ?? (textStyle.fontSize ?? 16) * 0.9).clamp(8.0, 64.0);

    final symbolWidget = DirhamSymbol(
      type: symbolType,
      size: calculatedIconSize,
      color: iconColor ?? textStyle.color,
      textStyle: textStyle,
    );

    // Build inline rich text
    return Text.rich(
      TextSpan(
        style: textStyle,
        children: [
          if (prefix != null) TextSpan(text: '$prefix '),
          if (_shouldSymbolBeBefore)
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: symbolWidget,
              ),
            ),
          TextSpan(text: formattedAmount),
          if (!_shouldSymbolBeBefore)
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
///
/// Example:
/// ```dart
/// 99.99.toDirham()
/// 100.toDirham(symbolType: DirhamSymbolType.arabic, showDecimals: true)
/// 50.toDirhamText(prefix: 'From', suffix: 'only!')
/// ```
extension DirhamNumExtension on num {
  /// Format number as Dirham price widget
  ///
  /// Example:
  /// ```dart
  /// 99.99.toDirham(
  ///   symbolType: DirhamSymbolType.arabic,
  ///   showDecimals: true,
  ///   style: TextStyle(fontSize: 24),
  /// )
  /// ```
  Widget toDirham({
    TextStyle? style,
    bool showDecimals = false,
    bool formatNumber = true,
    bool? symbolBefore,
    double? iconSize,
    Color? iconColor,
    MainAxisAlignment alignment = MainAxisAlignment.start,
    DirhamSymbolType symbolType = DirhamSymbolType.icon,
    String locale = 'en_US',
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
  ///
  /// Example:
  /// ```dart
  /// 99.toDirhamText(
  ///   prefix: 'Starting from',
  ///   suffix: 'only!',
  ///   symbolType: DirhamSymbolType.arabic,
  /// )
  /// ```
  Widget toDirhamText({
    String? prefix,
    String? suffix,
    TextStyle? style,
    bool showDecimals = false,
    bool formatNumber = true,
    DirhamSymbolType symbolType = DirhamSymbolType.icon,
    bool? symbolBefore,
    double? iconSize,
    Color? iconColor,
    String locale = 'en_US',
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
  ///
  /// Example:
  /// ```dart
  /// 50.toDirhamRange(100, symbolType: DirhamSymbolType.arabic)
  /// ```
  Widget toDirhamRange(
    num maxAmount, {
    TextStyle? style,
    bool showDecimals = false,
    double? iconSize,
    Color? iconColor,
    DirhamSymbolType symbolType = DirhamSymbolType.icon,
    bool? symbolBefore,
    String locale = 'en_US',
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
}

/// Extension on [String] for parsing and formatting as Dirham
///
/// Example:
/// ```dart
/// "99.99".toDirham()
/// "100".toDirham(symbolType: DirhamSymbolType.arabic)
/// "50".toDirhamText(prefix: 'Only', suffix: 'today!')
/// ```
extension DirhamStringExtension on String {
  /// Parse string to double and format as Dirham price
  ///
  /// Returns a widget displaying 0.0 if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// "99.99".toDirham(showDecimals: true)
  /// product.priceString.toDirham(symbolType: DirhamSymbolType.arabic)
  /// ```
  Widget toDirham({
    TextStyle? style,
    bool showDecimals = false,
    bool formatNumber = true,
    bool? symbolBefore,
    double? iconSize,
    Color? iconColor,
    MainAxisAlignment alignment = MainAxisAlignment.start,
    DirhamSymbolType symbolType = DirhamSymbolType.icon,
    String locale = 'en_US',
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
  ///
  /// Example:
  /// ```dart
  /// "99".toDirhamText(prefix: 'Price:', suffix: 'per item')
  /// ```
  Widget toDirhamText({
    String? prefix,
    String? suffix,
    TextStyle? style,
    bool showDecimals = false,
    bool formatNumber = true,
    DirhamSymbolType symbolType = DirhamSymbolType.icon,
    bool? symbolBefore,
    double? iconSize,
    Color? iconColor,
    String locale = 'en_US',
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
  ///
  /// Example:
  /// ```dart
  /// "50".toDirhamRange("100")
  /// ```
  Widget toDirhamRange(
    String maxAmount, {
    TextStyle? style,
    bool showDecimals = false,
    double? iconSize,
    Color? iconColor,
    DirhamSymbolType symbolType = DirhamSymbolType.icon,
    bool? symbolBefore,
    String locale = 'en_US',
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
}
