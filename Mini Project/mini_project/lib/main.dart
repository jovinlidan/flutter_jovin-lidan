import 'package:flutter/material.dart';
import 'package:mini_project/screens/intro_screen.dart';
import 'package:mini_project/screens/login_screen.dart';
import 'package:mini_project/screens/main_screen.dart';
import 'package:mini_project/screens/register_screen.dart';
import 'package:mini_project/view_models/auth_view_model.dart';
import 'package:mini_project/view_models/carousel_view_model.dart';
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
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CarouselViewModel()),
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
    return Consumer<AuthViewModel>(
      builder: (_, state, ___) => FutureBuilder(
        future: state.setupToken(),
        builder: (_, tokenSnapshot) {
          if (tokenSnapshot.connectionState == ConnectionState.done) {
            return Consumer<UserViewModel>(
              builder: (_, state, __) => FutureBuilder(
                future: state.getMe(),
                builder: (_, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.done) {
                    return MaterialApp(
                      title: 'Mini Project Jovin Lidan',
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(
                        primarySwatch: Colors.blue,
                      ),
                      routes: {
                        '/': (context) =>
                            tokenSnapshot.data != null ? const MainScreen() : const IntroScreen(),
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
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
