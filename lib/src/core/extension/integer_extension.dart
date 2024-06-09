import 'package:intl/intl.dart';

extension IntegerExtension on int? {
  String priceFormat() {
    if (this == null) {
      return '';
    }
    final priceFormatter = NumberFormat();

    return '${priceFormatter.format(this).replaceAll(',', ' ')} ₸';
  }

  String thousandFormat() {
    if (this == null) {
      return '';
    }
    final priceFormatter = NumberFormat();

    return priceFormatter.format(this).replaceAll(',', ' ');
  }

  String formattedTime() {
    if (this == null) return '';

    final int sec = this! % 60;
    final int min = (this! / 60).floor();
    final String minute = min.toString().length <= 1 ? "0$min" : "$min";
    final String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }
}
