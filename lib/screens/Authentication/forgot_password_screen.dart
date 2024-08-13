// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_chronicle/utilities/validator.dart';

import '../../global_widgets/button_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/app_text_styles.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var emailController = TextEditingController();
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
                    ),
                  ),
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
                    "Forgot your password?",
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
                          validator: (val) {
                            return Validator.emailValidator(val);
                          },
                          hintText: "Enter Your Email",
                          textFieldController: emailController,
                          obscureText: false,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  BigButton(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 45,
                    text: "RESET PASSWORD",
                    onTap: () {
                      onTapToForgot(context);
                    },
                    textStyle: eighteenBoldTextStyle(color: Colors.white),
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

  void onTapToForgot(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        EasyLoading.show();
        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
        EasyLoading.dismiss();
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        emailController.clear();
        EasyLoading.showInfo('Email Sent for Reset Password!');
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          return EasyLoading.showError('No User Found for this Email.');
        }
        return EasyLoading.showError(e.toString());
      }
    }
  }
}
