import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_tokens_model.dart';
import '../models/employee_dto.dart';

class CacheManager {
  static const _keyAuthTokens = 'auth_tokens';
  static const _keyUserProfile = 'user_profile';
  static const _keyLastUpdate = 'last_update';

  Future<void> saveAuthTokens(AuthTokens tokens) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAuthTokens, authTokensToJson(tokens));
  }

  Future<AuthTokens?> getAuthTokens() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyAuthTokens);
    if (jsonString != null) {
      return authTokensFromJson(jsonString);
    }
    return null;
  }

  Future<void> saveUserProfile(EmployeeDto profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserProfile, employeeDtoToJson(profile));
  }

  Future<EmployeeDto?> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyUserProfile);
    if (jsonString != null) {
      return employeeDtoFromJson(jsonString);
    }
    return null;
  }

  Future<void> saveLastUpdate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyLastUpdate, DateTime.now().millisecondsSinceEpoch);
  }

  Future<DateTime?> getLastUpdate() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt(_keyLastUpdate);
    if (timestamp != null) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    return null;
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyAuthTokens);
    await prefs.remove(_keyUserProfile);
    await prefs.remove(_keyLastUpdate);
  }
}
