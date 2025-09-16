import 'dart:developer';

import 'storage_utility.dart';

class UserPreferences {
  final AppLocalStorage _storage = AppLocalStorage.instance();

  // -- Set isFirstTime
  Future<void> setIsFirstTime(bool isFirstTime) async {
    await _storage.writeData('isFirstTime', isFirstTime);
  }

  // -- isFirstTime if Null
  Future<void> setIsFirstTimeIfNull() async {
    await _storage.writeDataIfNull('isFirstTime', true);
  }

  // -- Get isFirstTime
  Future<bool> getIsFirstTime() async {
    return _storage.readData<bool>('isFirstTime') ?? true;
  }

  // -- Set token (auth token)
  Future<void> setToken(String authToken) async {
    try {
      await _storage.writeData('x-auth-token', authToken);
      log("Token Saved --> $authToken");
    } catch (error) {
      log("Error saving token: $error");
    }
  }

  // -- Get token (auth token)
  Future<String?> getToken() async {
    return _storage.readData<String>('x-auth-token');
  }

  // -- Remove token (auth token)
  Future<void> removeToken() async {
    await _storage.removeData('x-auth-token');
  }

  // -- Print token (auth token)
  Future<void> printToken() async {
    final token = await getToken();
    if (token != null) {
      print("Token: $token");
    }
  }

  // -- Set user-id
  Future<void> setUserId(String id) async {
    await _storage.writeData("user_id", id);
  }

  // -- Get user-id
  Future<String> getUserId() async {
    return _storage.readData<String>("user_id") ?? "";
  }

  /// Stores full user data
  Future<void> setUserData(Map<String, dynamic> userData) async {
    await _storage.writeData('user_data', userData);
  }

  /// Retrieves full user data
  Future<Map<String, dynamic>?> getUserData() async {
    return _storage.readData<Map<String, dynamic>>('user_data');
  }

  //shelter detail

  // -- Set device token
// Set device token (List<String>)
  Future<void> setDeviceToken(List<String> deviceToken) async {
    await _storage.writeData('device_token', deviceToken);
    log("Device Token Saved --> $deviceToken");
  }

// Get device token as List<String>?
  Future<List<String>?> getDeviceToken() async {
    return _storage.readData<List<dynamic>>('device_token')?.cast<String>();
  }

  // -- Remove device token
  Future<void> removeDeviceToken() async {
    await _storage.removeData('device_token');
  }

  // -- Print device token
  Future<void> printDeviceToken() async {
    final deviceToken = await getDeviceToken();
    if (deviceToken != null) {
      print("Device Token: $deviceToken");
    }
  }

  // -- Get header
  Future<Map<String, String>> getHeader() async {
    final String? token = await getToken();
    if (token == null) return <String, String>{};
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      "Accept": "application/json"
    };
  }

  Future<Map<String, String>> getHeader1(bool useToken) async {
    final String? token = await getToken();
    return {
      if (useToken) 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      "Accept": "application/json"
    };
  }

  //shelter id set and get
  Future<String> getShelterId() async {
    return _storage.readData<String>('shelter_id') ?? "";
  }

  Future<void> setShelterId(String id) async {
    await _storage.writeData('shelter_id', id);
  }

  Future<void> setUserRole(String role) async {
    await _storage.writeData('role', role);
  }

  Future<String?> getUserRole() async {
    return _storage.readData<String>('role');
  }

  Future<void> setShelterName(String name) async {
    await _storage.writeData('shelter_name', name);
  }

  Future<String?> getShelterName() async {
    return _storage.readData<String>('shelter_name');
  }

  Future<void> clearSelectedShelter() async {
    // final prefs = await SharedPreferences.getInstance();
    await _storage.removeData("shelterName");
    await _storage.removeData("shelterId");
  }

  // -- Clear all data
  Future<void> clearAll() async {
    final bool isFirstTime = await getIsFirstTime();
    final String? shelterId = await getShelterId();
    final String? shelterName = await getShelterName();
    final String? userId = await getUserId();
    final String? token = await getToken();
    final List<String>? deviceToken = await getDeviceToken();
    await _storage.removeData('shelterId');
    await _storage.removeData('shelterName');
    await _storage.removeData('shelterRole');

    await _storage.clearAll();
    setIsFirstTime(isFirstTime);
    removeShelterId();
    removeShelterName();
    removeUserId();
    removeToken();
    removeDeviceToken();
  }

  // Remove user ID
  Future<void> removeUserId() async {
    await _storage.removeData('user_id');
  }

  // Remove shelter name
  Future<void> removeShelterName() async {
    await _storage.removeData('shelter_name');
  }

  // Remove shelter ID
  Future<void> removeShelterId() async {
    await _storage.removeData('shelter_id');
  }

  // Optionally, a method to remove all user-related data individually:
  Future<void> clearUserRelatedData() async {
    await removeUserId();
    await removeShelterName();
    await removeShelterId();
    await removeToken();
    await removeDeviceToken();
    await _storage.removeData('user_data');
  }
}
