import 'package:flutter/material.dart';
import 'package:mini_project/screens/course_detail_screen.dart';
import 'package:mini_project/screens/intro_screen.dart';
import 'package:mini_project/screens/login_screen.dart';
import 'package:mini_project/screens/main_screen.dart';
import 'package:mini_project/screens/register_screen.dart';
import 'package:mini_project/view_models/auth_view_model.dart';
import 'package:mini_project/view_models/carousel_view_model.dart';
import 'package:mini_project/view_models/course_view_model.dart';
import 'package:mini_project/view_models/courses_view_model.dart';
import 'package:mini_project/view_models/posts_view_model.dart';
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
        ChangeNotifierProvider(create: (_) => CoursesViewModel()),
        ChangeNotifierProvider(create: (_) => CourseViewModel()),
        ChangeNotifierProvider(create: (_) => PostsViewModel()),
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
    // return const MaterialApp(
    //   home: VideoPlayerWidget(),
    // );
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
                    // return const MaterialApp(home: Scaffold(body: HomeCourse()));
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
                      onGenerateRoute: (settings) {
                        if (settings.name == "/course-detail") {
                          final String id =
                              (settings.arguments ?? "626e792c055c8bad64bc2131") as String;
                          return MaterialPageRoute(
                              builder: (context) => CourseDetailScreen(id: id));
                        }
                        return null;
                      },
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
