import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:travel_chronicle/data/localDB/event/event_model.dart';
import 'package:travel_chronicle/data/localDB/local_db.dart';
import 'package:travel_chronicle/data/locator.dart';
import 'package:travel_chronicle/models/event_model.dart';
import 'package:travel_chronicle/utilities/app_consts.dart';
import 'package:travel_chronicle/utilities/app_routes.dart';

class HomeProvider extends ChangeNotifier {
  List<EventModel> _events = [];
  List<EventModel> get events => _events;

  EventModel? _eventModel;
  EventModel? get eventModel => _eventModel;
  setEventModel(EventModel val) {
    _eventModel = val;
    notifyListeners();
  }

  Future<void> fetchEvents() async {
    if (storage.user != null && storage.user!.cloudSubscription == true) {
      
      
      await fetchEventsfromApi();
    } else {
      await fetchEventsfromLocal();
    }
  }

  Future<void> fetchEventsfromApi() async {
    try {
      var loadedEvents = await eventRepository.getAllMyEvent();
      if (loadedEvents != null) {
        _events = loadedEvents;
        log("events are ${_events.length}");
        notifyListeners();
        if (kDebugMode) {
          print(events.length);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching events: $e');
      }
    }
  }

  Future<void> fetchEventsfromLocal() async {
    try {
      var loadedEvents = await HiveService.getAllEvents();

      _events = loadedEvents.map((model) {
        return EventModel(
          timestamp: model.timestamp,
          name: model.name,
          images: model.images!,
          dateStart: model.dateStart,
          aboutTrip: model.aboutTrip,
          companionsNames: model.companionsNames,
          dateEnd: model.dateEnd,
          hotelName: model.hotelName,
          imageTitle: model.imageTitle,
          location: model.location,
          placeName: model.placeName,
          stamp: model.stamp,
          tripName: model.tripName,
        );
      }).toList();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching events: $e');
      }
    }
  }

  // ====================     ADDS      ==========================

  int maxFailedLoadAttempts = 3;


  InterstitialAd? interstitialAd;

  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  int _numInterstitialLoadAttempts = 0;


  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AppConsts.interstitialAdUnitId,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createInterstitialAd();
            }
          },
        ));
  }

  addLocalTriptoFirebase(BuildContext context) async {
    if (_events.isNotEmpty) {
      EasyLoading.show(status: "Loading..");
      try {
        await eventRepository.saveAllEvents(_events);

        EasyLoading.showSuccess("All trips uploaded on cloud successfully!");
        HiveService.deleteAllEvents();
        Navigator.pushReplacementNamed(context, homeScreenRoute);
      } catch (e) {
        EasyLoading.showError('Failed to create trip: $e');
        log(e.toString());
      }
    }
  }


}
