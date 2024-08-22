// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_chronicle/provider/user_provider.dart';

import '../../global_widgets/button_widget.dart';
import '../../global_widgets/profile_row_widget.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/app_routes.dart';
import '../../utilities/app_text_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: skinColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 220,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 170,
                  decoration: const BoxDecoration(
                    color: brownColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      loginScreenRoute,
                                      (route) => false,
                                    ).then((val) {
                                      context.read<UserProvider>().logout();
                                    });
                                  },
                                  child: const SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Center(
                                      child: Icon(
                                        Icons.logout,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Text(
                              "My Profile",
                              style: sixteen600TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
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
                              image: NetworkImage(provider.localUser!.userImg),
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
                                  "assets/profile.png",
                                ),
                              ),
                            ));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Consumer<UserProvider>(
                builder: (BuildContext context, provider, Widget? child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileRowWidget(
                        heading: "Name",
                        description: provider.localUser!.userName,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProfileRowWidget(
                        heading: "Email",
                        description: provider.localUser!.userEmail,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProfileRowWidget(
                        heading: "Country",
                        description: provider.localUser!.country ?? "No Location Added",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProfileRowWidget(
                        heading: "City",
                        description: provider.localUser!.city ?? "No Location Added",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProfileRowWidget(
                        heading: "Password",
                        description: "******",
                        isPassword: true,
                        onTap: () {
                          Navigator.pushNamed(context, changePasswordScreenRoute);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Spacer(),
                      BigButton(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 45,
                        text: "EDIT PROFILE",
                        onTap: () {
                          Navigator.pushNamed(context, editProfileScreenRoute);
                        },
                        textStyle: eighteenBoldTextStyle(color: Colors.white),
                      ),
                      const Spacer(),
                      // SmallButton(
                      //   width: double.infinity,
                      //   height: 45,
                      //   text: "DELETE PROFILE",
                      //   onTap: () {
                      //     showDeleteConfirmationDialog(context, storage.user!.userId);
                      //   },
                      //   textStyle: eighteenBoldTextStyle(color: Colors.white),
                      //   containerColor: Colors.red,
                      //   borderColor: Colors.transparent,
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Profile"),
          content: const Text("Are you sure you want to delete this Profle? This action cannot be undone."),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
