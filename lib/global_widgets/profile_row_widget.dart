import 'package:flutter/material.dart';
import 'package:travel_chronicle/utilities/app_colors.dart';

import '../utilities/app_text_styles.dart';

class ProfileRowWidget extends StatelessWidget {
  final String heading;
  final String description;
  final VoidCallback? onTap;
  final bool? isPassword;
  const ProfileRowWidget({
    super.key,
    required this.heading,
    required this.description,
    this.onTap,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: twenty600TextStyle(color: textBrownColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  description,
                  style: sixteen500TextStyle(color: textBrownColor),
                ),
              ],
            ),
          ),
          isPassword == true
              ? Text(
                  "Change",
                  style: sixteen500TextStyle(color: redColor),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
