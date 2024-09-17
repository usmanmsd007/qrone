// import 'package:intl/intl.dart';

// extension DateTimeExt on DateTime {
//   // This function returns a datetime in the format 13 06 2023 12:34 PM
//   String toDDMMYYYYhhmmAMPM() {
//     // Create a DateFormat object with the desired format
//     DateFormat formatter = DateFormat('dd MM yyyy hh:mm a');

//     // Format the date and time using the DateFormat object
//     String formattedDateTime = formatter.format(this);

//     // Replace the spaces with dashes
//     formattedDateTime = formattedDateTime.replaceAll(' ', '-');

//     // Return the formattedDateTime
//     return formattedDateTime;
//   }
// }

// extension SDateTimeExt on String {
//   // This function converts the string "13 06 2023 12:34 PM" to a DateTime object
//   DateTime toDateTime() {
//     // Create a DateFormat object with the desired format
//     DateFormat formatter = DateFormat('dd MM yyyy hh:mm a');

//     // Parse the string using the DateFormat object
//     DateTime dateTime = formatter.parse(this);

//     // Return the dateTime
//     return dateTime;
//   }
// }
