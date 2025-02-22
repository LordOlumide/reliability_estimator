import 'package:flutter/material.dart';
import 'package:reliability_estimator/src/screens/analyse_cost_screen/model/row_model.dart';
import 'package:reliability_estimator/src/screens/analyse_cost_screen/model/table_model.dart';

class AnalyseCostRepo extends ChangeNotifier {
  TableModel _tableModel = TableModel.createFromRowModels(rows: []);

  TableModel get tableModel => _tableModel;

  int? get lowestCostRowIndex => _tableModel.getRowIndexWithLowestAverageCost();

  RowModel1? get lowestCostRow =>
      lowestCostRowIndex != null ? _tableModel.rows[lowestCostRowIndex!] : null;

  void updateTableModel(TableModel newModel) {
    _tableModel = newModel;
    notifyListeners();
  }
}
