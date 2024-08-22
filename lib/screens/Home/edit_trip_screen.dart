import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travel_chronicle/data/localDB/event/event_model.dart';
import 'package:travel_chronicle/data/localDB/local_db.dart';
import 'package:travel_chronicle/data/locator.dart';
import 'package:travel_chronicle/models/event_model.dart';
import 'package:travel_chronicle/provider/edit_provider.dart';
import 'package:travel_chronicle/provider/passport_provider.dart';
import 'package:travel_chronicle/provider/stapm_provider.dart';
import 'package:travel_chronicle/provider/user_provider.dart';
import 'package:travel_chronicle/utilities/date_formeter.dart';
import 'package:travel_chronicle/utilities/validator.dart';

import '../../global_widgets/app_bar_widget.dart';
import '../../global_widgets/button_widget.dart';
import '../../global_widgets/smallest_text_field_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/app_routes.dart';
import '../../utilities/app_text_styles.dart';

class EditTripScreen extends StatefulWidget {
  const EditTripScreen({super.key});

  @override
  State<EditTripScreen> createState() => _EditTripScreenState();
}

class _EditTripScreenState extends State<EditTripScreen> {
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

  EventModel? _eventModel;

  @override
  void initState() {
    final provider = context.read<EditProvider>();

    _eventModel = context.read<EditProvider>().eventModel;
    titleController.text = _eventModel!.tripName!;
    cityController.text = _eventModel!.placeName!;
    countryController.text = _eventModel!.name;
    imageTitleController.text = _eventModel!.imageTitle!;
    startDateController.text = formatDateFromMilliseconds(_eventModel!.dateStart);
    endDateController.text = formatDateFromMilliseconds(_eventModel!.dateEnd!);
    hotelController.text = _eventModel!.hotelName.toString();
    companionsController.text = _eventModel!.companionsNames!.join(",");
    descriptionsController.text = _eventModel!.aboutTrip!;
    provider.setImageUrls(_eventModel!.images); // Set existing URLs

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: skinColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarWidget(text: "Edit Trip"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldWidget(
                      hintText: "Trip Title (Optional)",
                      textFieldController: titleController,
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFieldWidget(
                            validator: (val) {
                              return Validator.validateTextField(val);
                            },
                            hintText: "City",
                            textFieldController: cityController,
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
                            validator: (val) {
                              return Validator.validateTextField(val);
                            },
                            hintText: "Country",
                            textFieldController: countryController,
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
                            validator: (val) {
                              return Validator.validateTextField(val);
                            },
                            hintText: "Start Date",
                            textFieldController: startDateController,
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
                            validator: (val) {
                              return Validator.validateTextField(val);
                            },
                            hintText: "End Date",
                            textFieldController: endDateController,
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < context.read<EditProvider>().imagesUrl.length; i++)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // pickImage();
                                  },
                                  child: Consumer<EditProvider>(
                                    builder: (BuildContext context, provider, Widget? child) {
                                      if (context.read<UserProvider>().localUser != null &&
                                          context.read<UserProvider>().localUser!.cloudSubscription == true) {
                                        return Container(
                                          width: i == 0 ? 85 : 65,
                                          height: i == 0 ? 85 : 65,
                                          margin: const EdgeInsets.only(right: 15),
                                          decoration: provider.imagesUrl.length < i + 1
                                              ? BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  color: Colors.grey[600],
                                                )
                                              : BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  image: DecorationImage(
                                                    image: NetworkImage(provider.imagesUrl[i]),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                          // child: GestureDetector(
                                          //   onTap: () {
                                          //     context.read<EditProvider>().removeImageUrl(i);

                                          //     // if (provider.images.length > i) {
                                          //     //   provider.removeImages(i);
                                          //     // }
                                          //   },
                                          //   child: Center(
                                          //     child: Icon(
                                          //       provider.imagesUrl.length < i + 1 ? Icons.add : Icons.delete_forever,
                                          //       color: provider.imagesUrl.length < i + 1 ? Colors.white : Colors.red,
                                          //     ),
                                          //   ),

                                          // ),
                                        );
                                      } else {
                                        return Container(
                                          width: i == 0 ? 85 : 65,
                                          height: i == 0 ? 85 : 65,
                                          margin: const EdgeInsets.only(right: 15),
                                          decoration: provider.imagesUrl.length < i + 1
                                              ? BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  color: Colors.grey[600],
                                                )
                                              : BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  image: DecorationImage(
                                                    image: FileImage(File(provider.imagesUrl[i])),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                          // child: GestureDetector(
                                          //   onTap: () {
                                          //     context.read<EditProvider>().removeImageUrl(i);

                                          //     // if (provider.images.length > i) {
                                          //     //   provider.removeImages(i);
                                          //     // }
                                          //   },
                                          //   child: Center(
                                          //     child: Icon(
                                          //       provider.imagesUrl.length < i + 1 ? Icons.add : Icons.delete_forever,
                                          //       color: provider.imagesUrl.length < i + 1 ? Colors.white : Colors.red,
                                          //     ),
                                          //   ),

                                          // ),
                                        );
                                      }
                                    },
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
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldWidget(
                      validator: (val) {
                        return Validator.validateTextField(val);
                      },
                      hintText: "Description",
                      maxCharacters: 400,
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
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        // Text(
                        //   "OR",
                        //   style: fourteen700TextStyle(
                        //     color: textBrownColor,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        // Expanded(
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       Navigator.pushNamed(
                        //           context, stampSelectionScreenRoute);
                        //     },
                        //     child: Container(
                        //       color: Colors.transparent,
                        //       child: Column(
                        //         children: [
                        //           Image.asset(
                        //             "assets/dummyStampImage.png",
                        //             width: 30,
                        //             height: 30,
                        //           ),
                        //           const SizedBox(
                        //             height: 10,
                        //           ),
                        //           Text(
                        //             "Get Travel Chronicle Stamp",
                        //             style: fourteen500TextStyle(
                        //                 color: textBrownColor),
                        //             textAlign: TextAlign.center,
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BigButton(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 45,
                      text: "SAVE TRIP",
                      onTap: () {
                        _updateTripRequest(context, _eventModel!.timestamp.toString());
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
          ],
        ),
      ),
    );
  }

  int? selectedStartDate;
  int? selectedEndDate;

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

  void showCalendarDialog(BuildContext context) {
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
        context.read<EditProvider>().setImages(File(pickedFile.path));
      });
    }
  }

  Future<void> _updateTripRequest(BuildContext context, String evenId) async {
    if (formKey.currentState!.validate()) {
      if (context.read<UserProvider>().localUser != null &&
          context.read<UserProvider>().localUser!.cloudSubscription == true) {
        editEventAPi(context, evenId);
      } else {
        editEventLocal(context, evenId);
      }
    }
  }

  editEventAPi(BuildContext context, String evenId) async {
    EasyLoading.show(status: "Loading..");
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String name = titleController.text;
    String placeName = cityController.text;
    String title = imageTitleController.text;
    String tripName = titleController.text;
    String location = '${cityController.text}, ${countryController.text}';
    int dateStart = selectedStartDate ?? _eventModel!.dateStart;
    int dateEnd = selectedEndDate ?? _eventModel!.dateEnd!;
    String hotelName = hotelController.text;
    List<String> companionsNames = companionsController.text.split(',');
    String aboutTrip = descriptionsController.text;
    String stamp = context.read<StampProvider>().stemp ?? context.read<PassportProvider>().stemp ?? '';

    List<String> imagesUploaded = context.read<EditProvider>().imagesUrl;
    EventModel updatedEvent = EventModel(
        timestamp: _eventModel!.timestamp,
        name: name,
        images: imagesUploaded,
        placeName: placeName,
        userName: storage.user!.userName,
        userId: storage.user!.userId,
        userImage: storage.user!.userImg,
        userLocation: storage.user!.city.toString() + storage.user!.country.toString(),
        tripName: tripName,
        location: location,
        dateStart: dateStart,
        dateEnd: dateEnd,
        hotelName: hotelName,
        companionsNames: companionsNames,
        aboutTrip: aboutTrip,
        stamp: stamp,
        imageTitle: title);

    context.read<EditProvider>().updateEvent(context, updatedEvent, _eventModel!.timestamp.toString());
  }

  editEventLocal(BuildContext context, String evenId) {
    EasyLoading.show(status: "Loading..");
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String name = titleController.text;
    String placeName = cityController.text;
    String title = imageTitleController.text;
    String tripName = titleController.text;
    String location = '${cityController.text}, ${countryController.text}';
    int dateStart = selectedStartDate ?? _eventModel!.dateStart;
    int dateEnd = selectedEndDate ?? _eventModel!.dateEnd!;
    String hotelName = hotelController.text;
    List<String> companionsNames = companionsController.text.split(',');
    String aboutTrip = descriptionsController.text;
    String stamp = context.read<StampProvider>().stemp ?? context.read<PassportProvider>().stemp ?? '';

    List<String> imagesUploaded = context.read<EditProvider>().imagesUrl;
    EventLocalDBModel updatedEvent = EventLocalDBModel(
        timestamp: _eventModel!.timestamp,
        name: name,
        images: imagesUploaded,
        placeName: placeName,
        userName: storage.user!.userName,
        userId: storage.user!.userId,
        userImage: storage.user!.userImg,
        userLocation: storage.user!.city.toString() + storage.user!.country.toString(),
        tripName: tripName,
        location: location,
        dateStart: dateStart,
        dateEnd: dateEnd,
        hotelName: hotelName,
        companionsNames: companionsNames,
        aboutTrip: aboutTrip,
        stamp: stamp,
        imageTitle: title);

    context.read<EditProvider>().editEventLocal(context, updatedEvent, timestamp);
  }
}
