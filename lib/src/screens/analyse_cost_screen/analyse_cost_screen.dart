import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reliability_estimator/src/repos/analyse_cost_repo.dart';
import 'package:reliability_estimator/src/screens/analyse_cost_screen/components/add_or_edit_row_dialog.dart';
import 'package:reliability_estimator/src/screens/analyse_cost_screen/components/cell_widget.dart';
import 'package:reliability_estimator/src/screens/analyse_cost_screen/model/row_model.dart';
import 'package:reliability_estimator/src/screens/analyse_cost_screen/model/table_model.dart';
import 'package:reliability_estimator/src/utils/double_extension.dart';
import 'package:reliability_estimator/src/widgets/custom_button_1.dart';
import 'package:reliability_estimator/src/widgets/more_button.dart';

class AnalyseCostScreen extends StatefulWidget {
  const AnalyseCostScreen({super.key});

  @override
  State<AnalyseCostScreen> createState() => _AnalyseCostScreenState();
}

class _AnalyseCostScreenState extends State<AnalyseCostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          'Analyse Reliability Cost',
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            Consumer<AnalyseCostRepo>(
              builder: (context, provider, child) {
                final TableModel tableModel = provider.tableModel;

                return Table(
                  border: TableBorder.all(width: 1),
                  children: [
                    TableRow(
                      children: [
                        CellWidget(
                          text: 'Year of Service\nn',
                          isBold: true,
                        ),
                        CellWidget(
                          text: 'Maintenance Cost\nf(n)',
                          isBold: true,
                        ),
                        CellWidget(
                          text: 'Cumulative Maintenance Cost\nΣf(n)',
                          isBold: true,
                        ),
                        CellWidget(
                          text: 'Depreciation Cost\n(Rs) = C - S',
                          isBold: true,
                        ),
                        CellWidget(
                          text: 'Total Cost (Rs)\nTC',
                          isBold: true,
                        ),
                        CellWidget(
                          text: 'Average Cost (Rs)\nA (n)',
                          isBold: true,
                        ),
                        const SizedBox(),
                      ],
                    ),
                    TableRow(
                      decoration: BoxDecoration(),
                      children: [
                        CellWidget(
                            text: '(1)', isBold: true, verticalPadding: 4),
                        CellWidget(text: '', isBold: true, verticalPadding: 4),
                        CellWidget(
                            text: '(2)', isBold: true, verticalPadding: 4),
                        CellWidget(
                            text: '(3)', isBold: true, verticalPadding: 4),
                        CellWidget(
                            text: '(4) = (2) + (3)',
                            isBold: true,
                            verticalPadding: 4),
                        CellWidget(
                            text: '(5) = (4) / (1)',
                            isBold: true,
                            verticalPadding: 4),
                        const SizedBox(),
                      ],
                    ),
                    for (int i = 0; i < tableModel.rows.length; i++)
                      TableRow(
                        children: [
                          CellWidget(
                            text: tableModel.rows[i].year.toString(),
                          ),
                          CellWidget(
                            text: tableModel.rows[i].maintenanceCost.toString(),
                          ),
                          CellWidget(
                            text: tableModel.rows[i].cumulativeMaintenanceCost
                                .toString(),
                          ),
                          CellWidget(
                            text:
                                tableModel.rows[i].depreciationCost.toString(),
                          ),
                          CellWidget(
                            text: tableModel.rows[i].totalCost.toString(),
                          ),
                          CellWidget(
                            text: tableModel.rows[i].averageCost.clean(2),
                          ),
                          MoreButton(
                            options: [
                              MenuOption(
                                optionName: 'Edit Row',
                                icon: Icons.edit,
                                function: () => _onEditRowPressed(context, i),
                              ),
                              MenuOption(
                                optionName: 'Delete Entry',
                                icon: Icons.delete_outline,
                                color: Colors.red,
                                function: () => _onDeleteRowPressed(context, i),
                              ),
                            ],
                          )
                        ],
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton1(
              onPressed: () => _onAddRowPressed(context),
              text: 'Add Row',
            ),
            const SizedBox(height: 20),
            Consumer<AnalyseCostRepo>(
              builder: (context, provider, child) {
                if (provider.lowestCostRow != null) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'The year with the lowest average cost is year '
                      '${provider.lowestCostRow!.year} with '
                      'cost ${provider.lowestCostRow!.averageCost.clean(2)}',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onAddRowPressed(BuildContext context) async {
    final TableModel oldModel = context.read<AnalyseCostRepo>().tableModel;

    late final Map<String, dynamic>? map;

    if (context.mounted) {
      map = await showDialog(
        context: context,
        builder: (context) {
          return const AddOrEditRowDialog();
        },
      );
    }
    if (map == null || map.isEmpty) return;

    final List<RowModel0> currentRows = [];
    for (int i = 0; i < oldModel.rows.length; i++) {
      currentRows.add(RowModel0.fromModel1(oldModel.rows[i]));
    }
    if (context.mounted) {
      context.read<AnalyseCostRepo>().updateTableModel(
            TableModel.createFromRowModels(
              rows: [
                ...currentRows,
                RowModel0(
                  year: int.parse(map['year']),
                  maintenanceCost: double.parse(map['maintenance_cost']),
                  depreciationCost: double.parse(map['depreciation_cost']),
                ),
              ],
            ),
          );
    }
  }

  Future<void> _onEditRowPressed(BuildContext context, int rowIndex) async {
    final TableModel oldModel = context.read<AnalyseCostRepo>().tableModel;

    late final Map<String, dynamic>? map;

    if (context.mounted) {
      map = await showDialog(
        context: context,
        builder: (context) {
          return AddOrEditRowDialog(
            isCreateNotEdit: false,
            initialRowValue: RowModel0.fromModel1(oldModel.rows[rowIndex]),
          );
        },
      );
    }
    if (map == null || map.isEmpty) return;

    final List<RowModel0> currentRows = [];
    for (int i = 0; i < oldModel.rows.length; i++) {
      currentRows.add(RowModel0.fromModel1(oldModel.rows[i]));
    }
    final editedRow = RowModel0(
      year: int.parse(map['year']),
      maintenanceCost: double.parse(map['maintenance_cost']),
      depreciationCost: double.parse(map['depreciation_cost']),
    );
    currentRows.replaceRange(rowIndex, rowIndex + 1, [editedRow]);

    if (context.mounted) {
      context.read<AnalyseCostRepo>().updateTableModel(
            TableModel.createFromRowModels(
              rows: [...currentRows],
            ),
          );
    }
  }

  Future<void> _onDeleteRowPressed(BuildContext context, int rowIndex) async {
    final TableModel oldModel = context.read<AnalyseCostRepo>().tableModel;

    final List<RowModel0> currentRows = [];
    for (int i = 0; i < oldModel.rows.length; i++) {
      currentRows.add(RowModel0.fromModel1(oldModel.rows[i]));
    }
    currentRows.removeAt(rowIndex);
    if (context.mounted) {
      context.read<AnalyseCostRepo>().updateTableModel(
            TableModel.createFromRowModels(rows: currentRows),
          );
    }
  }
}
