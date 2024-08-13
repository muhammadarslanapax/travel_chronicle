// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_chronicle/models/event_model.dart';
import 'package:travel_chronicle/provider/delete_provider.dart';
import 'package:travel_chronicle/provider/edit_provider.dart';
import 'package:travel_chronicle/provider/home_provider.dart';
import 'package:travel_chronicle/provider/stapm_provider.dart';
import 'package:travel_chronicle/utilities/app_colors.dart';
import 'package:travel_chronicle/utilities/app_routes.dart';
import 'package:travel_chronicle/utilities/date_formeter.dart';

import '../../global_widgets/trip_details_row_widget.dart';
import '../../utilities/app_text_styles.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({super.key});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final EventModel _eventModel = context.read<HomeProvider>().eventModel!;

    return Scaffold(
      backgroundColor: skinColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 490,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(_eventModel.images[0]),
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
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
                      Text(
                        _eventModel.hotelName!,
                        style: fifteen500TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  _eventModel.images.length > 1
                      ? Container(
                          height: 54,
                          width: 196,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (int i = 1; i < _eventModel.images.length; i++)
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    image: DecorationImage(
                                      image: NetworkImage(_eventModel.images[i]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(_eventModel.userImage!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _eventModel.userName!,
                                    style: twelve600TextStyle(color: textBrownColor),
                                  ),
                                  Text(
                                    _eventModel.userLocation!,
                                    style: eleven400TextStyle(color: textBrownColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 90,
                            child: Consumer<DeleteProvider>(
                              builder: (BuildContext context, provider, Widget? child) {
                                return DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    customButton: SizedBox(
                                      width: 30,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Transform.rotate(
                                          angle: 140 / 90,
                                          child: const Icon(
                                            Icons.keyboard_control_outlined,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'edit',
                                        child: Text('Edit'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'print',
                                        child: Text('Print'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'delete',
                                        child: Text('Delete'),
                                      ),
                                    ],
                                    isExpanded: true,
                                    onChanged: (value) {
                                      context.read<DeleteProvider>().setselectedValue(value!);

                                      switch (provider.selectedValue) {
                                        case 'edit':
                                          context.read<EditProvider>().setEventModel(_eventModel);
                                          context.read<StampProvider>().setSelectedStamp(_eventModel.stamp!);

                                          Navigator.pushNamed(context, editTripScreenRoute);
                                          break;
                                        case 'print':
                                          context.read<EditProvider>().setEventModel(_eventModel);

                                          Navigator.pushNamed(context, printTripScreenRoute);
                                          break;
                                        case 'delete':
                                          showDeleteConfirmationDialog(context, _eventModel.timestamp.toString());
                                          break;
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Graduation Trip",
                                  style: twelve600TextStyle(color: textBrownColor),
                                ),
                                TripDetailsRowWidget(
                                  image: Icons.location_on_outlined,
                                  text: _eventModel.location!,
                                ),
                                TripDetailsRowWidget(
                                  image: Icons.calendar_month,
                                  text:
                                      "${formatDateFromMilliseconds(_eventModel.dateStart)}-${formatDateFromMilliseconds(_eventModel.dateEnd!)}",
                                ),
                                TripDetailsRowWidget(
                                  image: Icons.hotel_outlined,
                                  text: _eventModel.hotelName!,
                                ),
                                // TripDetailsRowWidget(
                                //   image: Icons.people_outlined,
                                //   text: _eventModel.companionsNames![0],
                                // ),

                                Row(
                                  children: [
                                    const Icon(
                                      Icons.people_outlined,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    for (var i in _eventModel.companionsNames!)
                                      Text(
                                        i,
                                        style: eleven400TextStyle(color: textBrownColor),
                                      )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Image.network(
                            _eventModel.stamp!,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      Text(
                        "About Trip",
                        style: twelve600TextStyle(color: textBrownColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Text(
                          _eventModel.aboutTrip!,
                          style: eleven400TextStyle(color: textBrownColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Event"),
          content: const Text("Are you sure you want to delete this event? This action cannot be undone."),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                Navigator.of(context).pop();
                context.read<DeleteProvider>().deleteEvent(context, id);
              },
            ),
          ],
        );
      },
    );
  }
}
