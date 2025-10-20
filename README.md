# Dirham Symbol

A flexible Flutter package providing the UAE Dirham currency symbol with multiple display options: custom SVG icon, Arabic text (د.إ), AED, and Dh. Includes easy-to-use widgets for price formatting with extensive customization options.

[![pub package](https://img.shields.io/pub/v/dirham_symbol.svg)](https://pub.dev/packages/dirham_symbol)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Features

- 🎨 **Multiple Symbol Types**: SVG icon, Arabic (د.إ), AED, or Dh
- 📏 **Fully Customizable**: Size, color, and text styling
- 💰 **Smart Price Formatting**: Ready-to-use widgets with automatic sizing
- 🔄 **Flexible Positioning**: Symbol before or after amount
- 📊 **Price Ranges**: Built-in support for min-max displays
- 💵 **Decimal Support**: Show or hide decimal places
- 🎯 **Auto-scaling**: Icon size adapts to text size
- ⚡ **Lightweight**: Minimal dependencies
- 🌍 **RTL Support**: Works with Arabic layouts

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  dirham_symbol: ^0.2.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

```dart
import 'package:dirham_symbol/dirham_symbol.dart';

// Simple price with SVG icon
DirhamPrice(
  amount: 150,
  style: TextStyle(fontSize: 24),
)

// Arabic text symbol
DirhamPrice(
  amount: 150,
  symbolType: DirhamSymbolType.arabic,
  style: TextStyle(fontSize: 24),
)

// AED format
DirhamPrice(
  amount: 150,
  symbolType: DirhamSymbolType.aed,
  style: TextStyle(fontSize: 24),
)
```

## Symbol Types

The package supports four different symbol representations:

| Type | Display | Use Case |
|------|---------|----------|
| `DirhamSymbolType.icon` | 🎨 Custom SVG | Modern apps, unique branding |
| `DirhamSymbolType.arabic` | د.إ | Arabic/RTL apps, UAE market |
| `DirhamSymbolType.aed` | AED | International apps, financial systems |
| `DirhamSymbolType.dh` | Dh | Casual apps, simplified display |

## Usage Examples

### 1. Basic Dirham Icon

Display just the symbol as an icon:

```dart
// Default SVG icon
DirhamIcon()

// Custom size
DirhamIcon(size: 50)

// Custom color
DirhamIcon(size: 30, color: Colors.green)
```

### 2. Price with Different Symbol Types

```dart
// SVG Icon (default)
DirhamPrice(
  amount: 150,
  symbolType: DirhamSymbolType.icon,
  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
)

// Arabic text
DirhamPrice(
  amount: 150,
  symbolType: DirhamSymbolType.arabic,
  style: TextStyle(fontSize: 24),
)

// AED
DirhamPrice(
  amount: 150,
  symbolType: DirhamSymbolType.aed,
  style: TextStyle(fontSize: 24),
)

// Dh
DirhamPrice(
  amount: 150,
  symbolType: DirhamSymbolType.dh,
  style: TextStyle(fontSize: 24),
)
```

### 3. Price with Decimals

```dart
DirhamPrice(
  amount: 99.99,
  showDecimals: true,
  symbolType: DirhamSymbolType.arabic,
  style: TextStyle(fontSize: 20),
)
// Output: د.إ 99.99
```

### 4. Symbol Position

```dart
// Symbol before (default)
DirhamPrice(
  amount: 250,
  symbolBefore: true,
  style: TextStyle(fontSize: 24),
)
// Output: د.إ 250

// Symbol after

DirhamPrice(
  amount: 250,
  symbolBefore: false,
  style: TextStyle(fontSize: 24),
)
// Output: 250 د.إ
```

### 5. Strikethrough Price

Perfect for showing original prices:

```dart
DirhamPrice(
  amount: 500,
  symbolType: DirhamSymbolType.icon,
  style: TextStyle(
    fontSize: 18,
    color: Colors.grey,
    decoration: TextDecoration.lineThrough,
    decorationColor: Colors.grey,
    decorationThickness: 2,
  ),
)
```

### 6. Price Comparison (Sale Pricing)

```dart
Row(
  children: [
    // Original price
    DirhamPrice(
      amount: 500,
      symbolType: DirhamSymbolType.arabic,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
        decoration: TextDecoration.lineThrough,
      ),
    ),
    SizedBox(width: 10),
    // Sale price
    DirhamPrice(
      amount: 350,
      symbolType: DirhamSymbolType.arabic,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    ),
  ],
)
```

### 7. Price Range

```dart
// Basic range
DirhamPriceRange(
  minAmount: 50,
  maxAmount: 150,
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
)
// Output: د.إ 50 - د.إ 150

// With different symbol type
DirhamPriceRange(
  minAmount: 99.99,
  maxAmount: 299.99,
  showDecimals: true,
  symbolType: DirhamSymbolType.aed,
  style: TextStyle(fontSize: 16),
)
// Output: AED 99.99 - AED 299.99
```

### 8. Inline with Text

```dart
Row(
  children: [
    Text('Starting from ', style: TextStyle(fontSize: 16)),
    DirhamPrice(
      amount: 99,
      symbolType: DirhamSymbolType.arabic,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    ),
    Text(' only!', style: TextStyle(fontSize: 16)),
  ],
)
// Output: Starting from د.إ 99 only!
```

### 9. Product Card Example

```dart
Card(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Premium Service'),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Original price
            DirhamPrice(
              amount: 500,
              symbolType: DirhamSymbolType.icon,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            SizedBox(height: 4),
            // Sale price
            DirhamPrice(
              amount: 350,
              symbolType: DirhamSymbolType.icon,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    ),
  ),
)
```

## Widget Reference

### DirhamIcon

Simple SVG icon widget.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `size` | `double?` | `24.0` | Size of the icon |
| `color` | `Color?` | `null` | Color of the icon |

### DirhamSymbol

Generic symbol widget supporting all types.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `type` | `DirhamSymbolType` | `icon` | Symbol type to display |
| `size` | `double?` | `24.0` | Size of the symbol |
| `color` | `Color?` | `null` | Color of the symbol |
| `textStyle` | `TextStyle?` | `null` | Text style (for text symbols) |

### DirhamPrice

Complete price formatting widget.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `amount` | `double` | required | The price amount |
| `style` | `TextStyle?` | `null` | Text style for the amount |
| `showDecimals` | `bool` | `false` | Show decimal places (2 digits) |
| `symbolBefore` | `bool` | `true` | Position symbol before amount |
| `iconSize` | `double?` | auto | Symbol size (auto-calculated) |
| `iconColor` | `Color?` | auto | Symbol color (inherits from style) |
| `alignment` | `MainAxisAlignment` | `start` | Row alignment |
| `symbolType` | `DirhamSymbolType` | `icon` | Type of symbol to display |

### DirhamPriceRange

Price range display widget.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `minAmount` | `double` | required | Minimum price |
| `maxAmount` | `double` | required | Maximum price |
| `style` | `TextStyle?` | `null` | Text style for amounts |
| `showDecimals` | `bool` | `false` | Show decimal places |
| `iconSize` | `double?` | auto | Symbol size |
| `iconColor` | `Color?` | auto | Symbol color |
| `symbolType` | `DirhamSymbolType` | `icon` | Type of symbol to display |

## Choosing the Right Symbol Type

### Use `DirhamSymbolType.icon` when:
- You want a unique, modern look
- Building a branded app
- Need full color customization
- Creating a premium feel

### Use `DirhamSymbolType.arabic` when:
- Targeting Arabic-speaking users
- Building apps for UAE/GCC market
- Need RTL (Right-to-Left) support
- Want authentic local representation

### Use `DirhamSymbolType.aed` when:
- Building international apps
- Need ISO currency code
- Creating financial/banking apps
- Want universal recognition

### Use `DirhamSymbolType.dh` when:
- Need a simplified display
- Building casual consumer apps
- Want minimal, clean look
- Space is limited

## Example App

The package includes a comprehensive example app showcasing all features. To run it:

```bash
git clone https://github.com/yourusername/dirham_symbol.git
cd dirham_symbol/example
flutter run
```

Or check the [example](example/) directory for the complete code.

## Requirements

- Flutter SDK: >=3.0.0
- Dart SDK: >=3.0.0 <4.0.0

## Dependencies

- `flutter_svg: ^2.0.0` - For rendering SVG graphics

## Migration Guide

### From 0.1.0 to 0.2.0

The `DirhamPrice` widget now includes a `symbolType` parameter:

```dart
// Before (0.1.0) - only SVG icon
DirhamPrice(amount: 150)

// After (0.2.0) - still works, SVG is default
DirhamPrice(amount: 150)

// New feature - use different symbol types
DirhamPrice(
  amount: 150,
  symbolType: DirhamSymbolType.arabic, // New!
)
```

All existing code remains compatible. The new `symbolType` parameter is optional with `DirhamSymbolType.icon` as the default.

## Tips & Best Practices

1. **Auto-sizing**: Let the icon size auto-calculate based on your text size for consistent appearance
2. **Color inheritance**: Don't specify `iconColor` to automatically inherit from your text style
3. **Decimals**: Use `showDecimals: true` for prices with cents, false for whole amounts
4. **Symbol choice**: Match your symbol type to your target audience and app context
5. **Consistency**: Stick to one symbol type throughout your app for a cohesive experience

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## Issues & Feedback

Found a bug or have a suggestion? Please file an issue on our [GitHub repository](https://github.com/yourusername/dirham_symbol/issues).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Created with ❤️ for the Flutter community

## Support

If you find this package helpful, please give it a ⭐ on [GitHub](https://github.com/yourusername/dirham_symbol) and like it on [pub.dev](https://pub.dev/packages/dirham_symbol)!

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a detailed version history.

---

**Keywords**: dirham, currency, uae, aed, arabic, symbol, price, formatter, flutter, widget