import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String?) onChanged;
  final bool takesOnlyNumber;

  const CustomTextField({
    super.key,
    this.controller,
    required this.onChanged,
    this.takesOnlyNumber = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      keyboardType: takesOnlyNumber
          ? const TextInputType.numberWithOptions(decimal: true)
          : null,
      inputFormatters: takesOnlyNumber
          ? [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ]
          : null,
      textAlign: TextAlign.center,
      decoration: const InputDecoration(
        // isCollapsed: true,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
      onChanged: onChanged,
    );
  }
}
