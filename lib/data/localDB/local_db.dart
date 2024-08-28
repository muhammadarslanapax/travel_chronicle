import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:travel_chronicle/data/localDB/event/event_model.dart';

class HiveService {
  static const String boxName = "events";

  static Future<void> addEvent(EventLocalDBModel event) async {
    var box = await Hive.openBox<EventLocalDBModel>(boxName);
    await box.add(event);
  }

  static Future<List<EventLocalDBModel>> getAllEvents() async {
    var box = await Hive.openBox<EventLocalDBModel>(boxName);
    return box.values.toList();
  }

  static Future<void> updateEvent(int timestamp, EventLocalDBModel event) async {
    var box = await Hive.openBox<EventLocalDBModel>(boxName);

    var index = box.values.toList().indexWhere((event) => event.timestamp == timestamp);

    if (index != -1) {
      await box.putAt(index, event);
    } else {
      if (kDebugMode) {
        print("Event not found!");
      }
    }
  }

  static Future<void> deleteEvent(int index) async {
    var box = await Hive.openBox<EventLocalDBModel>(boxName);
    for (int i = 0; i < box.length; i++) {
      EventLocalDBModel? event = box.getAt(i);

      if (event!.timestamp == index) {
        // Delete the event at the found index
        await box.deleteAt(i);
        print('Event with timestamp $index deleted successfully.');
        return; // Exit after deleting the first matching event
      }
    }
  }

  static Future<void> deleteAllEvents() async {
    var box = await Hive.openBox<EventLocalDBModel>(boxName);
    await box.clear();
  }

}
