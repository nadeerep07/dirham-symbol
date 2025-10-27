import 'package:flutter/material.dart';
import 'package:dirham_symbol/dirham_symbol.dart';
import 'package:google_fonts/google_fonts.dart';



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
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          'Dirham Symbol Showcase',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerSection(),
            const SizedBox(height: 24),

            _buildSection(
              title: 'Basic Dirham Icon',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  DirhamIcon(size: 24),
                  DirhamIcon(size: 50),
                  DirhamIcon(size: 80),
                ],
              ),
            ),

            _buildSection(
              title: 'Colored Icons',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  DirhamIcon(size: 40, color: Colors.red),
                  DirhamIcon(size: 40, color: Colors.green),
                  DirhamIcon(size: 40, color: Colors.blue),
                  DirhamIcon(size: 40, color: Colors.orange),
                  DirhamIcon(size: 40, color: Colors.purple),
                ],
              ),
            ),

            _buildSection(
              title: 'Different Symbol Types',
              child: Column(
                children: [
                  _symbolDemo('SVG Icon', DirhamSymbolType.icon, 'Modern custom design'),
                  _symbolDemo('Arabic (د.إ)', DirhamSymbolType.arabic, 'For Arabic / RTL apps'),
                  _symbolDemo('AED', DirhamSymbolType.aed, 'International standard'),
                  _symbolDemo('Dh', DirhamSymbolType.dh, 'Simplified display'),
                ],
              ),
            ),

            _buildSection(
              title: 'Price Comparison (Sale)',
              child: Row(
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
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(width: 10),
                  Chip(
                    label: Text(
                      '30% OFF',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.redAccent,
                  ),
                ],
              ),
            ),

            _buildSection(
              title: 'Product Cards',
              child: Column(
                children: [
                  _productCard('Premium Service', 500, 350, DirhamSymbolType.icon),
                  _productCard('Standard Package', 300, 250, DirhamSymbolType.arabic),
                  _productCard('Basic Plan', 150, 99, DirhamSymbolType.aed),
                ],
              ),
            ),

            _buildSection(
              title: 'Inline Price Text',
              child: Row(
                children: const [
                  Text('Starting from ', style: TextStyle(fontSize: 16)),
                  DirhamPrice(
                    amount: 99,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Text(' only!', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),

            const SizedBox(height: 40),
            Center(
              child: Text(
                'Made with ❤️ for UAE Pricing',
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Header Section
  Widget _headerSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4B6CB7), Color(0xFF182848)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '💰 Dirham Symbol Kit',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'A modern way to show prices in AED — icons, styles, and flexibility.',
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Reusable Modern Section
  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  // Symbol demo card
  Widget _symbolDemo(String label, DirhamSymbolType type, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  )),
              Text(desc,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey,
                  )),
            ],
          ),
          DirhamPrice(
            amount: 150,
            symbolBefore: type != DirhamSymbolType.arabic,
            symbolType: type,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Product card
  Widget _productCard(
    String title,
    double originalPrice,
    double discountPrice,
    DirhamSymbolType symbolType,
  ) {
    final discount = ((originalPrice - discountPrice) / originalPrice * 100).round();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  )),
              const SizedBox(height: 4),
              Text('Save $discount%',
                  style: GoogleFonts.poppins(
                    color: Colors.green,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
          // Right side
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DirhamPrice(
                amount: originalPrice,
                symbolBefore: symbolType != DirhamSymbolType.arabic,
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
                symbolBefore: symbolType != DirhamSymbolType.arabic,
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
    );
  }
}