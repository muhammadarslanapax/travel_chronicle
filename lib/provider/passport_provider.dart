import 'package:flutter/foundation.dart';
import 'package:travel_chronicle/data/locator.dart';
import 'package:travel_chronicle/models/stamps_model.dart';

class PassportProvider extends ChangeNotifier {
  List<PassportModel> _passport = [];
  List<PassportModel> get passport => _passport;


   String? _selectedStamp;
  String? get stemp => _selectedStamp;
  setSelectedStamp(String st) {
    _selectedStamp = st;
    notifyListeners();
  }

    int _selected = -1;
  int get getselected => _selected;
  setselected(int val) {
    _selected = val;
    notifyListeners();
  }
  



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
