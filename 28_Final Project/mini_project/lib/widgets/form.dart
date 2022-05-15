import 'package:flutter/material.dart';
import 'package:mini_project/helpers/providers/form_manager.dart';
import 'package:provider/provider.dart';

class FormProvider extends StatelessWidget {
  final FormManager changeNotifier;
  final AutovalidateMode? autovalidateMode;
  final Widget Function(
    FormManager manager,
  ) builder;
  const FormProvider(
      {Key? key,
      required this.changeNotifier,
      required this.autovalidateMode,
      required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FormManager>(
      create: (_) => changeNotifier,
      child: Consumer<FormManager>(
          builder: (_, __, ___) => Form(child: builder(__), autovalidateMode: autovalidateMode)),
    );
  }
}
