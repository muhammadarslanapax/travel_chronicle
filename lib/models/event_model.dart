import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  int timestamp;
  String name;
  List<String> images;
  String? placeName;
  String? userId;
  String? userName;
  String? userImage;
  String? userLocation;
  String? tripName;
  String? location;
  int dateStart;
  int? dateEnd;
  String? hotelName;
  List<String>? companionsNames;
  String? aboutTrip;
  String? stamp;
  String? imageTitle;

  EventModel({
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

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'name': name,
      'images': images,
      'userId': userId,
      'placeName': placeName,
      'userName': userName,
      'userImage': userImage,
      'userLocation': userLocation,
      'tripName': tripName,
      'location': location,
      'dateStart': dateStart,
      'dateEnd': dateEnd,
      'hotelName': hotelName,
      'companionsNames': companionsNames,
      'aboutTrip': aboutTrip,
      'stamp': stamp,
      "imageTitle":imageTitle
    };
  }

  static EventModel fromMap(Map<String, dynamic> map) {
    return EventModel(
      timestamp: map['timestamp'],
      name: map['name'],
      images: List<String>.from(map['images']),
      placeName: map['placeName'],
      userName: map['userName'],
      userImage: map['userImage'],
      userId: map['userId'],
      userLocation: map['userLocation'],
      tripName: map['tripName'],
      location: map['location'],
      dateStart: map['dateStart'],
      dateEnd: map['dateEnd'],
      hotelName: map['hotelName'],
      companionsNames: List<String>.from(map['companionsNames']),
      aboutTrip: map['aboutTrip'],
      stamp: map['stamp'],
      imageTitle:map["imageTitle"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'name': name,
      'images': images,
      'placeName': placeName,
      'userName': userName,
      'userId': userId,
      'userImage': userImage,
      'userLocation': userLocation,
      'tripName': tripName,
      'location': location,
      'dateStart': dateStart,
      'dateEnd': dateEnd,
      'hotelName': hotelName,
      'companionsNames': companionsNames,
      'aboutTrip': aboutTrip,
      'stamp': stamp,
      "imageTitle":imageTitle
    };
  }

  static EventModel fromJson(Map<String, dynamic> json) {
    return EventModel(
      timestamp: json['timestamp'],
      name: json['name'],
      images: List<String>.from(json['images']),
      placeName: json['placeName'],
      userName: json['userName'],
      userImage: json['userImage'],
      userLocation: json['userLocation'],
      userId: json['userId'],
      tripName: json['tripName'],
      location: json['location'],
      dateStart: json['dateStart'],
      dateEnd: json['dateEnd'],
      hotelName: json['hotelName'],
      companionsNames: List<String>.from(json['companionsNames']),
      aboutTrip: json['aboutTrip'],
      stamp: json['stamp'],
      imageTitle: json["imageTitle"]
    );
  }

  factory EventModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return EventModel(
      timestamp: data['timestamp'] ?? Timestamp.now().millisecondsSinceEpoch,
      name: data['name'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      placeName: data['placeName'],
      userName: data['userName'],
      userImage: data['userImage'],
      userLocation: data['userLocation'],
      userId: data['userId'],
      tripName: data['tripName'],
      location: data['location'],
      dateStart: data['dateStart'] ?? Timestamp.now().millisecondsSinceEpoch,
      dateEnd: data['dateEnd'] ?? Timestamp.now().millisecondsSinceEpoch,
      hotelName: data['hotelName'],
      companionsNames: data['companionsNames'] != null
          ? List<String>.from(data['companionsNames'])
          : [],
      aboutTrip: data['aboutTrip'],
      stamp: data['stamp'],
      imageTitle: data["imageTitle"]
    );
  }


}
