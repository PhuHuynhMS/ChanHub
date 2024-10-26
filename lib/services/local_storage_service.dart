import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;

  static Future<LocalStorageService> getInstance() async {
    if (_instance != null) {
      return _instance!;
    }
    _instance ??= LocalStorageService();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  dynamic get(String key) => _preferences!.get(key);

  void set(String key, dynamic value) {
    if (value is bool) {
      _preferences!.setBool(key, value);
    } else if (value is int) {
      _preferences!.setInt(key, value);
    } else if (value is double) {
      _preferences!.setDouble(key, value);
    } else if (value is String) {
      _preferences!.setString(key, value);
    } else if (value is List<String>) {
      _preferences!.setStringList(key, value);
    } else {
      _preferences!.remove(key);
    }
  }
}
