import 'package:flutter/material.dart';
import 'package:mini_project/helpers/providers/auth_manager.dart';
import 'package:mini_project/screens/intro_screen.dart';
import 'package:mini_project/screens/login_screen.dart';
import 'package:mini_project/screens/main_screen.dart';
import 'package:mini_project/screens/register_screen.dart';
import 'package:mini_project/services/services.dart';
import 'package:mini_project/view_models/login_view_model.dart';
import 'package:mini_project/view_models/register_view_model.dart';
import 'package:mini_project/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyProvider());
}

class MyProvider extends StatelessWidget {
  const MyProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => AuthManager()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthManager>(
      builder: (_, state, ___) => FutureBuilder<String?>(
        future: state.getToken(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Services.assignToken(snapshot.data); // update token
            return MaterialApp(
              title: 'Mini Project Jovin Lidan',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              routes: {
                '/': (context) => snapshot.data != null ? const MainScreen() : const IntroScreen(),
                '/register': (context) => const RegisterScreen(),
                '/login': (context) => const LoginScreen(),
                // '/main': (context) => const MainScreen(),
              },
              initialRoute: '/',
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
