import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_chronicle/data/storage/storage.dart';

import '../model/user_model.dart';

class PrefsStorage implements IStorage {
  PrefsStorage._prefsStorage();
  static final PrefsStorage _instance = PrefsStorage._prefsStorage();

  static PrefsStorage get instance => _instance;

  factory PrefsStorage() {
    return _instance;
  }

  static late SharedPreferences _prefs;

  static const String _keyUser = 'user';
  static const String _keyAllUser = 'allUsers';
  static const String _keyCloudSubscription = 'allUsers';

  @override
  Future<void> init() async => _prefs = await SharedPreferences.getInstance();

  @override
  Future<bool> setUser(UserModel user) => _prefs.setString(_keyUser, jsonEncode(user.toJson()));

  @override
  Future<void> setAllUsers(List<UserModel> users) async {
    List<Map<String, dynamic>> userListJson = users.map((user) => user.toJson()).toList();
    String usersJson = jsonEncode(userListJson);
    await _prefs.setString(_keyAllUser, usersJson);
  }

  @override
  UserModel? get user {
    final userString = _prefs.getString(_keyUser);
    if (userString != null) {
      final userJson = jsonDecode(userString);
      return UserModel.fromJson(userJson);
    }
    return null;
  }

  @override
  List<UserModel> getAllUsers() {
    final userString = _prefs.getString(_keyAllUser);

    if (userString != null) {
      List<dynamic> userMapList = jsonDecode(userString);

      List<UserModel> users = userMapList.map((userJson) => UserModel.fromJson(userJson)).cast<UserModel>().toList();
      return users;
    }
    return [];
  }

  @override
  Future<bool> removeUser() => _prefs.remove(_keyUser);

  @override
  Future<bool?> isCloundSubscription() async {
      var subscription =  await  _prefs.getBool(_keyCloudSubscription);
      return subscription;
  }

  @override
  Future<void> setCloundSubscription() async => await _prefs.setBool(_keyCloudSubscription, true);
}
