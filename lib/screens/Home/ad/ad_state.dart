import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

import 'package:travel_chronicle/utilities/app_consts.dart';

class AdState {
  Future<InitializationStatus> initialization;
  AdState(this.initialization);

  String? get bannerAdUnitId => AppConsts.bannderAdUnitId;

  static bool adStatus = true;

  AdManagerBannerAdListener get adListener => _adListener;

  final AdManagerBannerAdListener _adListener = AdManagerBannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) {
      debugPrint('Ad loaded.');
      adStatus = true;
    },
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      debugPrint('Ad failed to load: $error');
      adStatus = false;
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => debugPrint('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => debugPrint('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => debugPrint('Ad impression.'),
    onAppEvent: (ad, name, data) => debugPrint('App event : ${ad.adUnitId}, $name, $data.'),
  );
}
