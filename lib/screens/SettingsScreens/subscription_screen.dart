import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:travel_chronicle/data/purchase_api.dart';
import 'package:travel_chronicle/utilities/app_text_styles.dart';

import '../../global_widgets/app_bar_widget.dart';
import '../../global_widgets/subscription_row_widget.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/app_routes.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
                  Text(
                    "Sign-up is required by Apple Store and\nGoogle Play Store for any purchase",
                    style: twelve400TextStyle(color: textBrownColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SubscriptionsRowWidget(
                    onTap: () {
                      Navigator.pushNamed(context, subscriptionDetailsScreenRoute, arguments: {
                        "subscription": 1,
                        "heading": "Cloud Storage",
                        "details": "Back up progress for all devices\nEffective for 1 year\nNo-auto renewal",
                        "price": '\$3.99',
                      });
                    },
                    heading: "Cloud Storage",
                    details: "Back up progress for all devices\nEffective for 1 year\nNo-auto renewal",
                    price: '\$3.99',
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        color: skinColor,
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 1),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Skin Colors",
                            style: sixteen500TextStyle(
                              color: textBrownColor,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Change app skin colors depending on our mood",
                                      style: eleven400TextStyle(
                                        color: textBrownColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    Row(
                                      children: [
                                        for (int i = 0; i < 5; i++)
                                          Container(
                                            margin: const EdgeInsets.only(right: 15),
                                            width: 23,
                                            height: 23,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: i == 0
                                                          ? const Color(0xff4A2E28)
                                                          : i == 1
                                                              ? const Color(0xffE4AFAF)
                                                              : i == 2
                                                                  ? const Color(0xff484A58)
                                                                  : i == 3
                                                                      ? const Color(0xffDADBD4)
                                                                      : const Color(0xffB1CCD2),
                                                      borderRadius: const BorderRadius.only(
                                                        topLeft: Radius.circular(5.0),
                                                        bottomLeft: Radius.circular(5.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: i == 0
                                                          ? const Color(0xffEEDFD9)
                                                          : i == 1
                                                              ? const Color(0xff4A2E28)
                                                              : i == 2
                                                                  ? const Color(0xffFFF3E1)
                                                                  : i == 3
                                                                      ? const Color(0xff162E52)
                                                                      : const Color(0xffE5DBC6),
                                                      borderRadius: const BorderRadius.only(
                                                        topRight: Radius.circular(5.0),
                                                        bottomRight: Radius.circular(5.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$3.99",
                                    style: twenty500TextStyle(
                                      color: textBrownColor,
                                    ),
                                  ),
                                  Text(
                                    "One-time charge",
                                    style: eleven400TextStyle(
                                      color: textBrownColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Supplemental Functions",
                      style: sixteen600TextStyle(
                        color: textBrownColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SubscriptionsRowWidget(
                    onTap: () {
                      Navigator.pushNamed(context, subscriptionDetailsScreenRoute, arguments: {
                        "subscription": 3,
                        "heading": "Unlimited Trip Entries",
                        "details": "Activate trip entry for 2020 and prior",
                        "price": '\$3.99',
                      });
                    },
                    heading: "Unlimited Trip Entries",
                    details: "Activate trip entry for 2020 and prior",
                    price: '\$3.99',
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SubscriptionsRowWidget(
                    onTap: () {
                      Navigator.pushNamed(context, subscriptionDetailsScreenRoute, arguments: {
                        "subscription": 4,
                        "heading": "Extra Photos Upload",
                        "details": "Upload additional images to trips\nID registration is required",
                        "price": '\$3.99',
                      });
                    },
                    heading: "Extra Photos Upload",
                    details: "Upload additional images to trips\nID registration is required",
                    price: '\$3.99',
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SubscriptionsRowWidget(
                    onTap: () {
                      Navigator.pushNamed(context, subscriptionDetailsScreenRoute, arguments: {
                        "subscription": 5,
                        "heading": "Unlock Passport Book",
                        "details": "Access passport book for stamp collection",
                        "price": '\$2.99',
                      });
                    },
                    heading: "Unlock Passport Book",
                    details: "Access passport book for stamp collection",
                    price: '\$2.99',
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SubscriptionsRowWidget(
                    onTap: () {
                      Navigator.pushNamed(context, subscriptionDetailsScreenRoute, arguments: {
                        "subscription": 6,
                        "heading": "Export to PDF",
                        "details": "Export journal for printing",
                        "price": '\$2.99',
                      });
                    },
                    heading: "Export to PDF",
                    details: "Export journal for printing",
                    price: '\$2.99',
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  SubscriptionsRowWidget(
                    onTap: () {
                      Navigator.pushNamed(context, subscriptionDetailsScreenRoute, arguments: {
                        "subscription": 7,
                        "heading": "All Inclusive Pack",
                        "details": "Buy All features on app\nCloud Storage is not included",
                        "price": '\$11.99',
                      });
                    },
                    heading: "All Inclusive Pack",
                    details: "Buy All features on app\nCloud Storage is not included",
                    price: '\$11.99',
                    isExclusive: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
