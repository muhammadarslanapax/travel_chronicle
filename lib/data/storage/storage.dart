import '../model/user_model.dart';

abstract class IStorage {
  Future<void> init();
  Future<bool> setUser(UserModel user);
  Future<void> setAllUsers(List<UserModel> user);
  UserModel? get user;
  Future<bool> removeUser();
  List<UserModel> getAllUsers();

  Future<void> setCloundSubscription();
    Future<bool?> isCloundSubscription();

}
