import 'package:flutter/material.dart';

import '../utilities/app_colors.dart';
import '../utilities/app_text_styles.dart';

class AppBarWidget extends StatefulWidget {
  final String text;
  const AppBarWidget({super.key, required this.text});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: darkBrownColor,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Text(
            widget.text,
            style: sixteen600TextStyle(
              color: textBrownColor,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class AppBarWidgetWhite extends StatefulWidget {
  final String text;
  const AppBarWidgetWhite({super.key, required this.text});

  @override
  State<AppBarWidgetWhite> createState() => _AppBarWidgetWhiteState();
}

class _AppBarWidgetWhiteState extends State<AppBarWidgetWhite> {
  @override
  Widget build(BuildContext context) {
    return 
    
    Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Text(
            widget.text,
            style: sixteen600TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  
  
  }
}
