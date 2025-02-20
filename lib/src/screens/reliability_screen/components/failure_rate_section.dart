import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:reliability_estimator/src/utils/double_extension.dart';
import 'package:reliability_estimator/src/widgets/custom_text_field.dart';

class FailureRateSection extends StatefulWidget {
  const FailureRateSection({super.key});

  @override
  State<FailureRateSection> createState() => _FailureRateSectionState();
}

class _FailureRateSectionState extends State<FailureRateSection> {
  double time = 0;
  double reliabilityPercent = 0;

  double get failureRate => -math.log(reliabilityPercent / 100) / time;

  String get failureRateInPP1000 => failureRate.isNaN || failureRate.isInfinite
      ? ''
      : (failureRate * 100 * 1000).clean();

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
              'Reliability (%):',
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
              'Time (hours):',
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
                    _onTimeChanged(context, newValue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Failure Rate  =  -Ln(Reliability) / time  =   ',
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
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  failureRate.isNaN || failureRate.isInfinite
                      ? ''
                      : '${failureRate.clean()}  or  $failureRateInPP1000',
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

  void _onTimeChanged(BuildContext context, String? newValue) {
    setState(() {
      time = double.parse(newValue != null && newValue != '' && newValue != '.'
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
