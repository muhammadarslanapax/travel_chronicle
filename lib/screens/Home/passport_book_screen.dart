import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:travel_chronicle/global_widgets/app_bar_widget.dart';
import 'package:travel_chronicle/provider/home_provider.dart';
import 'package:travel_chronicle/provider/passport_provider.dart';
import 'package:travel_chronicle/utilities/app_colors.dart';
import '../../global_widgets/small_button_widget.dart';
import '../../utilities/app_text_styles.dart';

class PassportBookScreen extends StatefulWidget {
  const PassportBookScreen({super.key});

  @override
  State<PassportBookScreen> createState() => _PassportBookScreenState();
}

class _PassportBookScreenState extends State<PassportBookScreen> {

  @override
  void initState() {
    context.read<PassportProvider>().fetchPassports();
    context.read<HomeProvider>().createInterstitialAd();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: skinColor,
      body: Column(
        children: [
          const AppBarWidget(
            text: "Passport Book",
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                      color: skindarkerColor,
                      border: Border.all(
                        color: const Color(0xffAE9C93),
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: darkSkinColor,
                              image: const DecorationImage(
                                image: AssetImage("assets/dummyStampImage.png"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "New Passport stamp is available",
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    SmallButton(
                                      width: 100,
                                      height: 30,
                                      text: "CLAIM",
                                      onTap: () {
                                        _showInterstitialAd();

                                      },
                                      textStyle: eighteenBoldTextStyle(color: Colors.white),
                                      containerColor: brownColor,
                                      borderColor: Colors.transparent,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SmallButton(
                                      width: 100,
                                      height: 30,
                                      text: "DECLINE",
                                      onTap: () {},
                                      textStyle: sixteen600TextStyle(
                                        color: brownColor,
                                      ),
                                      containerColor: Colors.transparent,
                                      borderColor: const Color(0xffAE9C93),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<PassportProvider>(
                    builder: (context, provider, child) {
                      if (provider.passport.isEmpty) {
                        return const Expanded(child: Center(child: CircularProgressIndicator()));
                      }

                      return Expanded(
                          child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: provider.passport.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10, crossAxisSpacing: 10, crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          final image = provider.passport[index];
                          return Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: darkSkinColor,
                              image: DecorationImage(
                                image: NetworkImage(image),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          );
                        },
                      ));
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }



  void _showInterstitialAd() {
    if (context.read<HomeProvider>().interstitialAd == null) {
      if (kDebugMode) {
        print('Warning: attempt to show interstitial before loaded.');
      }
      return;
    }
    context.read<HomeProvider>().interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) => print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        if (kDebugMode) {
          print('$ad onAdDismissedFullScreenContent.');
        }
        ad.dispose();
       context.read<HomeProvider>().  createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        if (kDebugMode) {
          print('$ad onAdFailedToShowFullScreenContent: $error');
        }
        ad.dispose();
        context.read<HomeProvider>().  createInterstitialAd();
      },
    );
    context.read<HomeProvider>().interstitialAd!.show();
    context.read<HomeProvider>().interstitialAd = null;
  }




}
