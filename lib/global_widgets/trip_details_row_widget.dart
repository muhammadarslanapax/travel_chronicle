import 'package:flutter/material.dart';

import '../utilities/app_colors.dart';
import '../utilities/app_text_styles.dart';

class TripDetailsRowWidget extends StatelessWidget {
  final String text;
  final IconData image;
  const TripDetailsRowWidget({
    super.key,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          image,
          size: 20,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: eleven400TextStyle(color: textBrownColor),
        )
      ],
    );
  }
}
