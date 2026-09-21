import 'package:flutter_test/flutter_test.dart';
import 'package:tensio/main.dart';

void main() {
  testWidgets('Tensio launches into the dashboard', (tester) async {
    await tester.pumpWidget(const TensioApp());
    await tester.pumpAndSettle();

    expect(find.text('Tensio'), findsOneWidget);
    expect(find.text('Son ölçüm'), findsOneWidget);
    expect(find.text('Yeni ölçüm'), findsOneWidget);
  });
}
