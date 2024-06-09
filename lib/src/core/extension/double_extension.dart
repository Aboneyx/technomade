import 'package:intl/intl.dart';

extension DoubleExtension on double? {
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
}
