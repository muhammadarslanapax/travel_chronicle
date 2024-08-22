// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_chronicle/utilities/validator.dart';

import '../../data/locator.dart';
import '../../global_widgets/button_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../../provider/user_provider.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/app_routes.dart';
import '../../utilities/app_text_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  bool obscureText = true;
  var passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //   },
                  //   child: Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Container(
                  //       width: 30,
                  //       height: 30,
                  //       decoration: BoxDecoration(
                  //         border: Border.all(
                  //           color: darkBrownColor,
                  //         ),
                  //         shape: BoxShape.circle,
                  //       ),
                  //       child: const Center(
                  //         child: Icon(
                  //           Icons.arrow_back,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

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
                    "Welcome back!",
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
                          hintText: "Enter Your Email",
                          textFieldController: emailController,
                          validator: Validator.emailValidator,
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, forgotPasswordScreenRoute);
                      },
                      child: Text(
                        "Forgot Password ?",
                        style: fourteen500TextStyle(
                          color: redColor,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  BigButton(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 45,
                    text: "LOGIN",
                    onTap: () {
                      loginAccount(context);
                    },
                    textStyle: eighteenBoldTextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, signUpScreenRoute);
                    },
                    child: Text(
                      "Don't have an account? Sign Up",
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

  void loginAccount(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final password = passwordController.text;
      final email = emailController.text;

      await userRepository.login(email, password).then((value) async {
        final user = userRepository.getCurrentUser();

        if (user != null) {
          await context.read<UserProvider>().updateFirebaseUser();
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(context, homeScreenRoute, (route) => false);
          }
        }
      });
    }
  }
}
