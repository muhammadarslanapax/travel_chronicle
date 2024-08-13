import 'package:flutter/material.dart';
import 'package:travel_chronicle/utilities/app_text_styles.dart';

import '../utilities/app_colors.dart';

class SubscriptionsRowWidget extends StatelessWidget {
  final String heading;
  final String details;
  final String price;
  final VoidCallback onTap;
  final bool? isExclusive;
  const SubscriptionsRowWidget({
    super.key,
    required this.onTap,
    required this.heading,
    required this.details,
    this.isExclusive = false,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
          color: isExclusive == true ? brownColor : skinColor,
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
              heading,
              style: sixteen500TextStyle(
                color: isExclusive == true ? Colors.white : textBrownColor,
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
                        details,
                        style: eleven400TextStyle(
                          color: isExclusive == true
                              ? Colors.white
                              : textBrownColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: twenty500TextStyle(
                        color:
                            isExclusive == true ? Colors.white : textBrownColor,
                      ),
                    ),
                    Text(
                      "One-time charge",
                      style: eleven400TextStyle(
                        color:
                            isExclusive == true ? Colors.white : textBrownColor,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
