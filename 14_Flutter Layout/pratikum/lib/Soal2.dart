import 'package:flutter/material.dart';

class Soal2 extends StatelessWidget {
  const Soal2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title:
              const Text("GridView", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          centerTitle: false,
        ),
        body: const CustomGridView(),
      ),
    );
  }
}

class CustomGridView extends StatelessWidget {
  final List<Widget> datas = const [
    Icon(Icons.pets, color: Colors.white),
    Icon(Icons.person, color: Colors.white),
    Icon(Icons.account_balance_rounded, color: Colors.white),
    Icon(Icons.aspect_ratio, color: Colors.white),
    Icon(Icons.assured_workload, color: Colors.white),
    Icon(Icons.add_link_outlined, color: Colors.white),
    Icon(Icons.airport_shuttle_outlined, color: Colors.white),
    Icon(Icons.air, color: Colors.white),
    Icon(Icons.airline_seat_recline_extra_rounded, color: Colors.white),
    Icon(Icons.arrow_circle_down, color: Colors.white),
    Icon(Icons.archive_sharp, color: Colors.white),
    Icon(Icons.add_task_sharp, color: Colors.white),
    Icon(Icons.auto_awesome_mosaic_outlined, color: Colors.white),
    Icon(Icons.blur_circular_sharp, color: Colors.white),
    Icon(Icons.autofps_select_outlined, color: Colors.white),
    Icon(Icons.bedroom_parent_rounded, color: Colors.white),
    Icon(Icons.calendar_view_month_sharp, color: Colors.white),
    Icon(Icons.calendar_today_rounded, color: Colors.white),
    Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
    Icon(Icons.brightness_7_rounded, color: Colors.white),
    Icon(Icons.cast_rounded, color: Colors.white),
    Icon(Icons.cast_connected_outlined, color: Colors.white),
    Icon(Icons.cable_rounded, color: Colors.white),
    Icon(Icons.zoom_in, color: Colors.white),
    Icon(Icons.one_x_mobiledata, color: Colors.white),
    Icon(Icons.cabin, color: Colors.white),
    Icon(Icons.vaccines, color: Colors.white),
    Icon(Icons.vape_free_outlined, color: Colors.white),
    Icon(Icons.view_comfy_alt_rounded, color: Colors.white),
    Icon(Icons.view_list_sharp, color: Colors.white),
    Icon(Icons.ac_unit_outlined, color: Colors.white),
    Icon(Icons.add_box, color: Colors.white),
  ];
  const CustomGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.only(top: 20),
      crossAxisCount: 4,
      children: datas.map((e) => CustomIcon(widget: e)).toList(),
    );
  }
}

class CustomIcon extends StatelessWidget {
  final Widget widget;
  const CustomIcon({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(26),
      child: widget,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.blue,
      ),
    );
  }
}
