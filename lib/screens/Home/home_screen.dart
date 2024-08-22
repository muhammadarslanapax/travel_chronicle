import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:travel_chronicle/data/locator.dart';
import 'package:travel_chronicle/provider/home_provider.dart';
import 'package:travel_chronicle/provider/location_provider.dart';
import 'package:travel_chronicle/provider/user_provider.dart';
import 'package:travel_chronicle/screens/Home/ad/banner_ad.dart';
import 'package:travel_chronicle/utilities/app_colors.dart';
import 'package:travel_chronicle/utilities/app_routes.dart';
import 'package:travel_chronicle/utilities/app_text_styles.dart';

import '../../global_widgets/events_home_widget.dart';

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
    context.read<LocationProvider>().checkAndRequestPermission();
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
                    child: Consumer<UserProvider>(
                      builder: (context, provider, child) {
                        if (provider.localUser != null) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 68,
                              ),
                              Text(
                                storage.user!.userName,
                                style: fifteen700TextStyle(
                                  color: textBrownColor,
                                ),
                              ),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              Text(
                                "${storage.user!.city ?? ""}, ${storage.user!.country ?? "No Location Added"}",
                                style: thirteen400SpacedTextStyle(
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
                                            if (context.read<UserProvider>().localUser != null &&
                                                context.read<UserProvider>().localUser!.cloudSubscription &&
                                                context.read<UserProvider>().localUser!.unlockPassportSubscription) {
                                              Navigator.pushNamed(context, passportBookScreenRoute);
                                            } else {
                                              EasyLoading.showInfo(
                                                  "please buy Unlock Passport Book Subscription first!");
                                            }
                                          },
                                          child: Image.asset(
                                            "assets/passportIcon.png",
                                            scale: 6,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
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
                          );
                        } else {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 68,
                              ),
                              Text(
                                "Mr ABC",
                                style: fifteen700TextStyle(
                                  color: textBrownColor,
                                ),
                              ),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              Text(
                                "${context.watch<LocationProvider>().address.city}, ${context.watch<LocationProvider>().address.country}",
                                style: thirteen400SpacedTextStyle(
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
                                          width: 20,
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
                          );
                        }
                      },
                    )),
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
                                fit: BoxFit.cover),
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
                                  "assets/profile.png",
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
        

          const BannerAD(),
        ],
      ),
    );
  }
}
