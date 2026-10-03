/// Supported Dirham symbol display types
enum DirhamSymbolType {
  /// Official UAE Dirham symbol font glyph (D with two horizontal lines)
  icon,

  /// Arabic text symbol: د.إ
  arabic,

  /// Latin text symbol: AED
  aed,

  /// Simplified abbreviation: Dh
  dh,
}

/// Discount badge display mode for [DirhamSalePrice]
enum DirhamDiscountBadgeType {
  /// Display percentage off, e.g. "-25%"
  percentage,

  /// Display saved amount, e.g. "Save 50 د.إ"
  saveAmount,

  /// Custom badge text
  custom,
}
