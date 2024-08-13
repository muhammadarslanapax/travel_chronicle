import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_chronicle/data/locator.dart';
import 'package:travel_chronicle/provider/home_provider.dart';
import 'package:travel_chronicle/provider/user_provider.dart';
import 'package:travel_chronicle/utilities/app_colors.dart';
import 'package:travel_chronicle/utilities/app_routes.dart';
import 'package:travel_chronicle/utilities/app_text_styles.dart';

import '../../global_widgets/events_home_widget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    context.read<HomeProvider>().fetchEvents();
    context.read<HomeProvider>().loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: skinColor,
      body: Column(
        children: [
          SizedBox(
            height: 220,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 170,
                  decoration: BoxDecoration(
                    color: darkSkinColor.withOpacity(0.72),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 68,
                      ),
                      Text(
                        storage.user!.userName,
                        style: thirteenBoldSpacedTextStyle(
                          color: textBrownColor,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${storage.user!.city ?? "" + ","}${storage.user!.country ?? "No Location Added"}",
                        style: eleven400SpacedTextStyle(
                          color: textBrownColor,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Consumer<HomeProvider>(
                              builder: (BuildContext context, provider, Widget? child) {
                                return Text(
                                  "${provider.events.length} Trips",
                                  style: eleven400SpacedTextStyle(
                                    color: textBrownColor,
                                  ),
                                );
                              },
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, passportBookScreenRoute);
                                  },
                                  child: Image.asset(
                                    "assets/passportIcon.png",
                                    scale: 6,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, settingsScreenRoute);
                                  },
                                  child: Image.asset(
                                    "assets/settingsIcon.png",
                                    scale: 4,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 0,
                  right: 0,
                  child: Consumer<UserProvider>(
                    builder: (BuildContext context, provider, Widget? child) {
                      if (provider.localUser != null && provider.localUser!.userImg.isNotEmpty) {
                        return Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                provider.localUser!.userImg,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      } else {
                        return Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/dummyImage.png",
                                ),
                              ),
                            ));
                      }
                    },
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, addTripScreenRoute);
                          },
                          child: Text(
                            "ADD NEW",
                            style: eleven400SpacedTextStyle(
                              color: textBrownColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Consumer<HomeProvider>(
            builder: (context, provider, child) {
              return Expanded(
                child: EventTimeline(events: provider.events),
              );
            },
          ),
          Consumer<HomeProvider>(
            builder: (BuildContext context, provider, Widget? child) {
              if (provider.bannerAd != null) {
                return Container(
                    width: provider.bannerAd!.size.width.toDouble(),
                    height: provider.bannerAd!.size.height.toDouble(),
                    decoration: BoxDecoration(
                      color: darkSkinColor.withOpacity(0.72),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: AdWidget(ad: provider.bannerAd!));
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
