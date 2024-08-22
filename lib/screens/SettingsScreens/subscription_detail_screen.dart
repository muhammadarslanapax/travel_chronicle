import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:travel_chronicle/data/localDB/event/event_model.dart';
import 'package:travel_chronicle/data/locator.dart';
import 'package:travel_chronicle/data/purchase_api.dart';
import 'package:travel_chronicle/models/event_model.dart';
import 'package:travel_chronicle/provider/home_provider.dart';
import 'package:travel_chronicle/provider/user_provider.dart';
import 'package:travel_chronicle/utilities/app_routes.dart';
import 'package:travel_chronicle/utilities/app_text_styles.dart';
import '../../global_widgets/app_bar_widget.dart';
import '../../global_widgets/button_widget.dart';
import '../../global_widgets/subscription_row_widget.dart';
import '../../utilities/app_colors.dart';

class SubscriptionDetailScreen extends StatefulWidget {
  const SubscriptionDetailScreen({super.key});

  @override
  State<SubscriptionDetailScreen> createState() => _SubscriptionDetailScreenState();
}

class _SubscriptionDetailScreenState extends State<SubscriptionDetailScreen> {
  List<Package> packages = [];

  @override
  void initState() {
    fetchOfferings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int subscription = args["subscription"];
    final String heading = args["heading"];
    final String details = args["details"];
    final String price = args["price"];
    final String subscriptionName = subscription == 1
        ? "cloudSubscription"
        : subscription == 2
            ? "skinColorSubscription"
            : subscription == 3
                ? "unlimitedTripSubscription"
                : subscription == 4
                    ? "extraPhotoSubscription"
                    : subscription == 5
                        ? "unlockPassportSubscription"
                        : subscription == 6
                            ? "exportPdfSubscription"
                            : subscription == 7
                                ? "allSubscription"
                                : "";

    return Scaffold(
      backgroundColor: skinColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarWidget(text: "Customization Options"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SubscriptionsRowWidget(
                    onTap: () {},
                    heading: heading,
                    details: details,
                    price: price,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BigButton(
                    width: 150,
                    height: 35,
                    text: "PURCHASE",
                    onTap: () {
                      _showUpgradeNowBottomSheetDialog(heading, details, price, subscriptionName);
                    },
                    textStyle: fourteen500TextStyle(color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _showUpgradeNowBottomSheetDialog(heading, details, price, String subscriptionName) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (builder) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.transparent,
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Container(
                          width: 100,
                          height: 2,
                          color: const Color(0xFF9B3DF3),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: const Text(
                          "Upgrade Now",
                          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SubscriptionsRowWidget(
                          onTap: () {},
                          heading: heading,
                          details: details,
                          price: price,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {},
                          child: Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: yellowColor),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    // if (packages.isNotEmpty) {
                                    //   Navigator.of(context).pop();

                                    //   _purchasePlan(packages[0], subscriptionName);
                                    // }

                                    _purchasePlan(subscriptionName);
                                  },
                                  child: const Text("Upgrade Plane")))),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  )),
            ),
          );
        });
  }

  _purchasePlan(String subscription) async {
    try {
      //  CustomerInfo purchaserInfo = await Purchases.purchasePackage(package);
      // var isPro = purchaserInfo.entitlements.all["premium_travel_app_images_upload"]?.isActive;
      // if (isPro ?? false) {
      if (subscription != "allSubscription") {
        await userRepository.update(storage.user!.userId, {subscription: true}).then((value) async {
          // ignore: use_build_context_synchronously
          await context.read<UserProvider>().updateFirebaseUser();
          EasyLoading.showSuccess("Subscription successfully buy");

          if (subscription == "cloudSubscription") {
            context.read<HomeProvider>().addLocalTriptoFirebase(context);
          } else {
            Navigator.pushReplacementNamed(context, homeScreenRoute);
          }
        });
      } else {
        await userRepository.update(storage.user!.userId, {
          "cloudSubscription": true,
          "skinColorSubscription": true,
          "unlimitedTripSubscription": true,
          "extraPhotoSubscription": true,
          "unlockPassportSubscription": true,
          "exportPdfSubscription": true,
        }).then((value) async {
          // ignore: use_build_context_synchronously
          await context.read<UserProvider>().updateFirebaseUser();
          EasyLoading.showSuccess("Subscription successfully buy");
          Navigator.pushReplacementNamed(context, homeScreenRoute);
        });
      }

      //}
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {}
    }
  }

  Future fetchOfferings() async {
    final offerings = await PurchaseApi.fetchOffers();
    log("offer ${offerings}");
    if (offerings.isNotEmpty) {
      final offer = offerings.first;
      packages = offerings.map((e) => e.availablePackages).expand((element) => element).toList();
      if (mounted) {
        setState(() {});
      }
    }
  }
}
