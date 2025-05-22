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

  static String? getRelativeTime(DateTime? date) {
    if (date == null) return null;

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Hoje, ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays == 1) {
      return 'Ontem, ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} dias atrás';
    } else if (difference.inDays < 14) {
      return 'Semana passada, ${DateFormat('HH:mm').format(date)}';
    } else {
      final dateFormat = DateFormat('dd/MM/yyyy');
      return dateFormat.format(date);
    }
  }

  static String formatDateForMonth(DateTime date) {
    return DateFormat.MMM('pt_BR').format(date).toUpperCase();
  }
}
