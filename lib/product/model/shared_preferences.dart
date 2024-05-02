import 'package:shared_preferences/shared_preferences.dart';

class SharedInit {
  SharedInit._();
  final prefs = SharedPreferences.getInstance();
  late SharedPreferences sharedPreferences;
  static SharedInit instance = SharedInit._();

  Future<void> sharedSetup() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
