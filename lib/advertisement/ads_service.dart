// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class AdMobService {
//   static String? get bannerAdUnitId {
//     return 'ca-app-pub-3940256099942544/6300978111';
//   }
//
//   static final BannerAdListener bannerAdListener = BannerAdListener(
//       onAdLoaded: (ad) => debugPrint("Ad loaded"),
//       onAdFailedToLoad: (ad, error) {
//         ad.dispose();
//         debugPrint('Ad failed to load: $error');
//       },
//       onAdOpened: (ad) => debugPrint('Ad opened'),
//       onAdClosed: (ad) => debugPrint('Ad closed'));
// }
//
// // BannerAd? _banner;
//
// // createBannerAd() {
// //   _banner = BannerAd(
// //       size: AdSize.fullBanner,
// //       adUnitId: AdMobService.bannerAdUnitId!,
// //       listener: AdMobService.bannerAdListener,
// //       request: const AdRequest())
// //     ..load();
// // }
//
// // @override
// // void initState() {
// //   createBannerAd();
// //   super.initState();
// // }
//
// // _banner == null
// // ? Container()
// //     : SizedBox(
// // height: 55,
// // width: MediaQuery.of(context).size.width,
// // child: AdWidget(
// // ad: _banner!,
// // ),
// // ),
