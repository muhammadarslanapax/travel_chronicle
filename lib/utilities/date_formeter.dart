import 'package:intl/intl.dart';

String formatDateFromMilliseconds(int milliseconds) {
  // Convert milliseconds to a DateTime object
  DateTime date = DateTime.fromMillisecondsSinceEpoch(milliseconds);

  // Define the date format
  DateFormat dateFormat = DateFormat('dd-MMM-yyyy');

  // Format the date
  String formattedDate = dateFormat.format(date).toUpperCase();

  return formattedDate;
}
