import 'package:shared_preferences/shared_preferences.dart';

class Repositories {
  String repoKey;
  bool isLoading = false;
  late Future<SharedPreferences> _prefs;

  Repositories({required this.repoKey}) {
    _prefs = SharedPreferences.getInstance();
  }

  Future<String?> getData() async {
    isLoading = true;
    SharedPreferences prefs = await _prefs;
    // Uncomment kode dibawah untuk melihat loading effect lebih lama
    // await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
    return Future.value(prefs.getString(repoKey));
  }

  Future<void> setData(String data) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(repoKey, data);
  }
}
