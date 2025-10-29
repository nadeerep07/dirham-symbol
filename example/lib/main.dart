import 'package:flutter/material.dart';
import 'package:dirham_symbol/dirham_symbol.dart';

/// Example app demonstrating all features of the dirham_symbol package:
/// - Adaptive theming (light/dark)
/// - Auto positioning (symbol before/after number)
/// - Inline text formatting
/// - Extensions for String and num
/// - Range and styled examples
void main() => runApp(const DirhamSymbolExampleApp());

class DirhamSymbolExampleApp extends StatefulWidget {
  const DirhamSymbolExampleApp({super.key});

  @override
  State<DirhamSymbolExampleApp> createState() => _DirhamSymbolExampleAppState();
}

class _DirhamSymbolExampleAppState extends State<DirhamSymbolExampleApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dirham Symbol Example',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: HomePage(
        themeMode: _themeMode,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  const HomePage({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dirham Symbol Example'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.light
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded,
            ),
            onPressed: onToggleTheme,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _header(isLight),
          const SizedBox(height: 30),

          _sectionTitle('💎 Basic Usage'),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DirhamIcon(size: 30),
              DirhamIcon(size: 50, color: Colors.green),
              DirhamIcon(size: 70, color: Colors.orange),
            ],
          ),
          const Divider(height: 40),

          _sectionTitle('💵 Price Display'),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DirhamPrice(amount: 150, symbolType: DirhamSymbolType.icon),
              DirhamPrice(amount: 150, symbolType: DirhamSymbolType.arabic),
              DirhamPrice(amount: 150, symbolType: DirhamSymbolType.aed),
            ],
          ),
          const Divider(height: 40),

          _extensionsSection(isLight),
          const Divider(height: 40),

          _inlineTextSection(isLight),
          const Divider(height: 40),

          _priceRangeSection(isLight),
          const Divider(height: 40),

          _autoPositionSection(isLight),
          const Divider(height: 40),

          _styledExamples(isLight),

          const SizedBox(height: 40),
          Center(
            child: Text(
              'Made with ❤️ for UAE Developers',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------
  // 🟣 Reusable UI Helpers
  // -------------------------------------------------
  static Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      );

  static Widget _header(bool isLight) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isLight
                ? [Colors.indigo.shade400, Colors.blue.shade700]
                : [Colors.indigo.shade700, Colors.blueGrey.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '💰 Dirham Symbol Kit',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Modern, theme-aware, and auto-positioned AED symbols for Flutter.',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      );

  // -------------------------------------------------
  // 🧩 Feature Sections
  // -------------------------------------------------

  static Widget _extensionsSection(bool isLight) => _decorated(
        color: Colors.purple,
        isLight: isLight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('✨ Extensions - Numeric & String Types',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                99.99.toDirham(showDecimals: true),
                250.toDirham(symbolType: DirhamSymbolType.arabic),
                "1000".toDirham(symbolType: DirhamSymbolType.aed),
              ],
            ),
          ],
        ),
      );

  static Widget _inlineTextSection(bool isLight) => _decorated(
        color: Colors.orange,
        isLight: isLight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('💬 Inline Text Examples',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            149.99.toDirhamText(
              prefix: 'Starting from',
              suffix: 'only!',
              symbolType: DirhamSymbolType.arabic,
              showDecimals: true,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            "299".toDirhamText(
              prefix: 'Limited offer:',
              suffix: 'today',
              symbolType: DirhamSymbolType.icon,
              style: const TextStyle(
                  fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      );

  static Widget _priceRangeSection(bool isLight) => _decorated(
        color: Colors.blue,
        isLight: isLight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('📊 Price Range Example',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            50.toDirhamRange(
              100,
              symbolType: DirhamSymbolType.arabic,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            "500".toDirhamRange(
              "1500",
              symbolType: DirhamSymbolType.aed,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      );

  static Widget _autoPositionSection(bool isLight) => _decorated(
        color: Colors.indigo,
        isLight: isLight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('🌍 Auto Positioning',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            99.toDirham(
              symbolType: DirhamSymbolType.aed,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            99.toDirham(
              symbolType: DirhamSymbolType.arabic,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );

  static Widget _styledExamples(bool isLight) => Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _priceCard('999', 'Premium', Colors.purple, isLight),
          _priceCard('499', 'Standard', Colors.blue, isLight),
          _priceCard('199', 'Basic', Colors.green, isLight),
        ],
      );

  // -------------------------------------------------
  // 🎨 Shared Decorations
  // -------------------------------------------------

  static Widget _decorated({
    required Color color,
    required bool isLight,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isLight
            ? color.withOpacity(0.05)
            : color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: child,
    );
  }

  static Widget _priceCard(
    String price,
    String label,
    Color color,
    bool isLight,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isLight
            ? color.withOpacity(0.1)
            : color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        children: [
          price.toDirham(
            symbolType: DirhamSymbolType.arabic,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isLight ? Colors.black54 : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
