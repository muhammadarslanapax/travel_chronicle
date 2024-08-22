// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:travel_chronicle/provider/location_provider.dart';

import '../../data/locator.dart';
import '../../data/model/user_model.dart';
import '../../global_widgets/button_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../../provider/user_provider.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/app_routes.dart';
import '../../utilities/app_text_styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var emailController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var nameController = TextEditingController();
  bool obscureText = true;
  bool obscureText2 = true;
  var passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<LocationProvider>().checkAndRequestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
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
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: const DecorationImage(
                        image: AssetImage("assets/logo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Sign up with your email!",
                    style: twentyFive600TextStyle(color: textBrownColor),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        TextFieldWidget(
                          textInputAction: TextInputAction.next,
                          hintText: "Enter Your Name",
                          textFieldController: nameController,
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          textInputAction: TextInputAction.next,
                          hintText: "Enter Your Email",
                          textFieldController: emailController,
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          textInputAction: TextInputAction.next,
                          hintText: "Password",
                          textFieldController: passwordController,
                          obscureText: obscureText,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              obscureText = !obscureText;
                              setState(() {});
                            },
                            child: Icon(
                              obscureText == true ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                              color: Colors.grey,
                              size: 25,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          hintText: "Confirm Password",
                          textFieldController: confirmPasswordController,
                          obscureText: obscureText2,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              obscureText2 = !obscureText2;
                              setState(() {});
                            },
                            child: Icon(
                              obscureText2 == true ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                              color: Colors.grey,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  BigButton(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 45,
                    text: "SIGN UP",
                    onTap: () {
                      createAccountWithEmailAndPassword(context);
                    },
                    textStyle: eighteenBoldTextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, loginScreenRoute);
                    },
                    child: Text(
                      "Already have an account? Login",
                      style: fourteen500TextStyle(
                        color: textBrownColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  createAccountWithEmailAndPassword(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final password = passwordController.text;
      final confirmPassword = confirmPasswordController.text;
      final email = emailController.text;
      final userName = nameController.text;
      final country = context.read<LocationProvider>().address.country;
      final city = context.read<LocationProvider>().address.city;

      if (confirmPassword.contains(password)) {
        await userRepository.signUp(email, password).then((value) async {
          final user = userRepository.getCurrentUser();
          if (user != null) {
            UserModel localUser = UserModel(
              userId: user.uid,
              userEmail: email,
              userName: userName,
              accountStatus: true,
              userImg: '',
              country: country,
              city: city,
              cloudSubscription: false,
              extraPhotoSubscription: false,
              allSubscription: false,
              exportPdfSubscription: false,
              skinColorSubscription: false,
              unlimitedTripSubscription: false,
              unlockPassportSubscription: false,
            );
            await userRepository.add(localUser).then((value) async {
              await context.read<UserProvider>().updateFirebaseUser();
              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(context, homeScreenRoute, (route) => false);
              }
            });
          }
        });
      } else {
        EasyLoading.showError('Password does not Match');
      }
    }
  }
}
