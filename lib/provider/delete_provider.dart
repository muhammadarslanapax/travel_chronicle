import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_chronicle/data/localDB/local_db.dart';
import 'package:travel_chronicle/data/locator.dart';
import 'package:travel_chronicle/utilities/app_routes.dart';

class DeleteProvider extends ChangeNotifier {
  String? _selectedValue;

  String get selectedValue => _selectedValue!;

  setselectedValue(String val) {
    _selectedValue = val;
    notifyListeners();
  }

  Future<void> deleteEvent(BuildContext context, String timestamp) async {
    try {
      EasyLoading.show(status: 'please wait...');

      if (storage.user != null && storage.user!.cloudSubscription == true) {
        await eventRepository.deleteEvent(timestamp.toString());
         EasyLoading.dismiss();

      Navigator.pushNamedAndRemoveUntil(context, homeScreenRoute, (route) => false);
      EasyLoading.showSuccess("Event deleted!");
      }else{

         HiveService.deleteEvent(int.parse(timestamp));
         EasyLoading.dismiss();

      Navigator.pushNamedAndRemoveUntil(context, homeScreenRoute, (route) => false);
      EasyLoading.showSuccess("Event deleted!");
        
      }

     
    } catch (e) {
      EasyLoading.showError(e.toString());
      if (kDebugMode) {
        print('Error deleting event: $e');
      }
    }
  }
}
