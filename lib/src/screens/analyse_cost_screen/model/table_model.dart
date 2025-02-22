import 'package:reliability_estimator/src/screens/analyse_cost_screen/model/row_model.dart';

class TableModel {
  final List<RowModel1> rows;

  const TableModel._(this.rows);

  factory TableModel.createFromRowModels({required List<RowModel0> rows}) {
    final List<RowModel1> newRows = [];
    double cumulativeMaintenanceCost = 0;
    rows.sort((a, b) => a.year.compareTo(b.year));

    for (int i = 0; i < rows.length; i++) {
      final row = rows[i];
      cumulativeMaintenanceCost += row.maintenanceCost;

      final double totalCost = cumulativeMaintenanceCost + row.depreciationCost;
      final double averageCost = totalCost / row.year;

      final RowModel1 newRow = RowModel1(
        year: row.year,
        maintenanceCost: row.maintenanceCost,
        cumulativeMaintenanceCost: cumulativeMaintenanceCost,
        depreciationCost: row.depreciationCost,
        totalCost: totalCost,
        averageCost: averageCost,
      );
      newRows.add(newRow);
    }

    return TableModel._(newRows);
  }

  int? getRowIndexWithLowestAverageCost() {
    if (rows.isNotEmpty) {
      int index = 0;
      for (int i = 0; i < rows.length; i++) {
        if (rows[i].averageCost < rows[index].averageCost) {
          index = i;
        }
      }
      return index;
    }
    return null;
  }
}
