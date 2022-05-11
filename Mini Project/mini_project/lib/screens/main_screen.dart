import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_project/constants/color.constant.dart';
import 'package:mini_project/widgets/fragments/feed_fragment.dart';
import 'package:mini_project/widgets/fragments/home_fragment.dart';
import 'package:mini_project/widgets/fragments/settings_fragment.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class BottomBar {
  IconData icon;
  IconData selectedIcon;
  String text;
  Widget child;
  BottomBar(
      {required this.icon, required this.text, required this.child, required this.selectedIcon});
}

class _MainScreenState extends State<MainScreen> {
  int _curPageIdx = 0;
  final List<BottomBar> pages = [
    BottomBar(
      icon: Icons.home_outlined,
      text: "Home",
      selectedIcon: Icons.home,
      child: const HomeFragment(),
    ),
    BottomBar(
      icon: Icons.feed_outlined,
      selectedIcon: Icons.feed,
      text: "Feed",
      child: const FeedFragment(),
    ),
    BottomBar(
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      text: "Settings",
      child: const SettingsFragment(),
    ),
  ];

  void onNavigateCreatePost() {
    Navigator.pushNamed(context, '/create-post');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: CustomColors.primary1,
      body: SafeArea(
        child: Stack(children: [
          Image.asset(
            'assets/images/main_header.png',
          ),
          pages[_curPageIdx].child
        ]),
      ),
      floatingActionButton: _curPageIdx == 1
          ? FloatingActionButton(
              onPressed: onNavigateCreatePost,
              backgroundColor: CustomColors.primary2,
              foregroundColor: Colors.white,
              child: const Icon(Icons.add),
            )
          : Container(),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.transparent,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 12, color: CustomColors.primary2),
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: CustomColors.primary4, width: 1.0))),
          child: NavigationBar(
            backgroundColor: CustomColors.primary1,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            selectedIndex: _curPageIdx,
            height: 60,
            onDestinationSelected: (newIdx) => setState(() => _curPageIdx = newIdx),
            destinations: pages
                .map((e) => NavigationDestination(
                      icon: Icon(
                        e.icon,
                        color: CustomColors.primary3,
                      ),
                      selectedIcon: Icon(
                        e.selectedIcon,
                        color: CustomColors.primary2,
                      ),
                      label: e.text,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
