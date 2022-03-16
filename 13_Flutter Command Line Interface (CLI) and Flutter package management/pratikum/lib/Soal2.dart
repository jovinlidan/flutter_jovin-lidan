import 'package:badges/badges.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class Soal2 extends StatelessWidget {
  const Soal2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: const Text("Barcode")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Alterra Academy :",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                color: Colors.white,
                child: BarcodeWidget(
                  data: "Alterra Academy",
                  barcode: Barcode.qrCode(),
                  width: 150,
                  height: 150,
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Flutter Asik :",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                color: Colors.white,
                child: BarcodeWidget(
                  data: "Flutter Asik",
                  barcode: Barcode.qrCode(),
                  width: 150,
                  height: 150,
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Jovin Lidan :",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                color: Colors.white,
                child: BarcodeWidget(
                  data: "Jovin Lidan",
                  barcode: Barcode.qrCode(),
                  width: 150,
                  height: 150,
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
