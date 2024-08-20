import 'package:flutter/material.dart';
import 'package:travel_chronicle/data/locator.dart';

class ChangePasswordProvider extends ChangeNotifier {
  Future changePassword(String newPassword) async {
    userRepository.changePassword(newPassword);
  }
}
