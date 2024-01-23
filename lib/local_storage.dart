import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String getValue(String key, {String defaultValue = ''}) {
    return _preferences.getString(key) ?? defaultValue;
  }

  Future<void> setValue(String key, String value) async {
    await _preferences.setString(key, value);
  }
}
