import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static final PreferenceManager _instance = PreferenceManager._internal();

  // factory constructor to return singleton instance
  factory PreferenceManager() {
    return _instance;
  }

  //private Constructor
  PreferenceManager._internal();

  late SharedPreferences _preferences;

  // Initialize SharedPreferences instance
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  //set
  Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    return await _preferences.setDouble(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    return await _preferences.setInt(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return await _preferences.setStringList(key, value);
  }

  //get

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  double? getDouble(String key) {
    return _preferences.getDouble(key);
  }

  int? getInt(String key) {
    return _preferences.getInt(key);
  }

  List<String>? getStringList(String key) {
    return _preferences.getStringList(key);
  }

  //delete

  Future<void> remove(String key) async {
    await _preferences.remove(key);
  }

  Future<void> clear() async {
    await _preferences.clear();
  }
}
