import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:reliability_estimator/src/screens/reliability_screen/utils/time_utils.dart';
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

  int hoursPerDay = 24;
  int daysPerWeek = 7;

  double get timeInHours => -math.log(reliabilityPercent / 100) / failureRate;

  String get formattedTime => TimeUtils.getTimeInYears(
        noOfHours: timeInHours,
        hoursPerDay: hoursPerDay,
        daysPerWeek: daysPerWeek,
      );

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double spacing = screenWidth / 70;
    final double textBoxWidth = screenWidth / 5;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                    width: textBoxWidth,
                    child: CustomTextField(
                      onChanged: (String? newValue) =>
                          _onReliabilityChanged(context, newValue),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 2 * spacing),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'λ (failures/hour):',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: spacing),
                  SizedBox(
                    width: textBoxWidth,
                    child: CustomTextField(
                      onChanged: (String? newValue) =>
                          _onFailureRateChanged(context, newValue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hours per day',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(width: 8),
            DropdownButton<int>(
              value: hoursPerDay,
              padding: EdgeInsets.symmetric(horizontal: 10),
              style: TextStyle(fontSize: 20, color: Colors.black),
              items: [
                for (int i = 1; i <= 24; i++)
                  DropdownMenuItem(
                    value: i,
                    child: Text(
                      i.toString(),
                    ),
                  ),
              ],
              onChanged: _setHoursPerDay,
            ),
            const SizedBox(width: 20),
            Text(
              'Days per week',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(width: 8),
            DropdownButton<int>(
              value: daysPerWeek,
              padding: EdgeInsets.symmetric(horizontal: 10),
              style: TextStyle(fontSize: 20, color: Colors.black),
              items: [
                for (int i = 1; i <= 7; i++)
                  DropdownMenuItem(
                    value: i,
                    child: Text(
                      i.toString(),
                    ),
                  ),
              ],
              onChanged: _setDaysPerWeek,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.center,
          child: Text(
            'At 4.34524 weeks per month and 12 months per year',
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Time (t)  =  -Ln(Reliability) / λ  =  ',
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
                  timeInHours.isNaN || timeInHours.isInfinite
                      ? ''
                      : '${timeInHours.clean(2)} hours or $formattedTime',
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

  void _setHoursPerDay(int? newValue) {
    if (newValue != null) {
      setState(() {
        hoursPerDay = newValue;
      });
    }
  }

  void _setDaysPerWeek(int? newValue) {
    if (newValue != null) {
      setState(() {
        daysPerWeek = newValue;
      });
    }
  }
}
