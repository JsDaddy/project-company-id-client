import 'package:shared_preferences/shared_preferences.dart';

LocalStorageService localStorageService = LocalStorageService();

class LocalStorageService {
  final String _tokenKey = 'token';

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> saveTokenKey(String tokenKey) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(_tokenKey, tokenKey);
  }

  Future<String> getTokenKey() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(_tokenKey);
  }

  Future<bool> saveData<T>(String key, T value) async {
    final SharedPreferences prefs = await _prefs;
    if (value is String) {
      return prefs.setString(key, value);
    }
    if (value is bool) {
      return prefs.setBool(key, value);
    }
    return false;
  }

  Future<T> getData<T>(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.get(key) as T;
  }
}
