// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationProvider extends ChangeNotifier {
  LocationModel location = LocationModel(latitude: 0.0, longitude: 0.0);
  AddressModel address = AddressModel(city: "", country: "");

  Future<void> checkAndRequestPermission() async {
    var permissionStatus = await checkPermission();
    if (permissionStatus.isDenied) {
      permissionStatus = await requestPermission();
    }

    if (permissionStatus.isGranted) {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    var position = await getCurrentLocation();

    location.latitude = position.latitude;
    location.longitude = position.longitude;

    var locationAddress = await _getAddress(location);
    address.country = locationAddress.country;
    address.city = locationAddress.city;
    log("latitude ${location.latitude} longitude ${location.longitude}");
    log("country ${address.country} city ${address.city}");

    notifyListeners();
  }

  Future<AddressModel> _getAddress(LocationModel location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
      Placemark place = placemarks[0];

      return AddressModel(city: place.locality ?? "", country: place.country ?? "");
    } catch (e) {
      return AddressModel(city: "", country: "");
    }
  }
}

Future<Position> getCurrentLocation() async {
  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}

Future<PermissionStatus> checkPermission() async {
  return await Permission.location.status;
}

Future<PermissionStatus> requestPermission() async {
  return await Permission.location.request();
}

class LocationModel {
  double latitude;
  double longitude;

  LocationModel({required this.latitude, required this.longitude});
}

class AddressModel {
  String city;
  String country;
  AddressModel({
    required this.city,
    required this.country,
  });
}
