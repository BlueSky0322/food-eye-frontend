import 'dart:developer';

import 'package:intl/intl.dart';

String parseExpiryDate(String text) {
  final List<String> formats = [
    'yyyy MM dd', // e.g., "2025 12 12"
    'dd.MM.yyyy', // e.g., "11.11.2024"
    'dd/MM/yyyy', // e.g., "22/09/2025"
    'dd.MM.yy', // e.g., "14.11.23"
    'yyyy-MM-dd', // e.g., "2023-07-03"
    'dd/MM/yy', // e.g., "01/01/25"
    'MM/dd/yyyy', // e.g., "12/31/2022"
    'd MMM yyyy', // e.g., "4 Jun 2023"
    'd MMMM yyyy', // e.g., "4 June 2023"
    'MMMM d yyyy', // e.g., "June 4 2023"
  ];

  DateTime? expiryDate;

  for (final format in formats) {
    try {
      final DateFormat dateFormat = DateFormat(format);

      expiryDate = dateFormat.parseStrict(text);

      if (expiryDate.year < 100) {
        final int? day = int.tryParse(text.substring(0, 2));
        final int? month = int.tryParse(text.substring(3, 5));
        final int? year = int.tryParse(text.substring(6, 8));

        if (day != null && month != null && year != null) {
          expiryDate = DateTime(2000 + year, month, day);
          log('Successfully parsed special expiry date: $expiryDate');
        }
      }
      log('Successfully parsed expiry date: $expiryDate');
      break;
    } catch (e) {
      // Parsing failed for the current format, try the next one
    }
  }

  if (expiryDate != null) {
    return expiryDate.toString();
  } else {
    return text;
  }
}
