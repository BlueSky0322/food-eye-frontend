import 'package:intl/intl.dart';

class ExpiryDateDisplayHelper {
  static String getExpiryStatus(DateTime expiryDate) {
    final currentDate = DateTime.now();
    final difference = expiryDate.difference(currentDate).inDays;

    if (difference < 0) {
      return 'Expired';
    } else if (difference == 0) {
      return 'Expires TODAY';
    } else if (difference <= 14) {
      return '$difference day(s)';
    } else {
      return DateFormat.yMd().format(expiryDate);
    }
  }
}
