import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_chronicle/utilities/app_colors.dart';
import 'package:travel_chronicle/utilities/validator.dart';

import '../../global_widgets/app_bar_widget.dart';
import '../../global_widgets/button_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../../utilities/app_text_styles.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool obscureText1 = true;
  bool obscureText2 = true;
  bool obscureText3 = true;
  final TextEditingController _oldPsdController = TextEditingController();
  final TextEditingController _newPsdController = TextEditingController();
  final TextEditingController _configPsdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: skinColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const AppBarWidget(text: "Change Password"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        validator: (value) {
                          return Validator.nameValidator(value);
                        },
                        textFieldController: _oldPsdController,
                        prefixIcon: Image.asset(
                          "assets/lockIcon.png",
                          scale: 4,
                        ),
                        hintText: "Enter old password",
                        obscureText: obscureText1,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            obscureText1 = !obscureText1;
                            setState(() {});
                          },
                          child: Icon(
                            obscureText1 == true ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                            color: Colors.grey,
                            size: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWidget(
                        validator: (value) {
                          return Validator.passwordValidator(value);
                        },
                        textFieldController: _newPsdController,
                        prefixIcon: Image.asset(
                          "assets/lockIcon.png",
                          scale: 4,
                        ),
                        hintText: "Enter new password",
                        obscureText: obscureText2,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            obscureText2 = !obscureText2;
                            setState(() {});
                          },
                          child: Icon(obscureText2 == true ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                              color: Colors.grey, size: 25),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWidget(
                        validator: (value) {
                          return Validator.confirmPasswordValidator(value, _newPsdController.text);
                        },
                        textFieldController: _configPsdController,
                        prefixIcon: Image.asset(
                          "assets/lockIcon.png",
                          scale: 4,
                        ),
                        hintText: "Re enter new password",
                        obscureText: obscureText3,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            obscureText3 = !obscureText3;
                            setState(() {});
                          },
                          child: Icon(
                            obscureText3 == true ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                            color: Colors.grey,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              BigButton(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 45,
                text: "SAVE",
                onTap: () {
                  changePassword(context);
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
    );
  }

  Future<void> changePassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {}
  }
}
