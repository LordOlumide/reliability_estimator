import 'package:flutter/material.dart';
import 'package:reliability_estimator/src/screens/failure_rate_screen/failure_rate_screen.dart';
import 'package:reliability_estimator/src/screens/home_screen/widgets/custom_button_1.dart';
import 'package:reliability_estimator/src/screens/reliability_screen/reliability_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Reliability Estimator',
          style: TextStyle(fontSize: 38, fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            CustomButton1(
              onPressed: () => _pushToFailureRateScreen(context),
              text: 'Calculate Failure Rate',
            ),
            const SizedBox(height: 40),
            CustomButton1(
              onPressed: () => _pushToReliabilityScreen(context),
              text: 'Calculate Reliability',
            ),
          ],
        ),
      ),
    );
  }

  void _pushToFailureRateScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FailureRateScreen(),
      ),
    );
  }

  void _pushToReliabilityScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReliabilityScreen(),
      ),
    );
  }
}
