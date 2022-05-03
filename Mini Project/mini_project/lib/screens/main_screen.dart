import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      child: const Text("Test"),
    ),
    BottomBar(
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      text: "Settings",
      child: const SettingsFragment(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 29, 105, 1),
      body: SafeArea(
        child: Stack(children: [
          Image.asset(
            'assets/images/main_header.png',
          ),
          pages[_curPageIdx].child
        ]),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.transparent,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 12, color: Color.fromRGBO(142, 151, 253, 1)),
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color.fromARGB(255, 17, 75, 223), width: 1.0))),
          child: NavigationBar(
            backgroundColor: const Color.fromRGBO(0, 29, 105, 1),
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            selectedIndex: _curPageIdx,
            height: 60,
            onDestinationSelected: (newIdx) => setState(() => _curPageIdx = newIdx),
            destinations: pages
                .map((e) => NavigationDestination(
                      icon: Icon(
                        e.icon,
                        color: const Color.fromRGBO(81, 89, 121, 1),
                      ),
                      selectedIcon: Icon(
                        e.selectedIcon,
                        color: const Color.fromRGBO(142, 151, 253, 1),
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
