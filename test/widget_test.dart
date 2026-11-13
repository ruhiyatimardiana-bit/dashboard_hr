import 'package:flutter_test/flutter_test.dart';
import 'package:dashboard_hr/main.dart';

void main() {
  testWidgets('Dashboard HR berhasil ditampilkan', (WidgetTester tester) async {
    await tester.pumpWidget(const AplikasiHR());

    expect(find.text('PT Maju Bersama'), findsOneWidget);
  });
}
