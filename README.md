# Dirham Symbol

A Flutter package providing the Dirham currency symbol (د.إ) as a customizable SVG icon widget.

## Features

- High-quality SVG Dirham symbol
- Customizable size and color
- Easy to integrate
- Lightweight

## Installation

Add to your `pubspec.yaml`:
```yaml
dependencies:
  dirham_symbol: ^0.1.0
```

## Usage
```dart
import 'package:dirham_symbol/dirham_symbol.dart';

// Basic usage
DirhamIcon()

// Custom size
DirhamIcon(size: 50)

// Custom color
DirhamIcon(size: 30, color: Colors.green)

// In text
Row(
  children: [
    Text('Price: '),
    DirhamIcon(size: 20),
    Text(' 100'),
  ],
)
```

## License

MIT License
