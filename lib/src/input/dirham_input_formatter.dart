import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// A [TextInputFormatter] that formats numeric input as currency in real time (e.g., `1,250.00`).
///
/// Handles:
/// - Thousands separators (`,`)
/// - Decimal precision restriction (default 2 decimals)
/// - Maximum allowed amount
/// - Safe cursor positioning
class DirhamInputFormatter extends TextInputFormatter {
  /// Number of allowed decimal places (default is 2, set 0 for integer amounts)
  final int decimalDigits;

  /// Optional maximum allowed amount
  final double? maxAmount;

  /// Whether negative amounts are allowed (default false)
  final bool allowNegative;

  /// Thousands separator symbol (default `,`)
  final String thousandSeparator;

  /// Decimal separator symbol (default `.`)
  final String decimalSeparator;

  DirhamInputFormatter({
    this.decimalDigits = 2,
    this.maxAmount,
    this.allowNegative = false,
    this.thousandSeparator = ',',
    this.decimalSeparator = '.',
  }) : assert(decimalDigits >= 0, 'decimalDigits must be non-negative');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Strip non-digits except decimal separator and negative sign
    String cleanText = newValue.text;
    final isNegative = allowNegative && cleanText.startsWith('-');
    cleanText = cleanText.replaceAll(RegExp(r'[^0-9.]'), '');

    // Prevent multiple decimal points
    final parts = cleanText.split(decimalSeparator);
    if (parts.length > 2) {
      return oldValue;
    }

    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    // Enforce decimal digits limit
    if (decimalDigits == 0 && parts.length > 1) {
      return oldValue;
    }
    if (decimalPart.length > decimalDigits) {
      decimalPart = decimalPart.substring(0, decimalDigits);
    }

    // Check max amount if specified
    final parsedValue = double.tryParse('$integerPart${parts.length > 1 ? '.$decimalPart' : ''}');
    if (parsedValue != null && maxAmount != null) {
      final signMulti = isNegative ? -1.0 : 1.0;
      if ((parsedValue * signMulti).abs() > maxAmount!) {
        return oldValue;
      }
    }

    // Format integer part with thousands separator
    String formattedInteger = '';
    if (integerPart.isNotEmpty) {
      final numberFormatter = NumberFormat('#,###', 'en_US');
      final intVal = int.tryParse(integerPart) ?? 0;
      formattedInteger = numberFormatter.format(intVal);
    }

    // Assemble new formatted text
    String formattedText = '';
    if (isNegative) formattedText += '-';
    formattedText += formattedInteger;

    if (parts.length > 1) {
      formattedText += decimalSeparator + decimalPart;
    }

    // Adjust cursor selection position
    int cursorPosition = formattedText.length;
    final diff = formattedText.length - newValue.text.length;
    final targetOffset = newValue.selection.baseOffset + diff;
    if (targetOffset >= 0 && targetOffset <= formattedText.length) {
      cursorPosition = targetOffset;
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: math.min(cursorPosition, formattedText.length),
      ),
    );
  }

  /// Extracts the unformatted numeric value as a [double]
  static double getUnformattedAmount(String text, {double defaultValue = 0.0}) {
    final clean = text.replaceAll(',', '').trim();
    return double.tryParse(clean) ?? defaultValue;
  }

  /// Extracts the value as integer Fils
  static int getFils(String text) {
    final amount = getUnformattedAmount(text);
    return (amount * 100).round();
  }
}
