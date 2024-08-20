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

  static Future<void> updateEvent(int index, EventLocalDBModel event) async {
    var box = await Hive.openBox<EventLocalDBModel>(boxName);
    await box.putAt(index, event);
  }

  static Future<void> deleteEvent(int index) async {
    var box = await Hive.openBox<EventLocalDBModel>(boxName);
    await box.deleteAt(index);
  }
}
