import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_chronicle/provider/user_provider.dart';
import 'package:travel_chronicle/utilities/app_colors.dart';

import '../../data/locator.dart';
import '../../utilities/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashNavigator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBrownColor,
      body: Center(
        child: Image.asset(
          "assets/logoWithText.png",
          scale: 4,
        ),
      ),
    );
  }

  splashNavigator() {
    Timer(
      const Duration(seconds: 5),
      () {
        if (storage.user != null) {
          Navigator.pushNamedAndRemoveUntil(context, homeScreenRoute, (route) => false);
          context.read<UserProvider>().updateUser(storage.user!);
        } else {
          Navigator.pushNamedAndRemoveUntil(context, homeScreenRoute, (route) => false);
        }
      },
    );
  }
}
