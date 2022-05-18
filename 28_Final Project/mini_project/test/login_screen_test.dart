import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_project/screens/login_screen.dart';
import 'package:mini_project/view_models/auth_view_model.dart';
import 'package:mini_project/view_models/token_view_model.dart';
import 'package:mini_project/view_models/user_view_model.dart';

import 'package:provider/provider.dart';

void main() {
  testWidgets('Login screen', (WidgetTester tester) async {
    Widget login = const LoginScreen();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider(create: (_) => UserViewModel()),
          ChangeNotifierProvider(create: (_) => TokenViewModel()),
        ],
        child: MaterialApp(
          home: login,
        ),
      ),
    );

    expect(find.byWidget(login), findsOneWidget);
    expect(find.text("Masuk"), findsWidgets);
    expect(find.text("Ayo mulai kursusmu hari ini"), findsOneWidget);
    expect(find.text("Masuk Sekarang"), findsOneWidget);

    expect(find.byWidgetPredicate((widget) => widget is TextFormField), findsWidgets);
    expect(find.byWidgetPredicate((widget) => widget is Icon), findsWidgets);

    expect(find.text("Belum Punya Akun? Daftar"), findsOneWidget);

    expect(find.text("Email"), findsOneWidget);
    expect(find.text("Kata Sandi"), findsOneWidget);
  });
}
