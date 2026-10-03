import 'package:flutter/material.dart';
import '../theme/dirham_theme.dart';
import '../dirham_icon.dart';

/// A stylish badge/chip widget for displaying delivery fees, discounts, minimum order thresholds,
/// or promotional amounts with a UAE Dirham symbol.
///
/// Example:
/// ```dart
/// DirhamBadge(
///   amount: 50,
///   prefix: 'Min. Order:',
///   backgroundColor: Colors.indigo.shade50,
///   textColor: Colors.indigo.shade800,
/// )
/// ```
class DirhamBadge extends StatelessWidget {
  /// Numeric amount
  final double amount;

  /// Optional text before the amount, e.g. "Cashback:"
  final String? prefix;

  /// Optional text after the amount, e.g. "off"
  final String? suffix;

  /// Symbol type
  final DirhamSymbolType? symbolType;

  /// Background color of the badge
  final Color? backgroundColor;

  /// Text and icon color
  final Color? textColor;

  /// Border color
  final Color? borderColor;

  /// Padding inside badge
  final EdgeInsetsGeometry padding;

  /// Border radius of badge
  final BorderRadius? borderRadius;

  /// Font size
  final double fontSize;

  /// Font weight
  final FontWeight fontWeight;

  /// Whether to show decimals
  final bool? showDecimals;

  /// Custom icon size
  final double? iconSize;

  /// On tap callback
  final VoidCallback? onTap;

  const DirhamBadge({
    super.key,
    required this.amount,
    this.prefix,
    this.suffix,
    this.symbolType,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    this.borderRadius,
    this.fontSize = 12.0,
    this.fontWeight = FontWeight.w600,
    this.showDecimals,
    this.iconSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeData = DirhamTheme.of(context);
    final effectiveSymbolType = symbolType ?? themeData.symbolType;
    final effectiveShowDecimals = showDecimals ?? themeData.showDecimals;

    final effectiveBgColor = backgroundColor ??
        theme.colorScheme.primaryContainer.withValues(alpha: 0.7);
    final effectiveTextColor = textColor ?? theme.colorScheme.onPrimaryContainer;

    final badgeChild = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: effectiveBgColor,
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        border: borderColor != null ? Border.all(color: borderColor!) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (prefix != null) ...[
            Text(
              prefix!,
              style: TextStyle(
                color: effectiveTextColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
            const SizedBox(width: 4),
          ],
          DirhamPrice(
            amount: amount,
            symbolType: effectiveSymbolType,
            showDecimals: effectiveShowDecimals,
            iconSize: iconSize ?? (fontSize * 1.1),
            iconColor: effectiveTextColor,
            style: TextStyle(
              color: effectiveTextColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
          if (suffix != null) ...[
            const SizedBox(width: 4),
            Text(
              suffix!,
              style: TextStyle(
                color: effectiveTextColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        child: badgeChild,
      );
    }

    return badgeChild;
  }
}
