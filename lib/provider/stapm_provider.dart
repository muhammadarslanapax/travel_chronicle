
import 'package:flutter/foundation.dart';
import 'package:travel_chronicle/data/locator.dart';
import 'package:travel_chronicle/models/stamps_model.dart';

class StampProvider with ChangeNotifier {
  List<StampModel> _stampList = [];

  List<StampModel> get stampList => _stampList;

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

  Future<void> getAllStamps() async {
    try {
      var loadStamps = await eventRepository.getAllStam();
      if (loadStamps != null) {
        _stampList = loadStamps;
      }

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching stamps: $e');
      }
    }
  }
}
