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
      margin: const EdgeInsets.only(top: 72),
      decoration: const BoxDecoration(
        // border: Border.all(color: CustomColors.primary3, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        // color: CustomColors.primary1,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Consumer<UserViewModel>(
        builder: (_, state, __) => Row(
          children: [
            // Container(
            //   width: 48,
            //   height: 48,
            //   decoration: const BoxDecoration(
            //     borderRadius: BorderRadius.all(
            //       Radius.circular(8),
            //     ),
            //     color: CustomColors.primary2,
            //   ),
            // ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Selamat Datang!",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Text(state.user?.data?.firstName ?? "Guest",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal, fontSize: 20)),
              ],
            )
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}
