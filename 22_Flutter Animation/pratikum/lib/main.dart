import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pratikum/bloc/contact_bloc.dart';
import 'package:pratikum/bloc/history_bloc.dart';
import 'package:pratikum/soal2.dart';
// import 'package:pratikum/soal1.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ContactBloc>(create: (context) => ContactBloc()),
        BlocProvider<HistoryBloc>(create: (context) => HistoryBloc()),
      ],
      // Lakukan import pada soal1 atau soal2 untuk hasil pada soal yang berbeda
      child: const Soal2(),
      // child: const Soal2(),
    ),
  );
}
