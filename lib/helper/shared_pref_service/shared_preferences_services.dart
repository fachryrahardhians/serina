import 'package:shared_preferences/shared_preferences.dart';

abstract class ILocalStorage {
  Future getString(String key);
  Future getBool(String key);
  Future delete(String key);
  Future put(String key, dynamic value);
  Future<int?> getInt(String key);
}

class LocalStorageService implements ILocalStorage {
  // SharedPreferences sharedPreferences =  SharedPreferences();

  LocalStorageService();

  @override
  Future delete(String key) async {
    // var shared = await SharedPreferences.getInstance();
    // shared.remove(key);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(key);
  }

  @override
  Future<String?> getString(String key) async {
    // var shared = await SharedPreferences.getInstance();
    // return shared.getString(key) ?? '';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }

  @override
  Future put(String key, dynamic value) async {
    // var shared = await SharedPreferences.getInstance();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (value is bool) {
      sharedPreferences.setBool(key, value);
    } else if (value is String) {
      sharedPreferences.setString(key, value);
    } else if (value is int) {
      sharedPreferences.setInt(key, value);
    } else if (value is double) {
      sharedPreferences.setDouble(key, value);
    }
  }

  @override
  Future<bool?> getBool(String key) async {
    // var shared = await SharedPreferences.getInstance();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }

  @override
  Future<int?> getInt(String? key) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key ?? 'o');
  }
}
