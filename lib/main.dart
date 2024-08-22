import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:travel_chronicle/data/localDB/event/event_model.dart';
import 'package:travel_chronicle/data/purchase_api.dart';
import 'package:travel_chronicle/provider/change_password_provider.dart';
import 'package:travel_chronicle/provider/delete_provider.dart';
import 'package:travel_chronicle/provider/edit_provider.dart';
import 'package:travel_chronicle/provider/home_provider.dart';
import 'package:travel_chronicle/provider/location_provider.dart';
import 'package:travel_chronicle/provider/passport_provider.dart';
import 'package:travel_chronicle/provider/stapm_provider.dart';
import 'package:travel_chronicle/provider/user_provider.dart';
import 'package:travel_chronicle/screens/Authentication/forgot_password_screen.dart';
import 'package:travel_chronicle/screens/Authentication/login_screen.dart';
import 'package:travel_chronicle/screens/Authentication/signup_screen.dart';
import 'package:travel_chronicle/screens/Authentication/splash_screen.dart';
import 'package:travel_chronicle/screens/Home/ad/ad_state.dart';
import 'package:travel_chronicle/screens/Home/add_trip_screen.dart';

import 'package:travel_chronicle/screens/Home/edit_trip_screen.dart';
import 'package:travel_chronicle/screens/Home/home_screen.dart';
import 'package:travel_chronicle/screens/Home/passport_book_screen.dart';
import 'package:travel_chronicle/screens/Home/print_trip_screen.dart';
import 'package:travel_chronicle/screens/Home/stamp_selection_screen.dart';
import 'package:travel_chronicle/screens/Home/trip_detail_screen.dart';
import 'package:travel_chronicle/screens/ProfileScreens/edit_profile_screen.dart';
import 'package:travel_chronicle/screens/ProfileScreens/profile_screen.dart';
import 'package:travel_chronicle/screens/SettingsScreens/change_password_screen.dart';
import 'package:travel_chronicle/screens/SettingsScreens/language_screen.dart';
import 'package:travel_chronicle/screens/SettingsScreens/settings_screen.dart';
import 'package:travel_chronicle/screens/SettingsScreens/subscription_detail_screen.dart';
import 'package:travel_chronicle/screens/SettingsScreens/subscription_screen.dart';
import 'package:travel_chronicle/utilities/app_routes.dart';

import 'data/locator.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(EventLocalDBModelAdapter());

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAcFE_gXxgPote-HUN7UK6Vu9zz-h6KsWc",
      appId: "1:933061962046:android:9e81c1d83151fcca25a46f",
      messagingSenderId: "933061962046",
      projectId: "travel-journal-app-360ac",
      storageBucket: "travel-journal-app-360ac.appspot.com",
    ),
  );
  DependencyInjectionEnvironment.setup();
  await storage.init();
  await PurchaseApi.initPlatformState();

  runApp( Provider.value(
    value: adState,
    builder: (context, child) => const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => StampProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => EditProvider()),
        ChangeNotifierProvider(create: (_) => DeleteProvider()),
        ChangeNotifierProvider(create: (_) => PassportProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => ChangePasswordProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
        ),
        initialRoute: splashScreenRoute,
        builder: EasyLoading.init(),
        routes: {
          splashScreenRoute: (context) => const SplashScreen(),
          loginScreenRoute: (context) => const LoginScreen(),
          signUpScreenRoute: (context) => const SignUpScreen(),
          forgotPasswordScreenRoute: (context) => const ForgotPasswordScreen(),
          homeScreenRoute: (context) => const HomeScreen(),
          addTripScreenRoute: (context) => const AddTripScreen(),
          editTripScreenRoute: (context) => const EditTripScreen(),
          passportBookScreenRoute: (context) => const PassportBookScreen(),
          printTripScreenRoute: (context) => const PrintTripScreen(),
          stampSelectionScreenRoute: (context) => const StampSelectionScreen(),
          tripDetailsScreenRoute: (context) => const TripDetailsScreen(),
          profileScreenRoute: (context) => const ProfileScreen(),
          editProfileScreenRoute: (context) => const EditProfileScreen(),
          settingsScreenRoute: (context) => const SettingsScreen(),
          changePasswordScreenRoute: (context) => const ChangePasswordScreen(),
          languagesScreenRoute: (context) => const LanguageScreen(),
          subscriptionScreenRoute: (context) => const SubscriptionScreen(),
          subscriptionDetailsScreenRoute: (context) => const SubscriptionDetailScreen(),
        },
      ),
    );
  }
}
