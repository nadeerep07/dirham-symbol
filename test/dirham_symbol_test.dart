import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dirham_symbol/dirham_symbol.dart';

void main() {
  group('DirhamIcon & DirhamVectorIcon', () {
    testWidgets('DirhamIcon renders with default size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DirhamIcon(),
          ),
        ),
      );
      expect(find.byType(DirhamIcon), findsOneWidget);
    });

    testWidgets('DirhamIcon renders with custom size and color', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DirhamIcon(size: 48, color: Colors.green),
          ),
        ),
      );
      expect(find.byType(DirhamIcon), findsOneWidget);
    });

    testWidgets('DirhamVectorIcon renders with CustomPaint', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DirhamVectorIcon(size: 32, color: Colors.indigo),
          ),
        ),
      );
      expect(find.byType(DirhamVectorIcon), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(DirhamVectorIcon),
          matching: find.byType(CustomPaint),
        ),
        findsOneWidget,
      );
    });
  });

  group('DirhamSymbol & DirhamPrice Widgets', () {
    testWidgets('DirhamSymbol renders different types correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                DirhamSymbol(type: DirhamSymbolType.icon),
                DirhamSymbol(type: DirhamSymbolType.arabic),
                DirhamSymbol(type: DirhamSymbolType.aed),
                DirhamSymbol(type: DirhamSymbolType.dh),
              ],
            ),
          ),
        ),
      );

      expect(find.text('د.إ'), findsOneWidget);
      expect(find.text('AED'), findsOneWidget);
      expect(find.text('Dh'), findsOneWidget);
      expect(find.byType(DirhamIcon), findsOneWidget);
    });

    testWidgets('DirhamPrice displays amount and symbol', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DirhamPrice(
              amount: 150.75,
              showDecimals: true,
              symbolType: DirhamSymbolType.arabic,
            ),
          ),
        ),
      );

      expect(find.text('150.75'), findsOneWidget);
      expect(find.text('د.إ'), findsOneWidget);
    });

    testWidgets('DirhamPriceRange displays range correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DirhamPriceRange(
              minAmount: 50,
              maxAmount: 100,
              symbolType: DirhamSymbolType.aed,
            ),
          ),
        ),
      );

      expect(find.text('50'), findsOneWidget);
      expect(find.text('100'), findsOneWidget);
      expect(find.text('-'), findsOneWidget);
    });

    testWidgets('InlineDirhamText displays text with price', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InlineDirhamText(
              prefix: 'Starting from',
              amount: 99,
              suffix: 'only',
              symbolType: DirhamSymbolType.arabic,
            ),
          ),
        ),
      );

      expect(find.byType(InlineDirhamText), findsOneWidget);
      expect(find.text('د.إ'), findsOneWidget);
    });
  });

  group('DirhamTheme Inheritance', () {
    testWidgets('DirhamTheme provides default settings to descendant widgets', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DirhamTheme(
            data: const DirhamThemeData(
              symbolType: DirhamSymbolType.arabic,
              showDecimals: true,
              spacing: 8.0,
            ),
            child: Scaffold(
              body: 250.toDirham(),
            ),
          ),
        ),
      );

      // Decimals and arabic symbol should be shown as configured in theme
      expect(find.text('250.00'), findsOneWidget);
      expect(find.text('د.إ'), findsOneWidget);
    });
  });

  group('DirhamFormatter & Conversions', () {
    test('format produces clean strings', () {
      expect(DirhamFormatter.format(1500, symbolType: DirhamSymbolType.aed), 'AED 1,500');
      expect(
        DirhamFormatter.format(1500.5, symbolType: DirhamSymbolType.arabic, showDecimals: true),
        '1,500.50 د.إ',
      );
      expect(
        DirhamFormatter.format(99.9, symbolType: DirhamSymbolType.dh, showDecimals: true),
        'Dh 99.90',
      );
    });

    test('formatCompact formats large numbers', () {
      expect(DirhamFormatter.formatCompact(1500), 'AED 1.5K');
      expect(DirhamFormatter.formatCompact(2500000), 'AED 2.5M');
      expect(DirhamFormatter.formatCompact(1200000000), 'AED 1.2B');
    });

    test('Fils conversions work accurately', () {
      expect(DirhamFormatter.toFils(10.50), 1050);
      expect(DirhamFormatter.fromFils(1050), 10.50);
      expect(DirhamFormatter.formatFils(2500), 'AED 25.00');
      expect(15.toFils(), 1500);
      expect(2500.filsToDirham(), 25.0);
      expect(2500.filsToDirhamString(), 'AED 25.00');
    });

    test('Eastern Arabic numerals formatting', () {
      final arabicText = DirhamFormatter.toEasternArabic('12345');
      expect(arabicText, '١٢٣٤٥');

      final formattedArabic = DirhamFormatter.format(
        1500,
        symbolType: DirhamSymbolType.arabic,
        useEasternArabicNumerals: true,
      );
      expect(formattedArabic.contains('١'), isTrue);
    });

    test('parseAmount extracts numbers from dirty strings', () {
      expect(DirhamFormatter.parseAmount('AED 1,250.50'), 1250.50);
      expect(DirhamFormatter.parseAmount('500 د.إ'), 500.0);
      expect(DirhamFormatter.parseAmount('١٢٣٫٤٥'), 123.45);
      expect('AED 99.99'.cleanDirhamAmount(), 99.99);
    });
  });

  group('DirhamSalePrice & DirhamBadge Widgets', () {
    testWidgets('DirhamSalePrice calculates discount and shows badge', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DirhamSalePrice(
              originalAmount: 200,
              saleAmount: 150,
              badgeType: DirhamDiscountBadgeType.percentage,
            ),
          ),
        ),
      );

      expect(find.text('-25%'), findsOneWidget);
      expect(find.text('150'), findsOneWidget);
      expect(find.text('200'), findsOneWidget);
    });

    testWidgets('DirhamBadge renders with prefix and suffix', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DirhamBadge(
              amount: 50,
              prefix: 'Min.',
              suffix: 'only',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.text('Min.'), findsOneWidget);
      expect(find.text('only'), findsOneWidget);
      expect(find.text('50'), findsOneWidget);

      await tester.tap(find.byType(DirhamBadge));
      expect(tapped, isTrue);
    });
  });

  group('AnimatedDirhamPrice Widget', () {
    testWidgets('AnimatedDirhamPrice animates amount changes', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimatedDirhamPrice(
              amount: 100,
              duration: Duration(milliseconds: 300),
            ),
          ),
        ),
      );

      expect(find.byType(AnimatedDirhamPrice), findsOneWidget);
      await tester.pumpAndSettle();
    });
  });

  group('DirhamInputFormatter & DirhamTextField', () {
    test('DirhamInputFormatter formats numeric input with commas', () {
      final formatter = DirhamInputFormatter(decimalDigits: 2);
      const oldValue = TextEditingValue(text: '');
      const newValue = TextEditingValue(
        text: '1234567.89',
        selection: TextSelection.collapsed(offset: 10),
      );

      final result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '1,234,567.89');
    });

    testWidgets('DirhamTextField handles user typing and validation', (tester) async {
      double? changedAmount;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DirhamTextField(
              initialAmount: 50.0,
              showClearButton: true,
              onAmountChanged: (val) => changedAmount = val,
            ),
          ),
        ),
      );

      expect(find.byType(DirhamTextField), findsOneWidget);
      expect(find.text('50.00'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), '1500');
      await tester.pump();

      expect(changedAmount, 1500.0);
    });
  });

  group('Extensions on num and String', () {
    test('String formatting extensions', () {
      expect(150.toDirhamString(symbolType: DirhamSymbolType.aed), 'AED 150');
      expect(1500000.toDirhamCompact(), 'AED 1.5M');
      expect('1250'.toDirhamString(symbolType: DirhamSymbolType.arabic), '1,250 د.إ');
      expect('2500000'.toDirhamCompact(), 'AED 2.5M');
    });

    testWidgets('Widget extensions render correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                100.toDirham(),
                99.99.toDirhamText(prefix: 'From'),
                50.toDirhamRange(100),
                200.toDirhamSale(150),
                500.toDirhamAnimated(),
                25.toDirhamBadge(prefix: 'Cashback'),
                '75'.toDirham(),
                '120'.toDirhamText(suffix: 'per day'),
                '50'.toDirhamRange('100'),
                1500.filsToDirhamWidget(),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(DirhamPrice), findsWidgets);
      expect(find.byType(DirhamSalePrice), findsOneWidget);
      expect(find.byType(DirhamBadge), findsOneWidget);
      expect(find.byType(AnimatedDirhamPrice), findsOneWidget);
    });
  });
}
