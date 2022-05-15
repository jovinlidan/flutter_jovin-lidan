class Validator {
  static String? _null(String? val) => null;

  static String? validate(String? value, List<String? Function(String? el)> validators) {
    return validators.firstWhere((element) {
      return element(value) != null;
    }, orElse: () => _null)(value);
  }

  static String? required(String? val) {
    if (val == null || val == "") return "Kolom tidak boleh kosong";
    return null;
  }

  static String? email(String? val) {
    if (val == null ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(val)) return "Kolom harus berisi email";
    return null;
  }

  static String? min5(
    String? val,
  ) {
    if (val == null || val.length < 5) return "Kolom minimal 5 huruf";
    return null;
  }

  static String? min8(
    String? val,
  ) {
    if (val == null || val.length < 5) return "Kolom minimal 5 huruf";
    return null;
  }
}
