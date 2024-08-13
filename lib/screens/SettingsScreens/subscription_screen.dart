import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
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
                  const SizedBox(
                    height: 10,
                  ),
                  SubscriptionsRowWidget(
                    onTap: () {
                      Navigator.pushNamed(
                          context, subscriptionDetailsScreenRoute);
                    },
                    heading: "Cloud Storage",
                    details:
                        "Back up progress for all devices\nEffective for 1 year\nNo-auto renewal",
                    price: '\$3.99',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
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
                          const SizedBox(
                            height: 5,
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
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        for (int i = 0; i < 5; i++)
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 15),
                                            width: 23,
                                            height: 23,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: i == 0
                                                          ? const Color(
                                                              0xff4A2E28)
                                                          : i == 1
                                                              ? const Color(
                                                                  0xffE4AFAF)
                                                              : i == 2
                                                                  ? const Color(
                                                                      0xff484A58)
                                                                  : i == 3
                                                                      ? const Color(
                                                                          0xffDADBD4)
                                                                      : const Color(
                                                                          0xffB1CCD2),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                5.0),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                5.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: i == 0
                                                          ? const Color(
                                                              0xffEEDFD9)
                                                          : i == 1
                                                              ? const Color(
                                                                  0xff4A2E28)
                                                              : i == 2
                                                                  ? const Color(
                                                                      0xffFFF3E1)
                                                                  : i == 3
                                                                      ? const Color(
                                                                          0xff162E52)
                                                                      : const Color(
                                                                          0xffE5DBC6),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topRight:
                                                            Radius.circular(
                                                                5.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                5.0),
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
                  const SizedBox(
                    height: 25,
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
                  const SizedBox(
                    height: 15,
                  ),
                  SubscriptionsRowWidget(
                    onTap: () {
                      Navigator.pushNamed(
                          context, subscriptionDetailsScreenRoute);
                    },
                    heading: "Unlimited Trip Entries",
                    details: "Activate trip entry for 2020 and prior",
                    price: '\$3.99',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SubscriptionsRowWidget(
                    onTap: () {
                      Navigator.pushNamed(
                          context, subscriptionDetailsScreenRoute);
                    },
                    heading: "Extra Photos Upload",
                    details:
                        "Upload additional images to trips\nID registration is required",
                    price: '\$3.99',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SubscriptionsRowWidget(
                    onTap: () {
                      Navigator.pushNamed(
                          context, subscriptionDetailsScreenRoute);
                    },
                    heading: "Unlock Passport Book",
                    details: "Access passport book for stamp collection",
                    price: '\$2.99',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SubscriptionsRowWidget(
                    onTap: () {
                      Navigator.pushNamed(
                          context, subscriptionDetailsScreenRoute);
                    },
                    heading: "Export to PDF",
                    details: "Export journal for printing",
                    price: '\$2.99',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SubscriptionsRowWidget(
                    onTap: () {
                      Navigator.pushNamed(
                          context, subscriptionDetailsScreenRoute);
                    },
                    heading: "All Inclusive Pack",
                    details:
                        "Buy All features on app\nCloud Storage is not included",
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
