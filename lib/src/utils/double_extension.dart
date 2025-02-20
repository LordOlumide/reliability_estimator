import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String clean([int maxFractionDigits = 15]) {
    NumberFormat formatter = NumberFormat();
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = maxFractionDigits;

    return formatter.format(this);
  }
}
