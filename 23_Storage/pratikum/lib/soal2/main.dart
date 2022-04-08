import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pratikum/soal2/bloc/contact_bloc.dart';
import 'package:pratikum/soal2/bloc/history_bloc.dart';
import 'package:pratikum/soal2/soal2.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ContactBloc>(create: (context) => ContactBloc()),
        BlocProvider<HistoryBloc>(create: (context) => HistoryBloc()),
      ],
      child: const Soal1Soal2(),
    ),
  );
}