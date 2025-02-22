import 'package:flutter/material.dart';
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
  TableModel _tableModel = TableModel.createFromRowModels(rows: []);

  @override
  Widget build(BuildContext context) {
    int? lowestCostRowIndex = _tableModel.getRowIndexWithLowestAverageCost();
    RowModel1? lowestCostRow = lowestCostRowIndex != null
        ? _tableModel.rows[lowestCostRowIndex]
        : null;

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
            Table(
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
                    CellWidget(text: '(1)', isBold: true, verticalPadding: 4),
                    CellWidget(text: '', isBold: true, verticalPadding: 4),
                    CellWidget(text: '(2)', isBold: true, verticalPadding: 4),
                    CellWidget(text: '(3)', isBold: true, verticalPadding: 4),
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
                for (int i = 0; i < _tableModel.rows.length; i++)
                  TableRow(
                    children: [
                      CellWidget(
                        text: _tableModel.rows[i].year.toString(),
                      ),
                      CellWidget(
                        text: _tableModel.rows[i].maintenanceCost.toString(),
                      ),
                      CellWidget(
                        text: _tableModel.rows[i].cumulativeMaintenanceCost
                            .toString(),
                      ),
                      CellWidget(
                        text: _tableModel.rows[i].depreciationCost.toString(),
                      ),
                      CellWidget(
                        text: _tableModel.rows[i].totalCost.toString(),
                      ),
                      CellWidget(
                        text: _tableModel.rows[i].averageCost.clean(2),
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
            ),
            const SizedBox(height: 20),
            CustomButton1(
              onPressed: () => _onAddRowPressed(context),
              text: 'Add Row',
            ),
            const SizedBox(height: 20),
            if (lowestCostRow != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'The year with the lowest average cost is year '
                  '${lowestCostRow.year} with cost ${lowestCostRow.averageCost}',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                ),
              )
            else
              const SizedBox(),
          ],
        ),
      ),
    );
  }

  Future<void> _onAddRowPressed(BuildContext context) async {
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
    for (int i = 0; i < _tableModel.rows.length; i++) {
      currentRows.add(RowModel0.fromModel1(_tableModel.rows[i]));
    }
    setState(() {
      _tableModel = TableModel.createFromRowModels(
        rows: [
          ...currentRows,
          RowModel0(
            year: int.parse(map!['year']),
            maintenanceCost: double.parse(map['maintenance_cost']),
            depreciationCost: double.parse(map['depreciation_cost']),
          ),
        ],
      );
    });
  }

  Future<void> _onEditRowPressed(BuildContext context, int rowIndex) async {
    late final Map<String, dynamic>? map;

    if (context.mounted) {
      map = await showDialog(
        context: context,
        builder: (context) {
          return AddOrEditRowDialog(
            isCreateNotEdit: false,
            initialRowValue: RowModel0.fromModel1(_tableModel.rows[rowIndex]),
          );
        },
      );
    }
    if (map == null || map.isEmpty) return;

    final List<RowModel0> currentRows = [];
    for (int i = 0; i < _tableModel.rows.length; i++) {
      currentRows.add(RowModel0.fromModel1(_tableModel.rows[i]));
    }
    final editedRow = RowModel0(
      year: int.parse(map['year']),
      maintenanceCost: double.parse(map['maintenance_cost']),
      depreciationCost: double.parse(map['depreciation_cost']),
    );
    currentRows.replaceRange(rowIndex, rowIndex + 1, [editedRow]);
    setState(() {
      _tableModel = TableModel.createFromRowModels(
        rows: [...currentRows],
      );
    });
  }

  Future<void> _onDeleteRowPressed(BuildContext context, int rowIndex) async {
    final List<RowModel0> currentRows = [];
    for (int i = 0; i < _tableModel.rows.length; i++) {
      currentRows.add(RowModel0.fromModel1(_tableModel.rows[i]));
    }
    currentRows.removeAt(rowIndex);
    setState(() {
      _tableModel = TableModel.createFromRowModels(rows: currentRows);
    });
  }
}
