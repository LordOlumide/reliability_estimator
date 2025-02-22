import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:reliability_estimator/src/utils/double_extension.dart';
import 'package:reliability_estimator/src/widgets/custom_text_field.dart';

class ReliabilitySection extends StatefulWidget {
  const ReliabilitySection({super.key});

  @override
  State<ReliabilitySection> createState() => _ReliabilitySectionState();
}

class _ReliabilitySectionState extends State<ReliabilitySection> {
  double failureRate = 0;
  double time = 0;

  double get reliability => math.exp(-failureRate * time);

  double get reliabilityInPercent => math.exp(-failureRate * time) * 100;

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
        SizedBox(width: 2 * spacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
            SizedBox(width: 2 * spacing),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Time (hours):',
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
                          _onTimeChanged(context, newValue),
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
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(text: 'Reliability = R(t) = e'),
                      WidgetSpan(
                        child: Transform.translate(
                          offset: const Offset(0, -7),
                          child: Text(
                            '-λt',
                            textScaler: TextScaler.linear(0.9),
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      TextSpan(text: ' =  '),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  reliability.isNaN
                      ? ''
                      : '${reliability.clean()}  or  ${reliabilityInPercent.clean(5)}%',
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

  void _onFailureRateChanged(BuildContext context, String? newValue) {
    setState(() {
      failureRate = double.parse(
          newValue != null && newValue != '' && newValue != '.'
              ? newValue
              : '0');
    });
  }
}
