import 'package:flutter/material.dart';
import 'package:dirham_symbol/dirham_symbol.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dirham Symbol Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dirham Symbol - All Features'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Basic Icon Usage
            _buildSectionTitle('1. Basic Dirham Icon (SVG)'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Column(
                  children: [
                    DirhamIcon(size: 24),
                    SizedBox(height: 5),
                    Text('Small (24)'),
                  ],
                ),
                Column(
                  children: [
                    DirhamIcon(size: 50),
                    SizedBox(height: 5),
                    Text('Medium (50)'),
                  ],
                ),
                Column(
                  children: [
                    DirhamIcon(size: 80),
                    SizedBox(height: 5),
                    Text('Large (80)'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Section 2: Colored Icons
            _buildSectionTitle('2. Colored Icons'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                DirhamIcon(size: 40, color: Colors.red),
                DirhamIcon(size: 40, color: Colors.green),
                DirhamIcon(size: 40, color: Colors.blue),
                DirhamIcon(size: 40, color: Colors.orange),
                DirhamIcon(size: 40, color: Colors.purple),
              ],
            ),
            const SizedBox(height: 30),

            // Section 3: Different Symbol Types
            _buildSectionTitle('3. Different Symbol Types'),
            const SizedBox(height: 10),
            _buildSymbolTypeDemo(
              'SVG Icon',
              DirhamSymbolType.icon,
              'Modern, custom design',
            ),
            const SizedBox(height: 10),
            _buildSymbolTypeDemo(
              'Arabic (د.إ)',
              DirhamSymbolType.arabic,
              'For Arabic/RTL apps',
            ),
            const SizedBox(height: 10),
            _buildSymbolTypeDemo(
              'AED',
              DirhamSymbolType.aed,
              'International standard',
            ),
            const SizedBox(height: 10),
            _buildSymbolTypeDemo(
              'Dh',
              DirhamSymbolType.dh,
              'Simplified display',
            ),
            const SizedBox(height: 30),

            // Section 4: Symbol Before/After
            _buildSectionTitle('4. Symbol Position'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Column(
                  children: [
                    DirhamPrice(
                      amount: 150,
                      symbolBefore: true,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 5),
                    Text('Symbol Before'),
                  ],
                ),
                Column(
                  children: [
                    DirhamPrice(
                      amount: 150,
                      symbolBefore: false,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 5),
                    Text('Symbol After'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Section 5: With/Without Decimals
            _buildSectionTitle('5. Decimal Options'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Column(
                  children: [
                    DirhamPrice(
                      amount: 99.99,
                      showDecimals: false,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 5),
                    Text('No Decimals'),
                  ],
                ),
                Column(
                  children: [
                    DirhamPrice(
                      amount: 99.99,
                      showDecimals: true,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 5),
                    Text('With Decimals'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Section 6: Strikethrough Price
            _buildSectionTitle('6. Strikethrough Price (Original Price)'),
            const SizedBox(height: 10),
            const DirhamPrice(
              amount: 500,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.grey,
                decorationThickness: 2,
              ),
            ),
            const SizedBox(height: 30),

            // Section 7: Price Comparison
            _buildSectionTitle('7. Price Comparison (Sale)'),
            const SizedBox(height: 10),
            Row(
              children: const [
                DirhamPrice(
                  amount: 500,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(width: 10),
                DirhamPrice(
                  amount: 350,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 10),
                Chip(
                  label: Text('30% OFF', style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Section 8: Price Range
            _buildSectionTitle('8. Price Range'),
            const SizedBox(height: 10),
            const DirhamPriceRange(
              minAmount: 50,
              maxAmount: 150,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            const DirhamPriceRange(
              minAmount: 99.99,
              maxAmount: 299.99,
              showDecimals: true,
              symbolType: DirhamSymbolType.arabic,
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
            const SizedBox(height: 30),

            // Section 9: All Symbol Types with Prices
            _buildSectionTitle('9. Same Price, Different Symbols'),
            const SizedBox(height: 10),
            _buildPriceRow('SVG Icon', 250, DirhamSymbolType.icon),
            _buildPriceRow('Arabic', 250, DirhamSymbolType.arabic),
            _buildPriceRow('AED', 250, DirhamSymbolType.aed),
            _buildPriceRow('Dh', 250, DirhamSymbolType.dh),
            const SizedBox(height: 30),

            // Section 10: Product Cards
            _buildSectionTitle('10. Product Card Examples'),
            const SizedBox(height: 10),
            _buildProductCard(
              title: 
              'Premium Service',
              originalPrice: 500,
              discountPrice: 350,
              symbolType: DirhamSymbolType.icon,
            ),
            const SizedBox(height: 10),
            _buildProductCard(
            title:   'Standard Package',
              originalPrice: 300,
              discountPrice: 250,
              symbolType: DirhamSymbolType.arabic,
            ),
            const SizedBox(height: 10),
            _buildProductCard(
            title:   'Basic Plan',
              originalPrice: 150,
              discountPrice: 99,
              symbolType: DirhamSymbolType.aed,
            ),
            const SizedBox(height: 30),

            // Section 11: Inline with Text
            _buildSectionTitle('11. Inline with Text'),
            const SizedBox(height: 10),
            Row(
              children: const [
                Text('Starting from ', style: TextStyle(fontSize: 16)),
                DirhamPrice(
                  amount: 99,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Text(' only!', style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Text('Pay just ', style: TextStyle(fontSize: 16)),
                DirhamPrice(
                  amount: 49.99,
                  showDecimals: true,
                  symbolType: DirhamSymbolType.arabic,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(' per month', style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 30),

            // Section 12: Various Text Styles
            _buildSectionTitle('12. Various Text Styles'),
            const SizedBox(height: 10),
            const DirhamPrice(
              amount: 199,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            const DirhamPrice(
              amount: 49.99,
              showDecimals: true,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Colors.teal,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 10),
            const DirhamPrice(
              amount: 999,
              symbolType: DirhamSymbolType.aed,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 30),

            // Section 13: Mixed Symbol Types in Cards
            _buildSectionTitle('13. Comparison Table'),
            const SizedBox(height: 10),
            _buildComparisonTable(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildSymbolTypeDemo(
    String label,
    DirhamSymbolType type,
    String description,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            DirhamPrice(
              amount: 150,
              symbolType: type,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, DirhamSymbolType type) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          DirhamPrice(
            amount: amount,
            symbolType: type,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard({
    required String title,
    required double originalPrice,
    required double discountPrice,
    required DirhamSymbolType symbolType,
  }) {
    final discount =
        ((originalPrice - discountPrice) / originalPrice * 100).round();

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Save $discount%',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DirhamPrice(
                  amount: originalPrice,
                  symbolType: symbolType,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(height: 4),
                DirhamPrice(
                  amount: discountPrice,
                  symbolType: symbolType,
                  style: const TextStyle(
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
    );
  }

  Widget _buildComparisonTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.blue.shade50),
          children: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Symbol Type',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Display',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        _buildTableRow('SVG Icon', 199, DirhamSymbolType.icon),
        _buildTableRow('Arabic', 199, DirhamSymbolType.arabic),
        _buildTableRow('AED', 199, DirhamSymbolType.aed),
        _buildTableRow('Dh', 199, DirhamSymbolType.dh),
      ],
    );
  }

  TableRow _buildTableRow(String label, double amount, DirhamSymbolType type) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(label),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: DirhamPrice(
            amount: amount,
            symbolType: type,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}