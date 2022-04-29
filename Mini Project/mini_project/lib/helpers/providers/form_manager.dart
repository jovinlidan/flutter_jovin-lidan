import 'package:flutter/material.dart';

class FormManager with ChangeNotifier {
  final _fieldStates = <String, FormFieldState>{};

  void setValueForField(String key, String? newValue) {
    _ensureExists(key);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_fieldStates[key]?.value != newValue) {
        _fieldStates[key]?.value = newValue;
        notifyListeners();
      }
    });
  }

  String? getErrorMessageForField(String key) {
    _ensureExists(key);
    return _fieldStates[key]?.errorMessage;
  }

  String? getValueForField(String key) {
    _ensureExists(key);
    return _fieldStates[key]?.value;
  }

  FormFieldValidator<T>? wrapValidator<T>(String key, FormFieldValidator<T>? validator) {
    if (validator == null) return null;
    _ensureExists(key);

    return (input) {
      final result = validator(input);
      _fieldStates[key]?.errorMessage = result;
      _fieldStates[key]?.hasError = (result?.isNotEmpty ?? false);

      // WidgetsBinding.instance!.addPostFrameCallback((_) {
      //   if (_fieldStates[key]?.errorMessage != result) {
      //     notifyListeners();
      //   }
      //   if (_fieldStates[key]?.hasError != (result?.isNotEmpty ?? false)) {
      //     notifyListeners();
      //   }
      // });
      return result;
    };
  }

  List<FormFieldState> get erroredFields =>
      _fieldStates.entries.where((s) => s.value.hasError).map((s) => s.value).toList();

  void _ensureExists(String key) {
    _fieldStates[key] ??= FormFieldState(key: key);
  }
}

class FormFieldState {
  final String key;

  bool hasError;
  String? errorMessage;
  String? value;

  FormFieldState({required this.key}) : hasError = false {}
}
