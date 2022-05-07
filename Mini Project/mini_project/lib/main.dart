import 'package:flutter/material.dart';
import 'package:mini_project/screens/course_detail_screen.dart';
import 'package:mini_project/screens/create_post_screen.dart';
import 'package:mini_project/screens/intro_screen.dart';
import 'package:mini_project/screens/login_screen.dart';
import 'package:mini_project/screens/main_screen.dart';
import 'package:mini_project/screens/post_detail_screen.dart';
import 'package:mini_project/screens/register_screen.dart';
import 'package:mini_project/screens/splash_screen.dart';
import 'package:mini_project/view_models/auth_view_model.dart';
import 'package:mini_project/view_models/carousel_view_model.dart';
import 'package:mini_project/view_models/course_view_model.dart';
import 'package:mini_project/view_models/courses_view_model.dart';
import 'package:mini_project/view_models/create_post_comment_view_model.dart';
import 'package:mini_project/view_models/create_post_view_model.dart';
import 'package:mini_project/view_models/delete_post_view_model.dart';
import 'package:mini_project/view_models/post_comments_view_model.dart';
import 'package:mini_project/view_models/post_view_model.dart';
import 'package:mini_project/view_models/posts_view_model.dart';
import 'package:mini_project/view_models/token_view_model.dart';
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
        ChangeNotifierProvider(create: (_) => TokenViewModel()),
        ChangeNotifierProvider(create: (_) => CreatePostViewModel()),
        ChangeNotifierProvider(create: (_) => PostViewModel()),
        ChangeNotifierProvider(create: (_) => PostCommentsViewModel()),
        ChangeNotifierProvider(create: (_) => CreatePostCommentViewModel()),
        ChangeNotifierProvider(create: (_) => DeletePostViewModel()),
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
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/course-detail":
        final String id = (settings.arguments ?? "626e792c055c8bad64bc2131") as String;
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => CourseDetailScreen(id: id),
          transitionsBuilder: (_, animation, __, child) {
            final tween = Tween(begin: const Offset(1, 1), end: Offset.zero);
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case "/post-detail":
        final String id = (settings.arguments ?? "626e792c055c8bad64bc2131") as String;
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => PostDetailScreen(id: id),
          transitionsBuilder: (_, animation, __, child) {
            final tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
    }
    return null;
  }

  Widget getInitialPage(
      {required AsyncSnapshot<Object?> tokenSnapshot,
      required AsyncSnapshot<Object?> userSnapshot}) {
    if (userSnapshot.connectionState == ConnectionState.waiting ||
        tokenSnapshot.connectionState == ConnectionState.waiting) {
      return const SplashScreen();
    }
    if (tokenSnapshot.data != null) return const MainScreen();
    return const IntroScreen();
  }

  @override
  Widget build(BuildContext context) {
    // return const MaterialApp(
    //   home: VideoPlayerWidget(),
    // );
    return Consumer<TokenViewModel>(
      builder: (_, state, ___) => FutureBuilder(
        future: state.setupToken(),
        builder: (_, tokenSnapshot) {
          return Consumer<UserViewModel>(
            builder: (_, state, __) => FutureBuilder(
              future: state.getMe(),
              builder: (_, userSnapshot) {
                // return const MaterialApp(home: Scaffold(body: HomeCourse()));
                return MaterialApp(
                  title: 'Mini Project Jovin Lidan',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  routes: {
                    // '/': (context) => userSnapshot.connectionState == ConnectionState.waiting
                    //     ? const MainScreen()
                    //     : const IntroScreen(),
                    '/register': (context) => const RegisterScreen(),
                    '/login': (context) => const LoginScreen(),
                    '/create-post': (context) => const CreatePostScreen()
                  },

                  home: getInitialPage(tokenSnapshot: tokenSnapshot, userSnapshot: userSnapshot),
                  // initialRoute: '/',
                  onGenerateRoute: onGenerateRoute,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
