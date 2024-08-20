import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi {
  static Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);

    PurchasesConfiguration? configuration;
    if (Platform.isAndroid) {
      configuration = PurchasesConfiguration("goog_fwOhHTfDgtOyeZPpUkwwQRSfzwP");
    } else if (Platform.isIOS) {
      configuration = PurchasesConfiguration("appl_DCNZMKfNLuHUnaLEedsRbbLRvVY");
    }
    await Purchases.configure(configuration!);
  }

  static Future<List<Offering>> fetchOffers() async {
    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;
      log("current is ${current}");

      return current == null ? [] : [current];
    } on PlatformException catch (e) {
      return [];
    }
  }
}
