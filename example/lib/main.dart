import 'package:flutter/material.dart';
import 'package:dirham_symbol/dirham_symbol.dart';

void main() => runApp(const DirhamExampleApp());

class DirhamExampleApp extends StatefulWidget {
  const DirhamExampleApp({super.key});

  @override
  State<DirhamExampleApp> createState() => _DirhamExampleAppState();
}

class _DirhamExampleAppState extends State<DirhamExampleApp> {
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
        colorSchemeSeed: const Color(0xFF007A3D),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF007A3D),
        brightness: Brightness.dark,
      ),
      home: ExampleHomePage(
        isDarkMode: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class ExampleHomePage extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const ExampleHomePage({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DirhamIcon(size: 24, color: Color(0xFF007A3D)),
            SizedBox(width: 8),
            Text('Dirham Symbol Suite', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
            onPressed: onToggleTheme,
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 1. Official UAE Symbols
          _section(
            '🌟 Official Dirham Icon & Symbols',
            const Wrap(
              spacing: 16,
              runSpacing: 12,
              alignment: WrapAlignment.spaceEvenly,
              children: [
                Column(children: [DirhamIcon(size: 36, color: Color(0xFF007A3D)), SizedBox(height: 4), Text('Official Font', style: TextStyle(fontSize: 11))]),
                Column(children: [DirhamIcon(size: 36, color: Color(0xFFC8102E)), SizedBox(height: 4), Text('Tinted Red', style: TextStyle(fontSize: 11))]),
                Column(children: [DirhamSymbol(type: DirhamSymbolType.arabic, size: 24), SizedBox(height: 4), Text('Arabic (د.إ)', style: TextStyle(fontSize: 11))]),
                Column(children: [DirhamSymbol(type: DirhamSymbolType.aed, size: 20), SizedBox(height: 4), Text('AED Code', style: TextStyle(fontSize: 11))]),
                Column(children: [DirhamSymbol(type: DirhamSymbolType.dh, size: 20), SizedBox(height: 4), Text('Dh Short', style: TextStyle(fontSize: 11))]),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // 2. Extensions (.toDirham())
          _section(
            '⚡ Extension Methods',
            Column(
              children: [
                _row('99.99.toDirham()', 99.99.toDirham(showDecimals: true)),
                const Divider(),
                _row('"1500".toDirham(arabic)', "1500".toDirham(symbolType: DirhamSymbolType.arabic)),
                const Divider(),
                _row('50.toDirhamRange(150)', 50.toDirhamRange(150)),
                const Divider(),
                _row('Inline text', 149.toDirhamText(prefix: 'From', suffix: 'only!')),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // 3. E-Commerce Sale Prices & Badges
          _section(
            '🛍️ E-Commerce Sale Prices & Badges',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _row('299.toDirhamSale(199)', 299.toDirhamSale(199)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    DirhamBadge(amount: 100, prefix: 'Free delivery over', backgroundColor: Colors.green.shade50, textColor: Colors.green.shade900),
                    DirhamBadge(amount: 25, prefix: 'Cashback:', backgroundColor: Colors.amber.shade50, textColor: Colors.amber.shade900),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // 4. FinTech Currency Input & Formats
          _section(
            '💳 Currency Input & String Utilities',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DirhamTextField(
                  initialAmount: 2500.0,
                  showClearButton: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Transfer Amount',
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 12),
                _row('Pure String:', Text(1500.toDirhamString())),
                const Divider(),
                _row('Compact (2.5M AED):', Text(2500000.toDirhamCompact())),
                const Divider(),
                _row('5000 Fils to AED:', Text(5000.filsToDirhamString())),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _section(String title, Widget content) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.black12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 12),
            content,
          ],
        ),
      ),
    );
  }

  static Widget _row(String label, Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey))),
          const SizedBox(width: 8),
          child,
        ],
      ),
    );
  }
}
