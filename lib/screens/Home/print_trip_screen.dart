import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:travel_chronicle/provider/edit_provider.dart';
import 'package:travel_chronicle/provider/user_provider.dart';
import 'package:travel_chronicle/utilities/date_formeter.dart';

import '../../global_widgets/trip_details_row_widget.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/app_text_styles.dart';
import 'package:pdf/widgets.dart' as pw;

class PrintTripScreen extends StatefulWidget {
  const PrintTripScreen({super.key});

  @override
  State<PrintTripScreen> createState() => _PrintTripScreenState();
}

class _PrintTripScreenState extends State<PrintTripScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<EditProvider>();

    return Scaffold(
      backgroundColor: skinColor,
      body: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              provider.eventModel.name,
                              style: twelve600TextStyle(color: textBrownColor),
                            ),
                            TripDetailsRowWidget(
                              image: Icons.location_on_outlined,
                              text: provider.eventModel.location!,
                            ),
                            TripDetailsRowWidget(
                              image: Icons.calendar_month,
                              text:
                                  "${formatDateFromMilliseconds(provider.eventModel.dateStart)} - ${formatDateFromMilliseconds(provider.eventModel.dateEnd!)}",
                            ),
                            TripDetailsRowWidget(
                              image: Icons.hotel_outlined,
                              text: provider.eventModel.hotelName!,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.people_outlined,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                for (var i in provider.eventModel.companionsNames!)
                                  Text(
                                    i,
                                    style: eleven400TextStyle(color: textBrownColor),
                                  )
                              ],
                            )
                          ],
                        ),
                      ),
                      Image.network(
                        provider.eventModel.stamp!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 1.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(provider.eventModel.images[0]),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.all(20.0),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "About Trip",
                    style: twelve600TextStyle(color: textBrownColor),
                  ),
                  Text(
                    provider.eventModel.aboutTrip!,
                    style: eleven400TextStyle(color: textBrownColor),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      if (context.read<UserProvider>().localUser != null &&
                          context.read<UserProvider>().localUser!.cloudSubscription &&
                          context.read<UserProvider>().localUser!.exportPdfSubscription) {
                        _generateAndSavePDF(context);
                      } else {
                        EasyLoading.showInfo("please buy Export to Pdf Subscription first!");
                      }
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        "assets/printLogo.png",
                        height: 70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _generateAndSavePDF(BuildContext context) async {
    final pdf = pw.Document();
    final provider = context.read<EditProvider>();

    // Load images asynchronously
    final stampImage = await loadImage(provider.eventModel.stamp!);
    final tripImage = await loadImage(provider.eventModel.images[0]);

    // Add content to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                provider.eventModel.name!,
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text('Location: ${provider.eventModel.location}'),
              pw.Text(
                  'Date: ${formatDateFromMilliseconds(provider.eventModel.dateStart)} - ${formatDateFromMilliseconds(provider.eventModel.dateEnd!)}'),
              pw.Text('Hotel: ${provider.eventModel.hotelName}'),
              pw.Text('Companions: ${provider.eventModel.companionsNames!.join(', ')}'),
              pw.Image(
                pw.MemoryImage(stampImage),
                width: 120,
                height: 120,
              ),
              pw.Image(
                pw.MemoryImage(tripImage),
                width: 300,
                height: 200,
                fit: pw.BoxFit.cover,
              ),
              pw.Text('About Trip:'),
              pw.Text(provider.eventModel.aboutTrip!),
            ],
          );
        },
      ),
    );

    // Save the PDF file
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/trip_${DateTime.now().toIso8601String()}.pdf');
    await file.writeAsBytes(await pdf.save());

    // Optionally, show a confirmation dialog or toast
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: textBrownColor,
        content: Text(
          'PDF saved at $file',
        ),
      ),
    );

    // Open the PDF file
  }

  Future<Uint8List> loadImage(String url) async {
    final response = await NetworkAssetBundle(Uri.parse(url)).load('');
    return response.buffer.asUint8List();
  }
}
