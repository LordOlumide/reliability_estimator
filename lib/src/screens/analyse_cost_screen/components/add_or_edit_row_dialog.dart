import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reliability_estimator/src/screens/analyse_cost_screen/model/row_model.dart';
import 'package:reliability_estimator/src/utils/validators.dart';
import 'package:reliability_estimator/src/widgets/primary_button.dart';

class AddOrEditRowDialog extends StatefulWidget {
  final bool isCreateNotEdit;
  final RowModel0? initialRowValue;

  const AddOrEditRowDialog({
    super.key,
    this.isCreateNotEdit = true,
    this.initialRowValue,
  });

  @override
  State<AddOrEditRowDialog> createState() => _AddOrEditRowDialogState();
}

class _AddOrEditRowDialogState extends State<AddOrEditRowDialog> {
  final TextEditingController yearCont = TextEditingController();
  final TextEditingController maintenanceCostCont = TextEditingController();
  final TextEditingController depreciationCostCont = TextEditingController();

  final FocusNode firstFocusNode = FocusNode();
  final FocusNode secondFocusNode = FocusNode();
  final FocusNode thirdFocusNode = FocusNode();
  final FocusNode fourthFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.initialRowValue != null) {
      yearCont.text = widget.initialRowValue!.year.toString();
      maintenanceCostCont.text =
          widget.initialRowValue!.maintenanceCost.toString();
      depreciationCostCont.text =
          widget.initialRowValue!.depreciationCost.toString();
    }
  }

  @override
  void dispose() {
    yearCont.dispose();
    maintenanceCostCont.dispose();
    depreciationCostCont.dispose();
    firstFocusNode.dispose();
    secondFocusNode.dispose();
    thirdFocusNode.dispose();
    fourthFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.lightBlue.shade50,
      insetPadding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width / 4,
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.lightBlue, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Text(
                widget.isCreateNotEdit ? 'Create New Row' : 'Edit Row',
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Year',
                  style: const TextStyle(fontSize: 17),
                ),
              ),
              const SizedBox(height: 4),
              TextFormField(
                autofocus: true,
                focusNode: firstFocusNode,
                controller: yearCont,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) => Validators.simpleValidator(value),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(secondFocusNode);
                },
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Maintenance Cost',
                  style: const TextStyle(fontSize: 17),
                ),
              ),
              const SizedBox(height: 4),
              TextFormField(
                focusNode: secondFocusNode,
                controller: maintenanceCostCont,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: (value) => Validators.simpleValidator(value),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(thirdFocusNode);
                },
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Depreciation Cost',
                  style: const TextStyle(fontSize: 17),
                ),
              ),
              const SizedBox(height: 4),
              TextFormField(
                focusNode: thirdFocusNode,
                controller: depreciationCostCont,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: (value) => Validators.simpleValidator(value),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(fourthFocusNode);
                },
              ),
              const SizedBox(height: 25),
              PrimaryButton(
                focusNode: fourthFocusNode,
                shrink: true,
                color: Colors.blue,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop({
                      'year': yearCont.text,
                      'maintenance_cost': maintenanceCostCont.text,
                      'depreciation_cost': depreciationCostCont.text,
                    });
                  }
                },
                borderRadius: BorderRadius.circular(35),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
                padding:
                    const EdgeInsets.symmetric(vertical: 9, horizontal: 20),
                child: Text(
                  widget.isCreateNotEdit ? 'Create' : 'Edit',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
