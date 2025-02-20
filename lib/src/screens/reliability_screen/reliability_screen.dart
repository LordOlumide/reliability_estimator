import 'package:flutter/material.dart';
import 'package:reliability_estimator/src/screens/reliability_screen/components/failure_rate_section.dart';
import 'package:reliability_estimator/src/screens/reliability_screen/components/reliability_section.dart';
import 'package:reliability_estimator/src/screens/reliability_screen/components/time_section.dart';

class ReliabilityScreen extends StatefulWidget {
  const ReliabilityScreen({super.key});

  @override
  State<ReliabilityScreen> createState() => _ReliabilityScreenState();
}

class _ReliabilityScreenState extends State<ReliabilityScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double spacing = screenWidth / 70;

    final titleStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          'Calculate Reliability',
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(50, 0, 50, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Calculate Reliability from failure rate and time.',
              style: titleStyle,
            ),
            const SizedBox(height: 2),
            const ReliabilitySection(),
            const SizedBox(height: 12),
            Divider(color: Colors.black87, thickness: 1),
            const SizedBox(height: 20),
            Text(
              'Calculate time from failure rate and reliability.',
              style: titleStyle,
            ),
            const SizedBox(height: 2),
            const TimeSection(),
            const SizedBox(height: 12),
            Divider(color: Colors.black87, thickness: 1),
            const SizedBox(height: 20),
            Text(
              'Calculate failure rate from reliability and time.',
              style: titleStyle,
            ),
            const SizedBox(height: 2),
            const FailureRateSection(),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
