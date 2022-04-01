import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pratikum/bloc/contact_bloc.dart';
import 'package:pratikum/soal1soal2.dart';

void main() {
  runApp(
    BlocProvider<ContactBloc>(
      create: (context) => ContactBloc(),
      child: const Soal1Soal2(),
    ),
  );
}
