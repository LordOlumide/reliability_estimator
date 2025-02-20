import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:reliability_estimator/src/utils/double_extension.dart';
import 'package:reliability_estimator/src/widgets/custom_text_field.dart';

class TimeSection extends StatefulWidget {
  const TimeSection({super.key});

  @override
  State<TimeSection> createState() => _TimeSectionState();
}

class _TimeSectionState extends State<TimeSection> {
  double failureRate = 0;
  double reliabilityPercent = 0;

  double get time => -math.log(reliabilityPercent / 100) / failureRate;

  String get timeInDays => time.isNaN || time.isInfinite
      ? ''
      : '${time ~/ 24} days, ${(time % 24).clean(3)} hours';

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double spacing = screenWidth / 70;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        SizedBox(width: 2 * spacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Reliability (in %):',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: spacing),
            SizedBox(
              width: screenWidth / 6,
              child: CustomTextField(
                onChanged: (String? newValue) =>
                    _onReliabilityChanged(context, newValue),
              ),
            ),
            SizedBox(width: 2 * spacing),
            Text(
              'Failure Rate (failures per hour):',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: spacing),
            SizedBox(
              width: screenWidth / 6,
              child: CustomTextField(
                onChanged: (String? newValue) =>
                    _onFailureRateChanged(context, newValue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Estimated time (t)  =  -Ln(Reliability) / λ  =  ',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  time.isNaN || time.isInfinite
                      ? ''
                      : '${time.clean(4)} hours  or  $timeInDays',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  void _onFailureRateChanged(BuildContext context, String? newValue) {
    setState(() {
      failureRate = double.parse(
          newValue != null && newValue != '' && newValue != '.'
              ? newValue
              : '0');
    });
  }

  void _onReliabilityChanged(BuildContext context, String? newValue) {
    setState(() {
      reliabilityPercent = double.parse(
          newValue != null && newValue != '' && newValue != '.'
              ? newValue
              : '0');
    });
  }
}
