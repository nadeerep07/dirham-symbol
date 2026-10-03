import 'package:flutter/material.dart';
import '../theme/dirham_theme.dart';
import '../dirham_icon.dart';

/// An implicitly animated widget that smoothly interpolates between numeric amounts
/// when the [amount] changes (great for fintech balances, carts, and counters).
///
/// Example:
/// ```dart
/// AnimatedDirhamPrice(
///   amount: _currentBalance,
///   duration: Duration(milliseconds: 600),
///   curve: Curves.easeOutCubic,
///   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
/// )
/// ```
class AnimatedDirhamPrice extends ImplicitlyAnimatedWidget {
  /// The target amount to animate to
  final double amount;

  /// Text styling
  final TextStyle? style;

  /// Whether to show decimals
  final bool? showDecimals;

  /// Whether to format with commas
  final bool? formatNumber;

  /// Symbol placement
  final bool? symbolBefore;

  /// Icon size
  final double? iconSize;

  /// Icon color
  final Color? iconColor;

  /// MainAxisAlignment
  final MainAxisAlignment alignment;

  /// Symbol type
  final DirhamSymbolType? symbolType;

  /// Formatting locale
  final String? locale;

  const AnimatedDirhamPrice({
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
    super.duration = const Duration(milliseconds: 500),
    super.curve = Curves.easeOutCubic,
    super.onEnd,
  });

  @override
  AnimatedWidgetBaseState<AnimatedDirhamPrice> createState() =>
      _AnimatedDirhamPriceState();
}

class _AnimatedDirhamPriceState
    extends AnimatedWidgetBaseState<AnimatedDirhamPrice> {
  Tween<double>? _amountTween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _amountTween = visitor(
      _amountTween,
      widget.amount,
      (dynamic value) => Tween<double>(begin: value as double),
    ) as Tween<double>?;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = DirhamTheme.of(context);
    final effectiveSymbolType = widget.symbolType ?? themeData.symbolType;
    final effectiveShowDecimals =
        widget.showDecimals ?? themeData.showDecimals;
    final effectiveFormatNumber =
        widget.formatNumber ?? themeData.formatNumber;
    final effectiveLocale = widget.locale ?? themeData.locale;
    final currentAmount = _amountTween?.evaluate(animation) ?? widget.amount;

    return DirhamPrice(
      amount: currentAmount,
      style: widget.style,
      showDecimals: effectiveShowDecimals,
      formatNumber: effectiveFormatNumber,
      symbolBefore: widget.symbolBefore,
      iconSize: widget.iconSize,
      iconColor: widget.iconColor,
      alignment: widget.alignment,
      symbolType: effectiveSymbolType,
      locale: effectiveLocale,
    );
  }
}
