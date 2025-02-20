import 'package:intl/intl.dart';

String formatDate(String? dateString) {
  if (dateString == null) return 'N/A';
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('dd/MM/yyyy').format(dateTime);
}
