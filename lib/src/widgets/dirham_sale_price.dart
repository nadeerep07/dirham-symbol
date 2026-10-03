import 'package:flutter/material.dart';
import '../theme/dirham_theme.dart';
import '../dirham_icon.dart';

/// An E-Commerce widget displaying an original price (with strikethrough), a discounted sale price,
/// and an optional badge showing percentage off or total savings.
///
/// Example:
/// ```dart
/// DirhamSalePrice(
///   originalAmount: 199.99,
///   saleAmount: 149.99,
///   badgeType: DirhamDiscountBadgeType.percentage,
/// )
/// ```
class DirhamSalePrice extends StatelessWidget {
  /// The original regular price before discount
  final double originalAmount;

  /// The discounted sale price
  final double saleAmount;

  /// The type of Dirham symbol to display
  final DirhamSymbolType? symbolType;

  /// Text style for the discounted sale price
  final TextStyle? saleStyle;

  /// Text style for the strikethrough original price
  final TextStyle? originalStyle;

  /// Whether to show decimal values
  final bool? showDecimals;

  /// Whether to format numbers with commas
  final bool? formatNumber;

  /// Spacing between original and sale price
  final double spacing;

  /// Layout axis: [Axis.horizontal] for inline or [Axis.vertical] for stacked
  final Axis axis;

  /// Whether to show the discount badge
  final bool showBadge;

  /// Type of badge: [DirhamDiscountBadgeType.percentage], [DirhamDiscountBadgeType.saveAmount], or custom
  final DirhamDiscountBadgeType badgeType;

  /// Custom text for the badge when [badgeType] is [DirhamDiscountBadgeType.custom]
  final String? customBadgeText;

  /// Badge background color
  final Color? badgeColor;

  /// Badge text color
  final Color? badgeTextColor;

  /// Badge border radius
  final BorderRadius? badgeBorderRadius;

  /// Formatting locale
  final String? locale;

  const DirhamSalePrice({
    super.key,
    required this.originalAmount,
    required this.saleAmount,
    this.symbolType,
    this.saleStyle,
    this.originalStyle,
    this.showDecimals,
    this.formatNumber,
    this.spacing = 8.0,
    this.axis = Axis.horizontal,
    this.showBadge = true,
    this.badgeType = DirhamDiscountBadgeType.percentage,
    this.customBadgeText,
    this.badgeColor,
    this.badgeTextColor,
    this.badgeBorderRadius,
    this.locale,
  });

  /// Calculates percentage discount
  int get discountPercentage {
    if (originalAmount <= 0) return 0;
    final diff = originalAmount - saleAmount;
    return ((diff / originalAmount) * 100).round();
  }

  /// Calculates amount saved
  double get savedAmount => (originalAmount - saleAmount).clamp(0.0, double.infinity);

  Widget _buildBadge(BuildContext context) {
    String text;
    switch (badgeType) {
      case DirhamDiscountBadgeType.percentage:
        text = '-$discountPercentage%';
        break;
      case DirhamDiscountBadgeType.saveAmount:
        text = 'Save $savedAmount AED';
        break;
      case DirhamDiscountBadgeType.custom:
        text = customBadgeText ?? '-$discountPercentage%';
        break;
    }

    final bgColor = badgeColor ?? Colors.red.shade600;
    final fgColor = badgeTextColor ?? Colors.white;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: badgeBorderRadius ?? BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fgColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = DirhamTheme.of(context);
    final effectiveSymbolType = symbolType ?? themeData.symbolType;
    final effectiveShowDecimals = showDecimals ?? themeData.showDecimals;
    final effectiveFormatNumber = formatNumber ?? themeData.formatNumber;
    final effectiveLocale = locale ?? themeData.locale;

    final defaultSaleStyle = saleStyle ??
        TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        );

    final defaultOriginalStyle = originalStyle ??
        TextStyle(
          fontSize: 14,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
          decoration: TextDecoration.lineThrough,
        );

    final salePriceWidget = DirhamPrice(
      amount: saleAmount,
      style: defaultSaleStyle,
      symbolType: effectiveSymbolType,
      showDecimals: effectiveShowDecimals,
      formatNumber: effectiveFormatNumber,
      locale: effectiveLocale,
    );

    final originalPriceWidget = DirhamPrice(
      amount: originalAmount,
      style: defaultOriginalStyle,
      symbolType: effectiveSymbolType,
      showDecimals: effectiveShowDecimals,
      formatNumber: effectiveFormatNumber,
      locale: effectiveLocale,
    );

    if (axis == Axis.horizontal) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          salePriceWidget,
          SizedBox(width: spacing),
          originalPriceWidget,
          if (showBadge && discountPercentage > 0) ...[
            SizedBox(width: spacing),
            _buildBadge(context),
          ],
        ],
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              originalPriceWidget,
              if (showBadge && discountPercentage > 0) ...[
                const SizedBox(width: 6),
                _buildBadge(context),
              ],
            ],
          ),
          SizedBox(height: spacing / 2),
          salePriceWidget,
        ],
      );
    }
  }
}
