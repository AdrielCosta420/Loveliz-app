import 'package:intl/intl.dart';

sealed class MaskDate {
  static String toAbbreviationForMonth(DateTime? dateTime) {
    if (dateTime != null) {
      return DateFormat('dd MMM yyyy HH:mm:ss', 'pt_BR').format(dateTime);
    } else {
      return 'Data não informada!';
    }
  }

  static String? getFormattedDate(DateTime? date) {
    if (date == null) return null;
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
    return dateFormat.format(date);
  }
}
