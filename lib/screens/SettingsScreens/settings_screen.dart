// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global_widgets/app_bar_widget.dart';
import '../../global_widgets/settings_row_widget.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/app_routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: skinColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarWidget(text: "Settings"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SettingsRowWidget(
                    image: Icons.person,
                    text: "My Account",
                    onTap: () {
                      Navigator.pushNamed(context, profileScreenRoute);
                    },
                  ),
                  SettingsRowWidget(
                    image: Icons.shopping_cart_outlined,
                    text: "Shop",
                    onTap: () {
                      Navigator.pushNamed(context, subscriptionScreenRoute);
                    },
                  ),
                  SettingsRowWidget(
                    image: Icons.translate,
                    text: "Languages",
                    onTap: () {
                      Navigator.pushNamed(context, languagesScreenRoute);
                    },
                  ),
                  SettingsRowWidget(
                    image: Icons.info_outline,
                    text: "Terms of Service",
                    onTap: () {
                      launchTermsOfServiceURL();
                    },
                  ),
                  SettingsRowWidget(
                    image: Icons.privacy_tip_outlined,
                    text: "Privacy Policy",
                    onTap: () {
                      launchPrivacyPolicyURL();
                    },
                  ),
                  SettingsRowWidget(
                    image: CupertinoIcons.globe,
                    text: "Visit our Website",
                    onTap: () {
                      launchVisitOurWebsiteURL();
                    },
                  ),
                  SettingsRowWidget(
                    image: Icons.email_outlined,
                    text: "Help & Support",
                    onTap: () {
                      launchHelpAndSupportURL();
                    },
                  ),
                  SettingsRowWidget(
                    image: Icons.share,
                    text: "Share on Socials",
                    onTap: () {
                      shareApp();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void launchTermsOfServiceURL() async {
    const url = 'http://tokagames.co/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchPrivacyPolicyURL() async {
    const url = 'http://tokagames.co/termsService.html';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchVisitOurWebsiteURL() async {
    const url = 'http://tokagames.co/PrivacyPolicy.html';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchHelpAndSupportURL() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: "info@tokagames.co",
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }

  void shareApp() {
    const String playStoreLink =
        'https://play.google.com/store/apps/details?id=com.deviicktechnologies.travel_chronicle';
    const String message = 'Check out this awesome app! Download it here: $playStoreLink';

    Share.share(message);
  }
}
