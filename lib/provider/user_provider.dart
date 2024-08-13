import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/locator.dart';
import '../data/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? localUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userType = 'Student';

  Future<void> updateUser(UserModel user) async {
    localUser = user;
    await storage.setUser(user);

    notifyListeners();
  }

  Future<void> logout() async {
    await _auth.signOut();
    localUser = null;
    storage.removeUser();
    notifyListeners();
  }

  Future<void> updateFirebaseUser() async {
    final user = await userRepository.get(_auth.currentUser?.uid ?? '');
    if (user != null) {
      await updateUser(user);
    }
  }

  void setUserType(String type) {
    userType = type;
  }
}
