import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_project/screens/intro_screen.dart';

void main() {
  testWidgets('Intro screen', (WidgetTester tester) async {
    Widget widget = const IntroScreen();
    await tester.pumpWidget(
      MaterialApp(home: widget),
    );

    expect(find.byWidget(widget), findsOneWidget);
    expect(find.text("Selamat Datang"), findsOneWidget);
    // expect(find.text("NEXT"), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('next_button_key')));

    await tester.pumpAndSettle();

    expect(find.text("Materi Terbaru"), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('next_button_key')));

    await tester.pumpAndSettle();

    expect(find.text("Ayo Mulai"), findsOneWidget);
    expect(find.text("DONE"), findsOneWidget);
  });
}
