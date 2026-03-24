import 'package:intl/intl.dart';

String dateTimeToString(String template, DateTime date, String localeCode) {
  return DateFormat(template, localeCode).format(date);
}
