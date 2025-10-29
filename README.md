# Dirham Symbol

A flexible Flutter package for UAE Dirham currency display with multiple symbol options, price formatting, and convenient extensions.

[![pub package](https://img.shields.io/pub/v/dirham_symbol.svg)](https://pub.dev/packages/dirham_symbol)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Features

-  **Multiple symbol types**: SVG icon, Arabic (د.إ), AED, Dh
-  **Extension methods**: Clean syntax with `.toDirham()` for both `num` and `String`
-  **Customizable**: Size, color, and text styling
-  **Price formatting**: Decimals, ranges, and inline text
-  **Flexible positioning**: Auto or manual symbol placement
-  **RTL support**: Proper Arabic text handling

## Installation

```yaml
dependencies:
  dirham_symbol: ^0.3.1  
```

## Quick Start

### Using Extensions (Recommended) ✨

```dart
import 'package:dirham_symbol/dirham_symbol.dart';

// Simple price - numeric types
99.99.toDirham()
250.toDirham(symbolType: DirhamSymbolType.arabic)

// String parsing
"99.99".toDirham(showDecimals: true)
"500".toDirham(symbolType: DirhamSymbolType.aed)

// Inline text
149.99.toDirhamText(
  prefix: 'Starting from',
  suffix: 'only!',
  symbolType: DirhamSymbolType.arabic,
)

// Price ranges
50.toDirhamRange(100, symbolType: DirhamSymbolType.arabic)
```

### Traditional Widgets

```dart
// Still fully supported
DirhamPrice(amount: 150, style: TextStyle(fontSize: 24))

DirhamPrice(
  amount: 150,
  symbolType: DirhamSymbolType.arabic,
  style: TextStyle(fontSize: 24),
)
```

## Symbol Types

| Type | Display | Use Case |
|------|---------|----------|
| `icon` | SVG | Modern apps (default) |
| `arabic` | د.إ | Arabic/RTL apps |
| `aed` | AED | International apps |
| `dh` | Dh | Simplified display |

## Extension Methods

### On Numeric Types (`num`, `int`, `double`)

#### `.toDirham()`
Convert numbers to price widgets:
```dart
99.99.toDirham(
  symbolType: DirhamSymbolType.arabic,
  showDecimals: true,
  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
)
```

#### `.toDirhamText()`
Create inline text with prices:
```dart
299.toDirhamText(
  prefix: 'Only',
  suffix: 'today!',
  symbolType: DirhamSymbolType.icon,
)
```

#### `.toDirhamRange()`
Display price ranges:
```dart
50.toDirhamRange(
  100,
  symbolType: DirhamSymbolType.arabic,
  showDecimals: true,
)
```

### On String Type

Same methods as numeric types, with automatic parsing:
```dart
"99.99".toDirham(showDecimals: true)
"500".toDirhamText(prefix: 'From', suffix: 'per item')
"50".toDirhamRange("100")
```

## Common Examples

### Product Card
```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Premium Package', style: TextStyle(fontSize: 18)),
    SizedBox(height: 8),
    999.toDirham(
      symbolType: DirhamSymbolType.arabic,
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    ),
  ],
)
```

### Sale Pricing
```dart
Row(
  children: [
    500.toDirham(
      style: TextStyle(
        decoration: TextDecoration.lineThrough,
        color: Colors.grey,
      ),
    ),
    SizedBox(width: 10),
    350.toDirham(
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
    ),
  ],
)
```

### Dynamic Pricing from API
```dart
// If your API returns numbers
product.price.toDirham(symbolType: DirhamSymbolType.arabic)

// If your API returns strings
product.priceString.toDirham(showDecimals: true)
```

### Price with Decimals
```dart
99.99.toDirham(showDecimals: true)
```

### Symbol Position Control
```dart
250.toDirham(
  symbolBefore: false,  // 250 د.إ
  symbolType: DirhamSymbolType.arabic,
)
```

### Promotional Banner
```dart
Container(
  padding: EdgeInsets.all(16),
  child: 149.99.toDirhamText(
    prefix: '🎉 Special offer:',
    suffix: 'for limited time!',
    symbolType: DirhamSymbolType.arabic,
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  ),
)
```

## Main Widgets (Traditional API)

### DirhamPrice
```dart
DirhamPrice(
  amount: 150,              // required
  symbolType: DirhamSymbolType.icon,
  style: TextStyle(),
  showDecimals: false,
  formatNumber: true,
  symbolBefore: null,       // auto-positioned based on symbol type
  iconSize: null,           // auto-calculated from font size
  iconColor: null,          // inherits from style
  locale: 'en_US',
)
```

### DirhamPriceRange
```dart
DirhamPriceRange(
  minAmount: 50,            // required
  maxAmount: 150,           // required
  symbolType: DirhamSymbolType.icon,
  style: TextStyle(),
  showDecimals: false,
  iconSize: null,
  iconColor: null,
  locale: 'en_US',
)
```

### InlineDirhamText
```dart
InlineDirhamText(
  prefix: 'Starting from',
  amount: 99,               // required
  suffix: 'only!',
  symbolType: DirhamSymbolType.icon,
  style: TextStyle(),
  showDecimals: false,
  formatNumber: true,
)
```

### DirhamIcon
```dart
DirhamIcon(
  size: 24,
  color: Colors.black,
)
```

### DirhamSymbol
```dart
DirhamSymbol(
  type: DirhamSymbolType.arabic,
  size: 20,
  color: Colors.blue,
  textStyle: TextStyle(),
)
```

## Migration from 0.2.7 to 0.3.0

The package is **fully backward compatible**. All existing code will continue to work.

To adopt the new extension syntax:

```dart
// Before (still works)
DirhamPrice(amount: 99.99, showDecimals: true)

// After (cleaner)
99.99.toDirham(showDecimals: true)
```

```dart
// Before
InlineDirhamText(
  prefix: 'From',
  amount: 149,
  suffix: 'only',
  symbolType: DirhamSymbolType.arabic,
)

// After
149.toDirhamText(
  prefix: 'From',
  suffix: 'only',
  symbolType: DirhamSymbolType.arabic,
)
```

## Requirements

- Flutter: >=3.0.0
- Dart: >=3.0.0 <4.0.0

## License

MIT License - see [LICENSE](LICENSE) for details.

## Screenshots

<table>
  <tr>
    <td><img src="https://raw.githubusercontent.com/nadeerep07/dirham-symbol/master/screenshots/light_mode.png" width="350"/></td>
    <td><img src="https://raw.githubusercontent.com/nadeerep07/dirham-symbol/master/screenshots/dark_mode.png" width="350"/></td>
  </tr>
</table>


## Links

- [GitHub](https://github.com/nadeerep07/dirham-symbol)
- [Issues](https://github.com/nadeerep07/dirham-symbol/issues)
- [pub.dev](https://pub.dev/packages/dirham_symbol)
- [API Documentation](https://pub.dev/documentation/dirham_symbol/latest/)


Created with ❤️ for the Flutter community