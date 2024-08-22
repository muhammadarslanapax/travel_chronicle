import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_chronicle/data/localDB/event/event_model.dart';
import 'package:travel_chronicle/data/localDB/local_db.dart';
import 'package:travel_chronicle/data/locator.dart';
import 'package:travel_chronicle/models/event_model.dart';
import 'package:travel_chronicle/utilities/app_routes.dart';

class EditProvider extends ChangeNotifier {
  EventModel? _eventModel;
  EventModel get eventModel => _eventModel!;

  List<File> _images = [];
  List<File> get images => _images;

  setImages(File file) {
    _images.add(file);
    notifyListeners();
  }

  List<String> _imageUrls = [];
  List<String> get imagesUrl => _imageUrls;

  void setImageUrls(List<String> urls) {
    _imageUrls = urls;
    log("images ${_imageUrls.length}");
  }

  removeImages(int index) {
    _images.removeAt(index);
    notifyListeners();
  }

  removeImageUrl(int index) {
    _imageUrls.removeAt(index);
    notifyListeners();
  }

  setEventModel(EventModel eventModel) {
    _eventModel = eventModel;
    notifyListeners();
  }

  Future<void> updateEvent(BuildContext content, EventModel event, String evenId) async {
    try {
      await eventRepository.updateEvent(evenId, event);
      EasyLoading.showSuccess("Trip updated successfully!");
      Navigator.pushNamedAndRemoveUntil(content, homeScreenRoute, (route) => false);
    } catch (e) {
      EasyLoading.showError('Failed to create trip: $e');
    }
  }

  editEventLocal(context, EventLocalDBModel event, int timestamp) async {
    try {
      await HiveService.updateEvent(timestamp, event);
      EasyLoading.showSuccess("Trip created successfully!");
      Navigator.pushNamedAndRemoveUntil(context, homeScreenRoute, (route) => false);
    } catch (e) {
      EasyLoading.showError('Failed to edit trip: $e');
      log(e.toString());
    }
  }
}
