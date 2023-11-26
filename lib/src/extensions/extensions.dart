import 'package:intl/intl.dart';

extension QuillTextParser on String {
  String extractPlainText() {
    // Define a regex pattern to match the "insert" values along with optional attributes
    final pattern = RegExp(r'"insert":"([^"]*)"(?:,"attributes":{[^}]*})?');

    // Extract all matches from the string
    final matches = pattern.allMatches(this);

    // Extract and concatenate the plain text from the matches
    final plainText = matches
        .map((match) => match.group(1)?.replaceAll(r'\n', '\n') ?? '')
        .join();
    //Although I am nerd at this RegX
    return plainText;
  }
}

extension Iso8601DateTimeFormatting on DateTime {
  String formatTimeAndDay() {
    // Format the time in 12-hour format and the day name
    String formattedTime = DateFormat('h:mm a').format(this);
    String formattedDayName = DateFormat('EEEE').format(this);

    return '$formattedTime, $formattedDayName';
  }
}
