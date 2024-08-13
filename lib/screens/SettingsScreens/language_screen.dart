import 'package:flutter/material.dart';

import '../../global_widgets/app_bar_widget.dart';
import '../../global_widgets/button_widget.dart';
import '../../global_widgets/language_row_widget.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/app_text_styles.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List<String> languages = [
    "English",
    "Germany",
    "French",
    "Russian",
    "Portugal",
    "Spanish",
    "Italian",
    "Chinese",
    "Japanese",
    "Korean",
  ];
  int selectedLanguage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: skinColor,
      body: Column(
        children: [
          const AppBarWidget(text: "Languages"),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < languages.length; i++)
                    LanguageRowWidget(
                      onTap: () {
                        selectedLanguage = i;
                        setState(() {});
                      },
                      isSelected: selectedLanguage == i,
                      languageName: languages[i],
                    ),
                ],
              ),
            ),
          ),
          BigButton(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 45,
            text: "SELECT LANGUAGE",
            onTap: () {
              Navigator.pop(context);
            },
            textStyle: eighteenBoldTextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
