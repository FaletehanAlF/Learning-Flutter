import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:belajar_flutter/main.dart';

void main() {
  testWidgets('login page renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Login to your account'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('submit'), findsOneWidget);
  });
}
