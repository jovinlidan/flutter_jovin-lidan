import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pratikum/badge.dart';

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
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.profile_circled), label: "Contacts"),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.phone_fill), label: "Calls"),
              BottomNavigationBarItem(
                icon: CustomBadges(
                  color: Colors.red,
                  size: 20,
                  child: Text(
                    "9",
                    style: TextStyle(color: CupertinoColors.white, fontSize: 14),
                  ),
                  parent: Icon(CupertinoIcons.chat_bubble_2_fill),
                ),
                label: "Chats",
              ),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: "Settings"),
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
            centerTitle: true,
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
                      fontSize: 16,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CupertinoSearchTextField(
                        prefixInsets: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 2.7,
                    )),
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
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    CustomChat(),
                    CustomChat(),
                    CustomChat(),
                    CustomChat(),
                    CustomChat(),
                    CustomChat(),
                    CustomChat(),
                    CustomChat(),
                    CustomChat(),
                    CustomChat(),
                    CustomChat(),
                  ],
                ),
              ),
            ),
          )),
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
          showBadge
              ? const CustomBadges(
                  color: Colors.blue,
                  child: Text(
                    "2",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.white),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class CustomChat extends StatelessWidget {
  const CustomChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Divider(height: 0, thickness: 0, color: Colors.white),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Reading Week',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                    Text('18:00', style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hudison',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Check this, check this out',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    const CustomBadges(
                      child: Text("8", style: TextStyle(color: Colors.white, fontSize: 12)),
                      color: Colors.blue,
                      size: 20,
                    )
                  ],
                ),
                const Divider(height: 0, thickness: 1.5),
              ],
            ),
          )
        ],
      ),
    );
  }
}
