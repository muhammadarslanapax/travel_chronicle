// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final stampModel = stampModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<StampModel> stampModelFromJson(String str) =>
    List<StampModel>.from(json.decode(str).map((x) => StampModel.fromJson(x)));

String stampModelToJson(List<StampModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StampModel {
  final String? country;
  final String? id;
  final String? stamp;

  StampModel({
    this.country,
    this.id,
    this.stamp,
  });

  factory StampModel.fromJson(Map<String, dynamic> json) => StampModel(
        country: json["country"],
        id: json["id"],
        stamp: json["stamp"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "id": id,
        "stamp": stamp,
      };

  factory StampModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return StampModel(
      country: data["country"],
      id: data["id"],
      stamp: data["stamp"],
    );
  }
}

// passoort

class PassportModel {
  String stamp;
  PassportModel({
    required this.stamp,
  });

  PassportModel copyWith({
    String? stamp,
  }) {
    return PassportModel(
      stamp: stamp ?? this.stamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stamp': stamp,
    };
  }

  factory PassportModel.fromMap(Map<String, dynamic> map) {
    return PassportModel(
      stamp: map['stamp'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PassportModel.fromJson(String source) => PassportModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PassportModel(stamp: $stamp)';

  @override
  bool operator ==(covariant PassportModel other) {
    if (identical(this, other)) return true;

    return other.stamp == stamp;
  }

  factory PassportModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return PassportModel(
      stamp: data["stamp"],
    );
  }

  @override
  int get hashCode => stamp.hashCode;
}
