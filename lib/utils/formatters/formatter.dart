import 'package:intl/intl.dart';

class MFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();

    return DateFormat('dd-MMM-yyy')
        .format(date); // customise the date formate as needed
  }

  static String FormatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);
  }

  static String formatePhoneNumber(String phoneNumber) {
    /// Assuming a 10-digital US phone number format : (123) 456-7890

    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    }

    return phoneNumber;
  }

  static String InternationalFormatPhoneNuber(String phoneNumber) {
    // remove any non-digit character  from phone number

    var digitalsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Extract the Country code from the digitalOnly

    String countryCode = '+${digitalsOnly.substring(0, 2)}';
    digitalsOnly = digitalsOnly.substring(2);

    // Add the remaining digits with proper formatting
    final formattedNumber = StringBuffer();
    formattedNumber.write('($countryCode)');

    int i = 0;

    while (i < digitalsOnly.length) {
      int groupLength = 2;

      if (i == 0 && countryCode == '+1') {
        groupLength = 3;
      }

      int end = i + groupLength;
      formattedNumber.write(digitalsOnly.substring(i, end));

      if (end < digitalsOnly.length) {
        formattedNumber.write('');
      }
      i = end;
    }

    return phoneNumber;
  }
}
