// ignore_for_file: body_might_complete_normally_nullable, body_might_complete_normally_catch_error, depend_on_referenced_packages, empty_catches

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:travel_chronicle/models/stamps_model.dart';
import '../../models/event_model.dart';
import '../locator.dart';
import 'event_repository.dart';

class EventApi implements IEventRepository {
  @override
  Future<void> saveEvent(EventModel event, String evenId) async {
    try {
      await FirebaseFirestore.instance.collection('events').doc(evenId).set(event.toMap());
      if (kDebugMode) {
        print('Event saved successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving event: $e');
      }
    }
  }

  @override
  Future<EventModel?> getEvent(String eventId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('events').doc(eventId).get();
      if (doc.exists) {
        return EventModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting event: $e');
      }
    }
    return null;
  }

  @override
  Future<void> deleteEvent(String eventId) async {
    try {
      await FirebaseFirestore.instance.collection('events').doc(eventId).delete();
      if (kDebugMode) {
        print('Event deleted successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting event: $e');
      }
    }
  }

  @override
  Future<void> updateEvent(String eventId, EventModel event) async {
    try {
      await FirebaseFirestore.instance.collection('events').doc(eventId).update(event.toMap());
      if (kDebugMode) {
        print('Event updated successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating event: $e');
      }
    }
  }

  @override
  Future<List<EventModel>?> getAllMyEvent() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('events')
          .where('userId', isEqualTo: storage.user!.userId)
          .orderBy("timestamp", descending: true)
          .get();

      List<EventModel> events = querySnapshot.docs.map((doc) {
        return EventModel.fromDocument(doc);
      }).toList();

      return events;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching events: $e');
      }
      return null;
    }
  }

  @override
  Future<List<StampModel>?> getAllStam() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore.collection('allStemps').get();

      List<StampModel> stamps = querySnapshot.docs.map((doc) {
        return StampModel.fromDocument(doc);
      }).toList();

      return stamps;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching stemps: $e');
      }
      return null;
    }
  }

  @override
  Future<List<PassportModel>?> getAllPassport() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore.collection('stamps').get();

      List<PassportModel> passport = querySnapshot.docs.map((doc) {
        return PassportModel.fromDocument(doc);
      }).toList();

      return passport;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching stemps: $e');
      }
      return null;
    }
  }

  @override
  Future<void> saveClaimTicket(String ticketUrl) async {
    try {
      await FirebaseFirestore.instance.collection('stamps').add({"stamp": ticketUrl});
      if (kDebugMode) {
        print('ticket saved successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('ticket saving event: $e');
      }
    }
  }

  @override
  Future<void> saveAllEvents(List<EventModel> list) async {
    final firebase = FirebaseFirestore.instance;

    try {
      for (var j in list) {
        EventModel i = j;
        i.userId = storage.user!.userId;
        i.userImage = storage.user!.userImg;
        i.userName = storage.user!.userName;
        i.userLocation = "${storage.user!.city}, ${storage.user!.city}";
        i.images = [
          "https://www.shutterstock.com/image-illustration/no-picture-available-placeholder-thumbnail-260nw-2179364083.jpg"
        ];

        await firebase.collection('events').doc(i.timestamp.toString()).set(i.toMap());
      }
      if (kDebugMode) {
        print('Events saved successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving event: $e');
      }
    }
  }
}

Future<List<String>> uploadImagesToFirebase(List<File> imageFiles) async {
  List<String> imageUrls = [];

  for (File imageFile in imageFiles) {
    try {
      Reference reference =
          FirebaseStorage.instance.ref().child('files/${DateTime.now().millisecondsSinceEpoch.toString()}');
      await reference.putData(imageFile.readAsBytesSync());
      var downloadUrl = await reference.getDownloadURL();
      if (kDebugMode) {
        print(downloadUrl);
      }
      imageUrls.add(downloadUrl);
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      if (e is FirebaseException && e.code == 'unknown') {
        if (kDebugMode) {
          print('Error code: ${e.code}, message: ${e.message}');
        }
      }
    }
  }

  return imageUrls;
}

Future<String> uploadImageToFirebase(Uint8List imageFile) async {
  var downloadUrl;

  try {
    Reference reference =
        FirebaseStorage.instance.ref().child('files/${DateTime.now().millisecondsSinceEpoch.toString()}');
    await reference.putData(imageFile);
    downloadUrl = await reference.getDownloadURL();
    if (kDebugMode) {
      print(downloadUrl);
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error uploading image: $e');
    }
    if (e is FirebaseException && e.code == 'unknown') {
      if (kDebugMode) {
        print('Error code: ${e.code}, message: ${e.message}');
      }
    }
  }

  return downloadUrl;
}
