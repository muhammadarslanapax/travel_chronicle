import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';

abstract class IUserRepository {

  Future<UserModel?> get(String documentId);
  Future<void> signUp(String email, String password);
  Future<void> login(String email, String password);
  Future<void> add(UserModel user);
  Future<void> changePassword(String newPassword);
  
  Future<void> update(String documentId, Map<String, dynamic> map);

  Future<void> delete(String documentId);
  Future<void> signOut();
  User? getCurrentUser();
  Future<String> uploadFile(File image);
  
}
