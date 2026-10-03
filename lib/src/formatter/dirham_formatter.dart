import 'package:intl/intl.dart';
import '../models/enums.dart';

/// Pure Dart utility class for formatting, parsing, and converting UAE Dirham values.
class DirhamFormatter {
  const DirhamFormatter._();

  /// Map of Western Arabic digits (0-9) to Eastern Arabic digits (٠-٩)
  static const Map<String, String> _easternArabicDigits = {
    '0': '٠',
    '1': '١',
    '2': '٢',
    '3': '٣',
    '4': '٤',
    '5': '٥',
    '6': '٦',
    '7': '٧',
    '8': '٨',
    '9': '٩',
    '.': '٫',
    ',': '٬',
  };

  /// Returns the text representation for a [DirhamSymbolType]
  static String getSymbolText(DirhamSymbolType type) {
    switch (type) {
      case DirhamSymbolType.icon:
      case DirhamSymbolType.aed:
        return 'AED';
      case DirhamSymbolType.arabic:
        return 'د.إ';
      case DirhamSymbolType.dh:
        return 'Dh';
    }
  }

  /// Determines if the symbol should conventionally precede the amount.
  /// Arabic (`د.إ`) defaults to after or before depending on standard Arabic RTL contexts.
  static bool shouldSymbolBeBefore(DirhamSymbolType type, {bool? override}) {
    if (override != null) return override;
    return type != DirhamSymbolType.arabic;
  }

  /// Converts a string with Western digits to Eastern Arabic digits (e.g., '123.45' -> '١٢٣٫٤٥')
  static String toEasternArabic(String input) {
    final buffer = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      final char = input[i];
      buffer.write(_easternArabicDigits[char] ?? char);
    }
    return buffer.toString();
  }

  /// Format an amount into a Dirham currency string (e.g. "AED 1,500.00" or "1,500 د.إ").
  ///
  /// [amount] The numeric value in Dirhams.
  /// [symbolType] Type of symbol: [DirhamSymbolType.icon], [DirhamSymbolType.arabic], etc.
  /// [showDecimals] Whether to include decimal places (e.g. `.00`).
  /// [formatNumber] Whether to apply thousands grouping separators.
  /// [symbolBefore] Place symbol before or after amount. Defaults to conventional placement.
  /// [locale] Formatting locale, e.g. `'en_US'` or `'ar_AE'`.
  /// [useEasternArabicNumerals] Converts numbers to Eastern Arabic numerals (`١٢٣`).
  /// [decimalDigits] Custom decimal places count (overrides [showDecimals] when specified).
  /// [customSymbol] Optional custom symbol string if you don't want the default.
  static String format(
    double amount, {
    DirhamSymbolType symbolType = DirhamSymbolType.aed,
    bool showDecimals = false,
    bool formatNumber = true,
    bool? symbolBefore,
    String locale = 'en_US',
    bool useEasternArabicNumerals = false,
    int? decimalDigits,
    String? customSymbol,
    String separator = ' ',
  }) {
    final digits = decimalDigits ?? (showDecimals ? 2 : 0);

    String formattedAmount;
    if (formatNumber) {
      final formatter = NumberFormat.currency(
        decimalDigits: digits,
        symbol: '',
        locale: locale,
      );
      formattedAmount = formatter.format(amount).trim();
    } else {
      formattedAmount = amount.toStringAsFixed(digits);
    }

    if (useEasternArabicNumerals) {
      formattedAmount = toEasternArabic(formattedAmount);
    }

    final symbol = customSymbol ?? getSymbolText(symbolType);
    final isBefore = shouldSymbolBeBefore(symbolType, override: symbolBefore);

    if (isBefore) {
      return '$symbol$separator$formattedAmount';
    } else {
      return '$formattedAmount$separator$symbol';
    }
  }

  /// Compactly format large amounts (e.g. `1.5K AED`, `2.4M د.إ`, `1.2B AED`).
  ///
  /// [amount] The numeric value to format.
  /// [symbolType] Type of symbol.
  /// [symbolBefore] Position of the symbol.
  /// [locale] Formatting locale.
  /// [decimalDigits] Number of decimal places (default is 1 for compact).
  /// [useEasternArabicNumerals] Converts digits to Eastern Arabic numerals.
  static String formatCompact(
    double amount, {
    DirhamSymbolType symbolType = DirhamSymbolType.aed,
    bool? symbolBefore,
    String locale = 'en_US',
    int decimalDigits = 1,
    bool useEasternArabicNumerals = false,
    String separator = ' ',
  }) {
    final absAmount = amount.abs();
    final sign = amount < 0 ? '-' : '';
    String compactNumber;

    if (absAmount >= 1e9) {
      compactNumber = '$sign${(absAmount / 1e9).toStringAsFixed(decimalDigits).replaceAll(RegExp(r'\.0+$'), '')}B';
    } else if (absAmount >= 1e6) {
      compactNumber = '$sign${(absAmount / 1e6).toStringAsFixed(decimalDigits).replaceAll(RegExp(r'\.0+$'), '')}M';
    } else if (absAmount >= 1e3) {
      compactNumber = '$sign${(absAmount / 1e3).toStringAsFixed(decimalDigits).replaceAll(RegExp(r'\.0+$'), '')}K';
    } else {
      compactNumber = '$sign${absAmount.toStringAsFixed(0)}';
    }

    if (useEasternArabicNumerals) {
      compactNumber = toEasternArabic(compactNumber);
    }

    final symbol = getSymbolText(symbolType);
    final isBefore = shouldSymbolBeBefore(symbolType, override: symbolBefore);

    if (isBefore) {
      return '$symbol$separator$compactNumber';
    } else {
      return '$compactNumber$separator$symbol';
    }
  }

  /// Converts UAE Dirhams to Fils (1 AED = 100 Fils).
  ///
  /// Example: `15.50` -> `1550`
  static int toFils(num dirham) {
    return (dirham * 100).round();
  }

  /// Converts Fils to UAE Dirhams (100 Fils = 1 AED).
  ///
  /// Example: `1550` -> `15.50`
  static double fromFils(int fils) {
    return fils / 100.0;
  }

  /// Formats an amount given in Fils directly to a Dirham string.
  ///
  /// Example: `formatFils(2500)` -> `"AED 25.00"`
  static String formatFils(
    int fils, {
    DirhamSymbolType symbolType = DirhamSymbolType.aed,
    bool formatNumber = true,
    bool? symbolBefore,
    String locale = 'en_US',
    bool useEasternArabicNumerals = false,
  }) {
    return format(
      fromFils(fils),
      symbolType: symbolType,
      showDecimals: true,
      formatNumber: formatNumber,
      symbolBefore: symbolBefore,
      locale: locale,
      useEasternArabicNumerals: useEasternArabicNumerals,
    );
  }

  /// Parse a string that contains numbers, commas, and currency symbols into a clean [double].
  ///
  /// Examples:
  /// - `"AED 1,250.50"` -> `1250.50`
  /// - `"1,500 د.إ"` -> `1500.0`
  /// - `"١٢٣٫٤٥"` -> `123.45`
  static double parseAmount(String input, {double defaultValue = 0.0}) {
    if (input.trim().isEmpty) return defaultValue;

    // Convert Eastern Arabic numerals to standard western numerals
    String normalized = input;
    _easternArabicDigits.forEach((western, eastern) {
      normalized = normalized.replaceAll(eastern, western);
    });

    // Remove any non-numeric characters except '.' and '-'
    normalized = normalized.replaceAll(RegExp(r'[^0-9.-]'), '');

    return double.tryParse(normalized) ?? defaultValue;
  }
}
