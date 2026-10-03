# UAE Dirham Symbol & Currency Suite for Flutter 🇦🇪

[![pub package](https://img.shields.io/pub/v/dirham_symbol.svg)](https://pub.dev/packages/dirham_symbol)
[![pub points](https://img.shields.io/pub/points/dirham_symbol?color=2E8B57)](https://pub.dev/packages/dirham_symbol/score)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-All%20Platforms-02569B?logo=flutter)](https://flutter.dev)

The **all-in-one UAE Dirham (AED) currency toolkit** for Flutter. Designed for modern E-Commerce, FinTech, and Banking apps across Dubai, Abu Dhabi, and the GCC.

Includes the **official UAE Dirham vector & SVG symbols**, **live currency input formatters**, **strikethrough sale pricing**, **animated price counters**, **pure string formatters**, **Fils subunit math**, and **global theme support**.

---

## ✨ Features

* 💎 **Official UAE Symbols**: Vector Canvas (`DirhamVectorIcon`) + SVG (`DirhamIcon`) + Arabic (`د.إ`) + Latin (`AED`, `Dh`).
* ⚡ **Expressive Extensions**: `.toDirham()`, `.toDirhamString()`, `.toDirhamCompact()`, `.toDirhamSale()`, `.toDirhamBadge()`, `.toDirhamAnimated()`.
* 💳 **FinTech Input Formatter**: Real-time thousands masking (`1,250.00`) with `DirhamInputFormatter` & ready-to-use `DirhamTextField`.
* 🏷️ **E-Commerce Sale Pricing**: Slashed original prices + discounted prices + auto-calculated discount badges (`Save 25%`).
* 📊 **Animated Balance & Price Counter**: Smooth ticker animation for carts, balances, and checkout totals.
* 🪙 **Subunit (Fils) Math**: Seamless conversions (`10.50 AED` ↔ `1050 Fils`) for Stripe, Checkout.com, and payment gateways.
* 🔤 **Pure String Formatting**: Return strings without widgets (`DirhamFormatter.format(...)`) for APIs, notifications, & PDFs.
* 🎨 **App-Wide Theme**: Configure default symbol type, locale, and decimals with `DirhamTheme`.
* 🌐 **Eastern Arabic Numerals**: Full support for Arabic-Indic numerals (`١٢٣٤٥٦٧٨٩٠`).
* 🛡️ **100% Backward Compatible**: Drop-in upgrade with zero breaking changes.

---

## 📦 Installation

Add `dirham_symbol` to your `pubspec.yaml`:

```yaml
dependencies:
  dirham_symbol: ^0.4.0
```

Import in your Dart code:

```dart
import 'package:dirham_symbol/dirham_symbol.dart';
```

---

## 🚀 Quick Start

### 1. Extension Methods (Fastest)

```dart
// Basic price widgets
99.99.toDirham()                                  // Official icon + 99.99
250.toDirham(symbolType: DirhamSymbolType.arabic)  // 250 د.إ
"1500".toDirham(showDecimals: true)               // 1,500.00 AED

// Inline text with prefix/suffix
149.99.toDirhamText(prefix: 'Starting from', suffix: 'only!')

// Price ranges
50.toDirhamRange(150, symbolType: DirhamSymbolType.arabic) // د.إ 50 - د.إ 150
```

---

### 2. Pure String Formatting (No Widgets)

Generate formatted strings for **API requests, push notifications, native bridges, or PDF receipts**:

```dart
// Standard formatted string
1500.toDirhamString()                             // "AED 1,500"
1500.50.toDirhamString(symbolType: DirhamSymbolType.arabic, showDecimals: true) // "1,500.50 د.إ"

// Compact format for large numbers
1500.toDirhamCompact()                            // "AED 1.5K"
2500000.toDirhamCompact(symbolType: DirhamSymbolType.arabic) // "2.5M د.إ"

// Parse numeric values from dirty strings
"AED 1,250.50".cleanDirhamAmount()                // 1250.50
```

---

### 3. E-Commerce Sale Prices & Badges 🛍️

Showcase discounts with original strikethrough price, sale price, and automatic percentage/savings badges:

```dart
// Auto-calculates -25% discount badge
200.toDirhamSale(150)

// Detailed customization
DirhamSalePrice(
  originalAmount: 500,
  saleAmount: 350,
  badgeType: DirhamDiscountBadgeType.percentage, // or .saveAmount
  symbolType: DirhamSymbolType.arabic,
  axis: Axis.horizontal,                         // or Axis.vertical
)

// Promotional badges and chips
DirhamBadge(
  amount: 100,
  prefix: 'Free delivery over',
  backgroundColor: Colors.green.shade50,
  textColor: Colors.green.shade900,
)
```

---

### 4. FinTech Currency Input & Form Field 💳

A plug-and-play Material 3 currency input with live comma separation, decimal locking, and currency prefix/suffix:

```dart
// Ready-to-use Form Field
DirhamTextField(
  initialAmount: 250.0,
  showClearButton: true,
  decoration: InputDecoration(
    labelText: 'Transfer Amount',
    border: OutlineInputBorder(),
  ),
  onAmountChanged: (double? amount) {
    print('Entered AED: $amount');
  },
  onFilsChanged: (int? fils) {
    print('Amount in Fils: $fils'); // e.g. 25000
  },
)

// Or use the formatter with your own TextField
TextField(
  keyboardType: TextInputType.numberWithOptions(decimal: true),
  inputFormatters: [
    DirhamInputFormatter(decimalDigits: 2, maxAmount: 100000),
  ],
)
```

---

### 5. Animated Balance & Price Ticker ⚡

Smoothly animate balance updates, shopping cart additions, and price changes:

```dart
AnimatedDirhamPrice(
  amount: _cartTotal,
  duration: Duration(milliseconds: 600),
  curve: Curves.easeOutCubic,
  showDecimals: true,
  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
)
```

---

### 6. Subunit (Fils) Math 🪙

Seamlessly handle Fils for payment integrations (1 AED = 100 Fils):

```dart
// Convert AED to Fils
10.50.toFils()              // 1050

// Convert Fils to AED
5000.filsToDirham()         // 50.0
5000.filsToDirhamString()   // "AED 50.00"
5000.filsToDirhamWidget()   // DirhamPrice Widget
```

---

### 7. App-Wide Global Theme 🎨

Set your default symbol type, locale, and decimal preferences once at the root:

```dart
DirhamTheme(
  data: DirhamThemeData(
    symbolType: DirhamSymbolType.arabic, // Defaults all widgets to 'د.إ'
    showDecimals: true,
    spacing: 6.0,
  ),
  child: MyApp(),
)
```

---

## 🔣 Symbol Types

| Type | Output | Use Case |
|:-----|:-------|:---------|
| `DirhamSymbolType.icon` | ![Dirham Icon](https://raw.githubusercontent.com/nadeerep07/dirham-symbol/master/screenshots/light_mode.png) | Modern UAE apps (Official glyph) |
| `DirhamSymbolType.arabic` | **د.إ** | Arabic & RTL interfaces |
| `DirhamSymbolType.aed` | **AED** | Standard international apps & banking |
| `DirhamSymbolType.dh` | **Dh** | Compact abbreviations |

---

## 🖼️ Zero-Asset Canvas Glyph

Render the official Dirham symbol with zero asset bundle dependency and high-performance custom canvas paint:

```dart
DirhamVectorIcon(
  size: 32,
  color: Color(0xFF007A3D),
)
```

---

## 📱 Screenshots

<table>
  <tr>
    <td align="center"><b>🌟 Dirham Icon & Symbols (Light)</b></td>
    <td align="center"><b>🛍️ E-Commerce Sale Prices (Dark)</b></td>
    <td align="center"><b>💳 FinTech & Forms</b></td>
  </tr>
  <tr>
    <td><img src="https://raw.githubusercontent.com/nadeerep07/dirham-symbol/master/screenshots/light_mode.png" width="280"/></td>
    <td><img src="https://raw.githubusercontent.com/nadeerep07/dirham-symbol/master/screenshots/dark_mode.png" width="280"/></td>
    <td><img src="https://raw.githubusercontent.com/nadeerep07/dirham-symbol/master/screenshots/examples.png" width="280"/></td>
  </tr>
</table>

---

## 🛡️ Backward Compatibility

Upgrading from `0.3.x` or `0.2.x` is **100% safe**. All existing widget declarations, parameters, and extension signatures continue to work identically without any breaking changes.

---

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

Developed with ❤️ for the Flutter & UAE Developer Community.