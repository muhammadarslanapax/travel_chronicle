// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:travel_chronicle/utilities/validator.dart';

import '../../data/locator.dart';
import '../../global_widgets/app_bar_widget.dart';
import '../../global_widgets/button_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../../provider/user_provider.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/app_text_styles.dart';
import '../../utilities/bottom_sheet_image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var cityController = TextEditingController();
  var countryController = TextEditingController();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    nameController.text = storage.user!.userName;
    countryController.text = storage.user!.country ?? "";
    cityController.text = storage.user!.city ?? "";
    setState(() {});
    super.initState();
  }

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
                  child: const Column(
                    children: [
                      AppBarWidgetWhite(text: "Edit Profile"),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      editImage(context);
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: storage.user!.userImg == ""
                          ? const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            )
                          : BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                  storage.user!.userImg,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                      child: Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.6),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/cameraIcon.png",
                              scale: 4,
                            ),
                          ),
                        ),
                      ),
                    ),
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    TextFieldWidget(
                      hintText: "Enter Your Name",
                      textFieldController: nameController,
                      obscureText: false,
                      validator: (value) {
                        return Validator.nameValidator(value);
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldWidget(
                      hintText: "Enter Your City (Optional)",
                      textFieldController: cityController,
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldWidget(
                      hintText: "Enter Your Country",
                      textFieldController: countryController,
                      obscureText: false,
                      validator: (value) {
                        return Validator.nameValidator(value);
                      },
                    ),
                    const Spacer(),
                    BigButton(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 45,
                      text: "SAVE",
                      onTap: () {
                        updateUser(context);
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
        ],
      ),
    );
  }

  Future<void> updateUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: "Loading...");

      await userRepository.update(storage.user!.userId,
          {"country": countryController.text.toString(), "city": cityController.text.toString()}).then((value) async {
        await context.read<UserProvider>().updateFirebaseUser();
        EasyLoading.showSuccess("Profile Updated!");

        EasyLoading.dismiss();
        Navigator.pop(context);
      });
    }
  }

  Future<void> editImage(BuildContext context) async {
    await _checkPermission(context);
  }

  Future<void> _checkPermission(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (Platform.isIOS) {
      PermissionStatus permission;
      permission = await Permission.storage.request();
      if (permission.isGranted) {
        BottomSheets.showMultipleImagesPickerBottomSheet(context, pickImageFromGallery, pickImage);
      } else {
        await openAppSettings();
      }

      if (permission.isPermanentlyDenied || permission.isDenied) {
        await openAppSettings();
      }
    } else {
      await BottomSheets.showMultipleImagesPickerBottomSheet(context, pickImageFromGallery, pickImage);
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      setState(() {
        _imageFile = imageFile;
      });
      if (_imageFile != null) {
        Navigator.pop(context);
        EasyLoading.show(status: "Loading...");

        await userRepository.update(
            storage.user!.userId, {"userImg": await userRepository.uploadFile(_imageFile!)}).then((value) async {
          await context.read<UserProvider>().updateFirebaseUser();
          EasyLoading.showSuccess("Profile Picture Updated!");
          setState(() {});
          _imageFile = null;
          EasyLoading.dismiss();
        });
      }
    }
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Navigator.pop(context);
      File imageFile = File(pickedFile.path);
      setState(() {
        _imageFile = imageFile;
      });
      if (_imageFile != null) {
        EasyLoading.show(status: "Loading...");

        await userRepository.update(
            storage.user!.userId, {"userImg": await userRepository.uploadFile(_imageFile!)}).then((value) async {
          await context.read<UserProvider>().updateFirebaseUser();
          EasyLoading.showSuccess("Profile picture updated!");
          setState(() {});
          _imageFile = null;
          EasyLoading.dismiss();
        });
      }
    }
  }
}
