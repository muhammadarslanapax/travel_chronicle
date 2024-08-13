import 'package:flutter/material.dart';
import 'package:travel_chronicle/utilities/app_text_styles.dart';

import '../utilities/app_colors.dart';

class LanguageRowWidget extends StatelessWidget {
  final String languageName;
  final VoidCallback onTap;
  final bool? isSelected;
  const LanguageRowWidget({
    super.key,
    required this.onTap,
    this.isSelected = false,
    required this.languageName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        margin: const EdgeInsets.only(
          bottom: 20,
          left: 4,
          right: 4,
        ),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              languageName,
              style: sixteen500TextStyle(
                color: textBrownColor,
              ),
            ),
            isSelected == true
                ? Image.asset(
                    "assets/radioIcon.png",
                    scale: 4,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
