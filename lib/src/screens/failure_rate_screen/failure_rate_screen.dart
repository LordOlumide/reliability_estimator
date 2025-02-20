import 'package:flutter/material.dart';
import 'package:reliability_estimator/src/utils/double_extension.dart';
import 'package:reliability_estimator/src/widgets/custom_text_field.dart';

class FailureRateScreen extends StatefulWidget {
  const FailureRateScreen({super.key});

  @override
  State<FailureRateScreen> createState() => _FailureRateScreenState();
}

class _FailureRateScreenState extends State<FailureRateScreen> {
  double noOfFailures = 0;
  double noOfOperatingHours = 0;

  double get failureRate => noOfFailures / noOfOperatingHours;

  double get failureRatePP1000Hours => failureRate * 100 * 1000;

  double get mtbf => noOfOperatingHours / noOfFailures;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double spacing = screenWidth / 70;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          'Calculate Failure Rate',
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 50, 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Failure Rate (λ) = ',
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: spacing),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'No. of failures',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(width: 200, height: 2, color: Colors.black),
                      Text(
                        'Total no. of operating hours',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: spacing),
                  Text(
                    '=',
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: spacing),
                  SizedBox(
                    width: screenWidth / 4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                          onChanged: (String? newValue) =>
                              _onNoOfFailuresChanged(context, newValue),
                        ),
                        Container(
                          width: screenWidth / 4,
                          height: 2,
                          color: Colors.black,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                        ),
                        CustomTextField(
                          onChanged: (String? newValue) =>
                              _onNoOfHoursChanged(context, newValue),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Divider(color: Colors.black87, thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Failure Rate (λ) =',
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 14),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: failureRate.isNaN ? '' : failureRate.clean(),
                        ),
                        TextSpan(
                          text: failureRate.isNaN ? '' : ' failures/hour',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: failureRate.isNaN ? '' : '  or  ',
                        ),
                        TextSpan(
                          text: failureRate.isNaN
                              ? ''
                              : failureRatePP1000Hours.clean(),
                        ),
                        TextSpan(
                          text: failureRate.isNaN ? '' : ' percent/1000 hours',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onNoOfFailuresChanged(BuildContext context, String? newValue) {
    setState(() {
      noOfFailures = double.parse(
          newValue != null && newValue != '' && newValue != '.'
              ? newValue
              : '0');
    });
  }

  void _onNoOfHoursChanged(BuildContext context, String? newValue) {
    setState(() {
      noOfOperatingHours = double.parse(
          newValue != null && newValue != '' && newValue != '.'
              ? newValue
              : '0');
    });
  }
}
