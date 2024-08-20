import 'dart:io';

import 'package:hive/hive.dart';

part 'event_model.g.dart';

@HiveType(typeId: 0)
class EventLocalDBModel extends HiveObject {
  @HiveField(0)
  int timestamp;
  
  @HiveField(1)
  String name;
  
  @HiveField(2)
  List<String>? images;
  
  @HiveField(3)
  String? placeName;
  
  @HiveField(4)
  String? userId;
  
  @HiveField(5)
  String? userName;
  
  @HiveField(6)
  String? userImage;
  
  @HiveField(7)
  String? userLocation;
  
  @HiveField(8)
  String? tripName;
  
  @HiveField(9)
  String? location;
  
  @HiveField(10)
  int dateStart;
  
  @HiveField(11)
  int? dateEnd;
  
  @HiveField(12)
  String? hotelName;
  
  @HiveField(13)
  List<String>? companionsNames;
  
  @HiveField(14)
  String? aboutTrip;
  
  @HiveField(15)
  String? stamp;
  
  @HiveField(16)
  String? imageTitle;

  EventLocalDBModel({
    required this.timestamp,
    required this.name,
    required this.images,
    this.placeName,
    this.userId,
    this.userName,
    this.userImage,
    this.userLocation,
    this.tripName,
    this.location,
    required this.dateStart,
    this.dateEnd,
    this.hotelName,
    this.companionsNames,
    this.aboutTrip,
    this.stamp,
    this.imageTitle
  });
}
