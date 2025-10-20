import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Simple Dirham Icon Widget
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
    return SvgPicture.asset(
      'assets/uae-dirham.svg',
      package: 'dirham_symbol',
      width: size,
      height: size,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}

/// Dirham Price Widget - Shows amount with dirham symbol
class DirhamPrice extends StatelessWidget {
  final double amount;
  final TextStyle? style;
  final bool showDecimals;
  final bool symbolBefore; // true = د.إ 100, false = 100 د.إ
  final double? iconSize;
  final Color? iconColor;
  final MainAxisAlignment alignment;

  const DirhamPrice({
    super.key,
    required this.amount,
    this.style,
    this.showDecimals = false,
    this.symbolBefore = true,
    this.iconSize,
    this.iconColor,
    this.alignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = style ?? const TextStyle(fontSize: 16);
    final calculatedIconSize = iconSize ?? (textStyle.fontSize ?? 16) * 0.9;
    final amountText = showDecimals 
        ? amount.toStringAsFixed(2) 
        : amount.toStringAsFixed(0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: alignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (symbolBefore) ...[
          DirhamIcon(
            size: calculatedIconSize,
            color: iconColor ?? textStyle.color,
          ),
          const SizedBox(width: 4),
        ],
        Text(amountText, style: textStyle),
        if (!symbolBefore) ...[
          const SizedBox(width: 4),
          DirhamIcon(
            size: calculatedIconSize,
            color: iconColor ?? textStyle.color,
          ),
        ],
      ],
    );
  }
}

/// Dirham Price Range Widget - Shows price range like "د.إ 50 - د.إ 100"
class DirhamPriceRange extends StatelessWidget {
  final double minAmount;
  final double maxAmount;
  final TextStyle? style;
  final bool showDecimals;
  final double? iconSize;
  final Color? iconColor;

  const DirhamPriceRange({
    super.key,
    required this.minAmount,
    required this.maxAmount,
    this.style,
    this.showDecimals = false,
    this.iconSize,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DirhamPrice(
          amount: minAmount,
          style: style,
          showDecimals: showDecimals,
          iconSize: iconSize,
          iconColor: iconColor,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(' - ', style: style),
        ),
        DirhamPrice(
          amount: maxAmount,
          style: style,
          showDecimals: showDecimals,
          iconSize: iconSize,
          iconColor: iconColor,
        ),
      ],
    );
  }
}