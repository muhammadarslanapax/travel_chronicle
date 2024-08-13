import 'package:travel_chronicle/models/stamps_model.dart';

import '../../models/event_model.dart';

abstract class IEventRepository {

  Future<void> saveEvent(EventModel event,String evenId);

  Future<EventModel?> getEvent(String eventId);
  Future<List<StampModel>?> getAllStam();
  Future<List<EventModel>?> getAllMyEvent();
  Future<void> deleteEvent(String eventId);
  Future<void> updateEvent(String eventId, EventModel event);
  Future<List<String>?> getAllPassport();
}
