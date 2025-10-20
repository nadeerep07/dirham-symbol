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
        title: const Text('Dirham Symbol Examples'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Basic Icon Usage
            _buildSectionTitle('1. Basic Dirham Icon'),
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

            // Section 3: DirhamPrice Widget
            _buildSectionTitle('3. Dirham Price (Symbol Before)'),
            const SizedBox(height: 10),
            const DirhamPrice(
              amount: 150,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const DirhamPrice(
              amount: 99.99,
              showDecimals: true,
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 30),

            // Section 4: Symbol After Amount
            _buildSectionTitle('4. Dirham Price (Symbol After)'),
            const SizedBox(height: 10),
            const DirhamPrice(
              amount: 250,
              symbolBefore: false,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Section 5: Strikethrough Price
            _buildSectionTitle('5. Strikethrough Price (Original Price)'),
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

            // Section 6: Price Comparison
            _buildSectionTitle('6. Price Comparison'),
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
              ],
            ),
            const SizedBox(height: 30),

            // Section 7: Price Range
            _buildSectionTitle('7. Price Range'),
            const SizedBox(height: 10),
            const DirhamPriceRange(
              minAmount: 50,
              maxAmount: 150,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),

            // Section 8: Custom Card Examples
            _buildSectionTitle('8. Product Card Examples'),
            const SizedBox(height: 10),
            // _buildProductCard(
            //   'Premium Service',
            //   originalPrice: 500,
            //   discountPrice: 350,
            // ),
            const SizedBox(height: 10),
            // _buildProductCard(
            //   'Standard Package',
            //   originalPrice: 300,
            //   discountPrice: 250,
            // ),
            const SizedBox(height: 30),

            // Section 9: In Text Usage
            _buildSectionTitle('9. Inline with Text'),
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
            const SizedBox(height: 30),

            // Section 10: Different Text Styles
            _buildSectionTitle('10. Various Text Styles'),
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

  Widget _buildProductCard({
    required String title,
    required double originalPrice,
    required double discountPrice,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DirhamPrice(
                  amount: originalPrice,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(height: 4),
                DirhamPrice(
                  amount: discountPrice,
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
}