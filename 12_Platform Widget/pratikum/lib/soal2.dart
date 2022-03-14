import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Soal2 extends StatelessWidget {
  Soal2({Key? key}) : super(key: key);

  final GlobalKey<NavigatorState> key1 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> key2 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> key3 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> key4 = GlobalKey<NavigatorState>();

  Widget handleTabBuilder({required int index, required BuildContext context}) {
    switch (index) {
      case 0:
        return CupertinoTabView(
            navigatorKey: key1,
            builder: (BuildContext context) => const Center(child: Text("Contacts")));
      case 1:
        return CupertinoTabView(
            navigatorKey: key2,
            builder: (BuildContext context) => const Center(child: Text("Calls")));
      case 2:
        return CupertinoTabView(
          navigatorKey: key3,
          builder: (BuildContext context) => const ChatScreen(),
        );
      default:
        return CupertinoTabView(
            navigatorKey: key4,
            builder: (BuildContext context) => const Center(child: Text("Settings")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      home: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            height: 60,
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.profile_circled), label: "Contacts"),
              const BottomNavigationBarItem(icon: Icon(CupertinoIcons.phone_fill), label: "Calls"),
              BottomNavigationBarItem(
                icon: Badge(
                  badgeContent: const Text(
                    "9",
                    style: TextStyle(color: CupertinoColors.white),
                  ),
                  child: const Icon(CupertinoIcons.chat_bubble_2_fill),
                ),
                label: "Chats",
              ),
              const BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: "Settings"),
            ],
          ),
          tabBuilder: (context, index) => handleTabBuilder(index: index, context: context)),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CupertinoColors.tertiarySystemGroupedBackground,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0.5,
          title: const Text('Chats',
              style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.black)),
          leading: Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: CupertinoColors.activeBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(
                CupertinoIcons.share,
                size: 24,
                color: CupertinoColors.activeBlue,
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size(0.0, 80.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: CupertinoSearchTextField(),
                ),
                TabBar(
                  isScrollable: true,
                  labelColor: CupertinoColors.activeBlue,
                  unselectedLabelColor: Colors.grey[500],
                  tabs: const [
                    CustomTabItem(title: "All Chats"),
                    CustomTabItem(
                      title: "Work",
                      showBadge: true,
                    ),
                    CustomTabItem(title: "Unread", showBadge: true),
                    CustomTabItem(title: "Personal", showBadge: true),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Text("bod"),
      ),
    );
  }
}

class CustomTabItem extends StatelessWidget {
  final String title;
  final bool showBadge;
  const CustomTabItem({Key? key, required this.title, this.showBadge = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontSize: 14)),
          const SizedBox(
            width: 4,
          ),
          Badge(
            position: BadgePosition.center(),
            badgeColor: Colors.blue,
            badgeContent: const Text(
              "2",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
