import 'package:flutter/material.dart';

class CellWidget extends StatelessWidget {
  final String text;
  final bool isBold;
  final double verticalPadding;

  const CellWidget({
    super.key,
    required this.text,
    this.isBold = false,
    this.verticalPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: isBold ? FontWeight.w600 : null,
        ),
      ),
    );
  }
}
