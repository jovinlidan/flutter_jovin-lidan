import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class TimeWidget extends StatefulWidget {
  const TimeWidget({Key? key}) : super(key: key);

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  String time = "";
  Timer? _timer;

  void setDateTime() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      String formattedDate = DateFormat('HH:mm:ss').format(now);
      setState(() {
        time = formattedDate;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setDateTime();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(time, style: const TextStyle(fontSize: 40));
  }
}
