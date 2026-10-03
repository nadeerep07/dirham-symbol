# Changelog

All notable changes to this project will be documented in this file.  
This project adheres to [Semantic Versioning](https://semver.org/).

---

## [0.4.1] - 2026-10-03

### 🔧 Fixes & Docs
- Fixed screenshot asset URLs in `README.md` to reference the `main` branch.
- Cleaned up symbol table rendering for pub.dev.

---

## [0.4.0] - 2026-10-03

### 🚀 Major Feature Update (100% Backward Compatible)
- 💳 **DirhamInputFormatter & DirhamTextField**:
  - `DirhamInputFormatter` (`TextInputFormatter`): real-time thousands formatting, decimal precision limiter, and max amount restrictions.
  - `DirhamTextField`: pre-built form field with built-in currency symbol prefix/suffix, clear button, and direct `double` & Fils amount callbacks.
- 🏷️ **E-Commerce DirhamSalePrice Widget**:
  - Displays original price (strikethrough) alongside discounted sale price with auto-calculated discount percentage or amount saved badges.
- ⚡ **AnimatedDirhamPrice Widget**:
  - Smooth implicitly animated number ticker for shopping carts, wallet balances, and checkout screens.
- 🏷️ **DirhamBadge & DirhamChip**:
  - Compact pill badges for promotional tags, delivery fees, and cashback chips.
- 🛠️ **Pure Dart DirhamFormatter**:
  - `.toDirhamString()` for generating currency strings without rendering Flutter widgets (ideal for API payloads, push notifications, and PDF invoices).
  - `.toDirhamCompact()` for short notation (`1.5K AED`, `2.4M د.إ`).
  - `.toFils()`, `filsToDirham()`, and `DirhamFormatter.formatFils()` for Fils subunit math.
  - Full Eastern Arabic Numerals (`١٢٣٤٥٦٧٨٩٠`) support.
- 🎨 **DirhamTheme / DirhamThemeData**:
  - App-wide default configuration for symbol type, decimals, formatting, and locale.
- 🖌️ **Zero-Asset Canvas DirhamVectorIcon & DirhamCustomPainter**:
  - Pure Flutter canvas vector painter for the official UAE Dirham symbol.
- 📱 **Interactive 4-Tab Example Application**:
  - Live interactive showcase including E-Commerce demo, FinTech wallet demo, form field input playground, and code generator.
- 🛡️ **100% Backward Compatibility Guaranteed**:
  - All existing code, widgets, and extension methods work identically without breaking changes.

---

## [0.3.2] - 2025-10-29

### Added
- ✨ **Extension Methods** for `num` and `String`:
  - `.toDirham()` → clean and quick price display
  - `.toDirhamText()` → inline promotional text support
  - `.toDirhamRange()` → for displaying min–max price ranges
- **InlineDirhamText Widget** for embedding prices in sentences
- **Improved Symbol Rendering** — supports custom size, color, and style
- **Adaptive Light/Dark Mode** for better theme consistency
- **Backward Compatibility** with version `0.2.7`

### Updated
- Smarter **symbol positioning** logic (auto-detect before/after)
- Enhanced **documentation and examples** for better developer experience
- Updated **README.md** and **pub.dev description** with cleaner examples

---

## [0.2.7] - 2025-10-27

### 🏁 Initial Release
- Introduced **Dirham symbol** as an SVG widget (`DirhamIcon`)
- Added **DirhamPrice** and **DirhamPriceRange** widgets
- Support for **symbol positioning** (before or after price)
- Included **decimal support** and automatic number formatting
- Full **customization via TextStyle**
- Published under the **MIT License**

---

**Dirham Symbol** — built with ❤️ for the Flutter community.
