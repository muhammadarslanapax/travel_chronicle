import 'package:flutter/material.dart';
import 'package:travel_chronicle/utilities/app_text_styles.dart';

import '../utilities/app_colors.dart';

class SettingsRowWidget extends StatelessWidget {
  final IconData image;
  final String text;
  final VoidCallback onTap;
  final double padding;
  const SettingsRowWidget({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
    this.padding = 15,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.symmetric(vertical: padding, horizontal: 15),
        margin: const EdgeInsets.only(bottom: 20),
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
        child: Row(
          children: [
            // Padding(
            //   padding: EdgeInsets.only(
            //       left: image == "assets/shareIcon.png" ? 5 : 0),
            //   child: Image.asset(
            //     image,
            //     color: yellowColor,
            //     width: image == "assets/shareIcon.png" ||
            //             image == "assets/cartIcon.png"
            //         ? 20
            //         : 23,
            //     height: image == "assets/shareIcon.png" ||
            //             image == "assets/cartIcon.png"
            //         ? 20
            //         : 23,
            //   ),
            // ),
            Icon(
              image,
              size: 20,
              color: yellowColor,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              text,
              style: sixteen500TextStyle(color: textBrownColor),
            ),
          ],
        ),
      ),
    );
  }
}
