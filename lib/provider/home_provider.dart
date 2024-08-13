import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:travel_chronicle/data/locator.dart';
import 'package:travel_chronicle/models/event_model.dart';
import 'package:travel_chronicle/utilities/app_consts.dart';

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

  // ====================     ADDS      ==========================

  int maxFailedLoadAttempts = 3;

  BannerAd? bannerAd;

  InterstitialAd? interstitialAd;

  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  int _numInterstitialLoadAttempts = 0;

  void loadAd() async {
    BannerAd(
      adUnitId: AppConsts.bannderAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          bannerAd = ad as BannerAd;
          notifyListeners();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    ).load();
  }

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



}
