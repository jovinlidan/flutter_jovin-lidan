import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            navigatorKey: key1, builder: (BuildContext context) => Center(child: Text("Contacts")));
      case 1:
        return CupertinoTabView(
            navigatorKey: key2, builder: (BuildContext context) => Center(child: Text("Calls")));
      case 2:
        return CupertinoTabView(
          navigatorKey: key3,
          builder: (BuildContext context) => ChatScreen(),
        );
      default:
        return CupertinoTabView(
            navigatorKey: key4, builder: (BuildContext context) => Center(child: Text("Settings")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            height: 60,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.profile_circled), label: "Contacts"),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.phone_fill), label: "Calls"),
              BottomNavigationBarItem(
                icon: Badge(
                  badgeContent: Text(
                    "9",
                    style: TextStyle(color: CupertinoColors.white),
                  ),
                  child: Icon(CupertinoIcons.chat_bubble_2_fill),
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
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Chats', style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(CupertinoIcons.share, size: 24),
        leading: Row(
          children: const [
            Text(
              'Edit',
              style: TextStyle(
                color: CupertinoColors.activeBlue,
              ),
            ),
          ],
        ),
        border: Border.all(width: 0.0, color: CupertinoColors.white),
      ),
      child: CustomScrollView(
        anchor: 1.0,
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
              middle: Column(
                children: [
                  CupertinoSearchTextField(),
                ],
              ),
              largeTitle: Row(
                children: [
                  Text("All Chats", style: TextStyle(fontSize: 10)),
                  Text("All Chats"),
                  Text("All Chats"),
                  Text("All Chats"),
                ],
              )),
        ],
      ),
    );
  }
}
