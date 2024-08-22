// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:travel_chronicle/data/locator.dart';
import 'package:travel_chronicle/provider/home_provider.dart';
import 'package:travel_chronicle/provider/user_provider.dart';
import 'package:travel_chronicle/utilities/app_colors.dart';
import 'package:travel_chronicle/utilities/app_routes.dart';
import 'package:travel_chronicle/utilities/app_text_styles.dart';

import '../models/event_model.dart';

class EventTimeline extends StatelessWidget {
  final List<EventModel> events;

  const EventTimeline({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    Map<String, List<EventModel>> eventsByYear = {};

    for (var event in events) {
      String year = DateFormat('yyyy').format(DateTime.fromMillisecondsSinceEpoch(event.dateStart));
      if (!eventsByYear.containsKey(year)) {
        eventsByYear[year] = [];
      }
      eventsByYear[year]!.add(event);
    }

    return SingleChildScrollView(
      child: Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: eventsByYear.entries.expand((entry) {
          String year = entry.key;
          List<EventModel> yearEvents = entry.value;

          return [
            YearTile(year: year),
            ...yearEvents.map((event) => EventTile(event: event)),
          ];
        }).toList(),
      ),
    );
  }
}

class YearTile extends StatelessWidget {
  final String year;

  const YearTile({super.key, required this.year});

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: widht * 0.22,
      height: widht * 0.22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: darkSkinColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        "${year.substring(0, 2)}\n${year.substring(2, 4)}",
        style: TextStyle(
          color: brownColor,
          fontSize: 30,
          fontFamily: GoogleFonts.purplePurse().fontFamily,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class EventTile extends StatefulWidget {
  final EventModel event;

  const EventTile({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  State<EventTile> createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  bool? isCloundSubscription;

  @override
  void initState() {
    getCloundSubscription();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String date = DateFormat('MMM dd').format(DateTime.fromMillisecondsSinceEpoch(widget.event.timestamp));
    final widht = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(onTap: () {
      context.read<HomeProvider>().setEventModel(widget.event);

      Navigator.pushNamed(context, tripDetailsScreenRoute);
    }, child: Consumer<UserProvider>(
      builder: (context, provider, child) {
        if (provider.localUser != null && provider.localUser!.cloudSubscription == true) {
          return Container(
            width: widht * 0.22,
            height: widht * 0.22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(widget.event.images.first),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height * 0.04,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                  color: Colors.red.withOpacity(0.5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.event.name,
                      style: eight700TextStyle(
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      date,
                      style: eight400TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container(
            width: widht * 0.22,
            height: widht * 0.22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: FileImage(File(widget.event.images.first)),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height * 0.04,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                  color: Colors.red.withOpacity(0.5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.event.name,
                      style: eight700TextStyle(
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      date,
                      style: eight400TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    ));
  }

  Future<void> getCloundSubscription() async {
    isCloundSubscription = await storage.isCloundSubscription();
  }
}
