import 'package:flutter/material.dart';
import 'package:travel_chronicle/utilities/app_text_styles.dart';

import '../../global_widgets/app_bar_widget.dart';
import '../../global_widgets/button_widget.dart';
import '../../global_widgets/subscription_row_widget.dart';
import '../../utilities/app_colors.dart';

class SubscriptionDetailScreen extends StatefulWidget {
  const SubscriptionDetailScreen({super.key});

  @override
  State<SubscriptionDetailScreen> createState() =>
      _SubscriptionDetailScreenState();
}

class _SubscriptionDetailScreenState extends State<SubscriptionDetailScreen> {
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
                  SubscriptionsRowWidget(
                    onTap: () {},
                    heading: "Cloud Storage",
                    details:
                        "Back up progress for all devices\nEffective for 1 year\nNo-auto renewal",
                    price: '\$3.99',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BigButton(
                    width: 150,
                    height: 35,
                    text: "PURCHASE",
                    onTap: () {},
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
}
