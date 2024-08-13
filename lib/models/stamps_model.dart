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
