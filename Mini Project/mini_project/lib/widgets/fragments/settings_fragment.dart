import 'package:flutter/material.dart';
import 'package:mini_project/helpers/providers/auth_manager.dart';
import 'package:mini_project/widgets/components/setting_tile.dart';
import 'package:provider/provider.dart';

class SettingsFragment extends StatefulWidget {
  const SettingsFragment({Key? key}) : super(key: key);

  @override
  State<SettingsFragment> createState() => _SettingsFragmentState();
}

class _SettingsFragmentState extends State<SettingsFragment> {
  void handleLogout() async {
    await Provider.of<AuthManager>(context, listen: false).revokeToken();
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.blue[900],
              radius: 40,
            ),
          ),
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Settings",
              style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 40),
          SettingTile(
            text: "Logout",
            icon: Icons.logout_outlined,
            onTap: handleLogout,
          ),
        ],
      ),
    );
  }
}
