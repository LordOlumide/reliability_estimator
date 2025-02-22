import 'package:flutter/material.dart';
import 'package:reliability_estimator/src/screens/analyse_cost_screen/analyse_cost_screen.dart';
import 'package:reliability_estimator/src/screens/failure_rate_screen/failure_rate_screen.dart';
import 'package:reliability_estimator/src/screens/reliability_screen/reliability_screen.dart';
import 'package:reliability_estimator/src/widgets/primary_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Reliability Estimator',
          style: TextStyle(fontSize: 38, fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth / 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              PrimaryButton(
                onPressed: () => _pushToFailureRateScreen(context),
                child: Text(
                  'Calculate Failure Rate',
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                onPressed: () => _pushToReliabilityScreen(context),
                child: Text(
                  'Calculate Reliability',
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                onPressed: () => _pushToAnalyseCostScreen(context),
                child: Text(
                  'Analyse Cost',
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
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

  void _pushToAnalyseCostScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnalyseCostScreen(),
      ),
    );
  }
}
