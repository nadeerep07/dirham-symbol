import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';

void main() {
  testWidgets('Example app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DirhamExampleApp());
    expect(find.text('Dirham Symbol Suite'), findsOneWidget);
    expect(find.text('🌟 Official Dirham Icon & Symbols'), findsOneWidget);
  });
}
