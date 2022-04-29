import 'package:flutter/material.dart';
import 'package:mini_project/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeProfile extends StatefulWidget {
  const HomeProfile({Key? key}) : super(key: key);

  @override
  State<HomeProfile> createState() => _HomeProfileState();
}

class _HomeProfileState extends State<HomeProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: Color.fromRGBO(0, 99, 178, 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Consumer<UserViewModel>(
        builder: (_, state, __) => Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                color: Color.fromRGBO(156, 195, 213, 1),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.user?.data?.firstName ?? "Guest",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16)),
                const Text(
                  "Selamat Datang!",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            )
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}