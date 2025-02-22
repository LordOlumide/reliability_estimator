import 'package:reliability_estimator/src/utils/double_extension.dart';

abstract class TimeUtils {
  static String getTimeInYears({
    required double noOfHours,
    int hoursPerDay = 24,
    int daysPerWeek = 7,
  }) {
    final int hoursInADay = hoursPerDay;
    final int hoursInAWeek = hoursPerDay * daysPerWeek;
    final double hoursInAMonth = hoursInAWeek * 4.34524;
    final double hoursInAYear = hoursInAMonth * 12;

    String returnString = '';

    if (noOfHours.isNaN || noOfHours.isInfinite) {
      return returnString;
    }

    if (noOfHours > hoursInAYear) {
      int noOfYears = noOfHours ~/ hoursInAYear;
      bool yearMoreThanOne = noOfYears > 1;
      double hoursRemaining = noOfHours - (noOfYears * hoursInAYear);
      bool timeIsRemaining = hoursRemaining > 0;

      returnString = '$returnString$noOfYears year${yearMoreThanOne ? 's' : ''}'
          '${timeIsRemaining ? ', ' : ''}';

      noOfHours = hoursRemaining;
    }
    if (noOfHours > hoursInAMonth) {
      int noOfMonths = noOfHours ~/ hoursInAMonth;
      bool monthsMoreThanOne = noOfMonths > 1;
      double hoursRemaining = noOfHours - (noOfMonths * hoursInAMonth);
      bool timeIsRemaining = hoursRemaining > 0;

      returnString =
          '$returnString$noOfMonths month${monthsMoreThanOne ? 's' : ''}'
          '${timeIsRemaining ? ', ' : ''}';

      noOfHours = hoursRemaining;
    }
    if (noOfHours > hoursInAWeek) {
      int noOfWeeks = noOfHours ~/ hoursInAWeek;
      bool weeksMoreThanOne = noOfWeeks > 1;
      double hoursRemaining = noOfHours - (noOfWeeks * hoursInAWeek);
      bool timeIsRemaining = hoursRemaining > 0;

      returnString =
          '$returnString$noOfWeeks week${weeksMoreThanOne ? 's' : ''}'
          '${timeIsRemaining ? ', ' : ''}';

      noOfHours = hoursRemaining;
    }
    if (noOfHours > hoursInADay) {
      int noOfDays = noOfHours ~/ hoursInADay;
      bool daysMoreThanOne = noOfDays > 1;
      double hoursRemaining = noOfHours - (noOfDays * hoursInADay);
      bool timeIsRemaining = hoursRemaining > 0;

      returnString = '$returnString$noOfDays day${daysMoreThanOne ? 's' : ''}'
          '${timeIsRemaining ? ', ' : ''}';

      noOfHours = hoursRemaining;
    }
    if (noOfHours > 0) {
      bool hoursMoreThanOne = noOfHours > 1;
      returnString =
          '$returnString${noOfHours.clean(1)} hour${hoursMoreThanOne ? 's' : ''}';
    }
    return returnString;
  }
}
