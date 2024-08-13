// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travel_chronicle/data/locator.dart';
import 'package:travel_chronicle/provider/stapm_provider.dart';
import 'package:travel_chronicle/provider/user_provider.dart';
import 'package:travel_chronicle/utilities/app_colors.dart';
import 'package:travel_chronicle/utilities/app_routes.dart';
import 'package:travel_chronicle/utilities/app_text_styles.dart';
import 'package:travel_chronicle/utilities/validator.dart';

import '../../data/event_repo/event_api.dart';
import '../../global_widgets/app_bar_widget.dart';
import '../../global_widgets/button_widget.dart';
import '../../global_widgets/smallest_text_field_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../../models/event_model.dart';

class AddTripScreen extends StatefulWidget {
  const AddTripScreen({super.key});

  @override
  State<AddTripScreen> createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  var titleController = TextEditingController();
  var cityController = TextEditingController();
  var countryController = TextEditingController();
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();
  var hotelController = TextEditingController();
  var companionsController = TextEditingController();
  var descriptionsController = TextEditingController();
  var imageTitleController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<File> images = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: skinColor,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AppBarWidget(text: "Create New Trip"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldWidget(
                      hintText: "Trip Title (Optional)",
                      textFieldController: titleController,
                      obscureText: false,
                      validator: Validator.validateTextField,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFieldWidget(
                            hintText: "City",
                            textFieldController: cityController,
                            validator: Validator.validateTextField,
                            obscureText: false,
                            prefixIcon: Image.asset(
                              "assets/buildingIcon.png",
                              scale: 4,
                              width: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextFieldWidget(
                            hintText: "Country",
                            textFieldController: countryController,
                            validator: Validator.validateTextField,
                            obscureText: false,
                            prefixIcon: Image.asset(
                              "assets/globeIcon.png",
                              scale: 4,
                              width: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFieldWidget(
                            hintText: "Start Date",
                            textFieldController: startDateController,
                            validator: Validator.validateTextField,
                            obscureText: false,
                            prefixIcon: Image.asset(
                              "assets/calendarIcon.png",
                              scale: 4,
                              width: 10,
                              color: Colors.grey,
                            ),
                            onTap: () {
                              showCalendarDialogStart(context);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextFieldWidget(
                            hintText: "End Date",
                            textFieldController: endDateController,
                            validator: Validator.validateTextField,
                            obscureText: false,
                            onTap: () {
                              showCalendarDialogEnd(context);
                            },
                            prefixIcon: Image.asset(
                              "assets/calendarIcon.png",
                              scale: 4,
                              width: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldWidget(
                      hintText: "Hotel (Optional)",
                      textFieldController: hotelController,
                      obscureText: false,
                      prefixIcon: Image.asset(
                        "assets/hotelIcon.png",
                        scale: 4,
                        width: 10,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldWidget(
                      hintText: "Companions (Optional)",
                      textFieldController: companionsController,
                      obscureText: false,
                      prefixIcon: Image.asset(
                        "assets/peopleIcon.png",
                        scale: 4,
                        width: 10,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Upload Photos",
                      style: fourteen500TextStyle(color: textBrownColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<UserProvider>(
                      builder: (BuildContext context, provider, Widget? child) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              for (int i = 0; i < 5; i++)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (provider.localUser!.premium == false) {
                                          if (images.length != 1) {
                                            pickImage();
                                          } else {
                                            EasyLoading.showInfo("Please buy subscription for more then 1 image!");
                                          }
                                        } else {
                                          pickImage();
                                        }
                                      },
                                      child: Container(
                                        width: i == 0 ? 85 : 65,
                                        height: i == 0 ? 85 : 65,
                                        margin: const EdgeInsets.only(right: 15),
                                        decoration: images.length < i + 1
                                            ? BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                color: Colors.grey[600],
                                              )
                                            : BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                  image: FileImage(images[i]),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (images.length > i) {
                                              images.removeAt(i);
                                              setState(() {});
                                            }
                                          },
                                          child: Center(
                                            child: Icon(
                                              size: 18,
                                              images.length < i + 1 ? Icons.add : Icons.delete_forever,
                                              color: images.length < i + 1 ? Colors.white : Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: i == 0 ? 10 : 0,
                                    ),
                                    i == 0
                                        ? SizedBox(
                                            width: 80,
                                            height: 20,
                                            child: SmallestTextFieldWidget(
                                                textFieldController: imageTitleController,
                                                hintText: "Title (Optional)",
                                                obscureText: false),
                                          )
                                        : const SizedBox(
                                            height: 30,
                                          ),
                                  ],
                                )
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldWidget(
                      hintText: "Description",
                      maxCharacters: 400,
                      validator: Validator.validateTextField,
                      textFieldController: descriptionsController,
                      obscureText: false,
                      prefixIcon: Container(
                        padding: const EdgeInsets.only(bottom: 60),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/editPencilIcon.png",
                              scale: 4,
                              width: 25,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      maxLines: 4,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, stampSelectionScreenRoute);
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Consumer<StampProvider>(
                                builder: (BuildContext context, provider, Widget? child) {
                                  if (provider.stemp != null) {
                                    return Image.network(
                                      provider.stemp!,
                                      width: 100,
                                      height: 100,
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        Image.asset(
                                          "assets/passportIcon.png",
                                          width: 30,
                                          height: 30,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Add a travel stamp",
                                          style: fourteen500TextStyle(color: textBrownColor),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BigButton(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 45,
                      text: "CREATE TRIP",
                      onTap: () {
                        createTripRequest();
                      },
                      textStyle: eighteenBoldTextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCalendarDialogStart(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width * 0.9,
            height: 420,
            decoration: BoxDecoration(
              color: yellowColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: DateTime(
                  DateTime.now().year - 5,
                  DateTime.now().month,
                  DateTime.now().day,
                ),
                lastDay: DateTime(
                  DateTime.now().year + 5,
                  DateTime.now().month,
                  DateTime.now().day,
                ),
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  leftChevronIcon: Icon(
                    Icons.arrow_back_ios,
                    size: 15,
                    color: Colors.black,
                  ),
                  rightChevronIcon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 15,
                  ),
                ),
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: skinColor,
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: TextStyle(
                    color: textBrownColor,
                  ),
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    selectedStartDate = selectedDay.millisecondsSinceEpoch;
                    startDateController.text = selectedDay.toIso8601String().split('T').first;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void showCalendarDialogEnd(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width * 0.9,
            height: 420,
            decoration: BoxDecoration(
              color: yellowColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: DateTime(
                  DateTime.now().year - 5,
                  DateTime.now().month,
                  DateTime.now().day,
                ),
                lastDay: DateTime(
                  DateTime.now().year + 5,
                  DateTime.now().month,
                  DateTime.now().day,
                ),
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  leftChevronIcon: Icon(
                    Icons.arrow_back_ios,
                    size: 15,
                    color: Colors.black,
                  ),
                  rightChevronIcon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 15,
                  ),
                ),
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: skinColor,
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: TextStyle(
                    color: textBrownColor,
                  ),
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    selectedEndDate = selectedDay.millisecondsSinceEpoch;
                    endDateController.text = selectedDay.toIso8601String().split('T').first;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 5);

    if (pickedFile != null) {
      setState(() {
        images.add(File(pickedFile.path));
      });
    }
  }

  int? selectedStartDate;
  int? selectedEndDate;

  createTripRequest() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show(status: "Loading..");
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      String name = titleController.text;
      String placeName = cityController.text;
      String tripName = titleController.text;
      String location = '${cityController.text}, ${countryController.text}';
      int dateStart = selectedStartDate ?? DateTime.now().millisecondsSinceEpoch;
      int dateEnd = selectedEndDate ?? DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch;
      String hotelName = hotelController.text;
      List<String> companionsNames = companionsController.text.split(',');
      String aboutTrip = descriptionsController.text;
      String stamp = context.read<StampProvider>().stemp ?? '';
      String title = imageTitleController.text;

      List<String> imagesUploaded = await uploadImagesToFirebase(images);
      EventModel newEvent = EventModel(
          timestamp: timestamp,
          name: name,
          images: imagesUploaded,
          placeName: placeName,
          userName: storage.user!.userName,
          userId: storage.user!.userId,
          userImage: storage.user!.userImg,
          userLocation: "${storage.user!.city}, ${storage.user!.country}",
          tripName: tripName,
          location: location,
          dateStart: dateStart,
          dateEnd: dateEnd,
          hotelName: hotelName,
          companionsNames: companionsNames,
          aboutTrip: aboutTrip,
          stamp: stamp,
          imageTitle: title);

      try {
        await eventRepository.saveEvent(newEvent, timestamp.toString());
        EasyLoading.showSuccess("Trip created successfully!");
        Navigator.pushNamedAndRemoveUntil(context, homeScreenRoute, (route) => false);
      } catch (e) {
        EasyLoading.showError('Failed to create trip: $e');
      }
    }
  }
}
