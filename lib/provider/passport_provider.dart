import 'package:flutter/foundation.dart';
import 'package:travel_chronicle/data/locator.dart';

class PassportProvider extends ChangeNotifier {
  List<String> _passport = [];
  List<String> get passport => _passport;

  Future<void> fetchPassports() async {
    try {
      var loadedPassports = await eventRepository.getAllPassport();
      if (loadedPassports != null) {
        _passport = loadedPassports;
        notifyListeners();
        if (kDebugMode) {
          print(passport.length);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching events: $e');
      }
    }
  }




  



  


  
}
