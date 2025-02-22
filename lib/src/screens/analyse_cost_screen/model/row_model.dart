class RowModel0 {
  final int year;
  final double maintenanceCost;
  final double depreciationCost;

  const RowModel0({
    required this.year,
    required this.maintenanceCost,
    required this.depreciationCost,
  });

  RowModel0 copyWith({
    int? year,
    double? maintenanceCost,
    double? depreciationCost,
  }) {
    return RowModel0(
      year: year ?? this.year,
      maintenanceCost: maintenanceCost ?? this.maintenanceCost,
      depreciationCost: depreciationCost ?? this.depreciationCost,
    );
  }

  factory RowModel0.fromModel1(RowModel1 row) {
    return RowModel0(
      year: row.year,
      maintenanceCost: row.maintenanceCost,
      depreciationCost: row.depreciationCost,
    );
  }
}

class RowModel1 {
  final int year;
  final double maintenanceCost;
  final double cumulativeMaintenanceCost;
  final double depreciationCost;
  final double totalCost;
  final double averageCost;

  const RowModel1({
    required this.year,
    required this.maintenanceCost,
    required this.cumulativeMaintenanceCost,
    required this.depreciationCost,
    required this.totalCost,
    required this.averageCost,
  });

  RowModel1 copyWith({
    int? year,
    double? maintenanceCost,
    double? cumulativeMaintenanceCost,
    double? depreciationCost,
    double? totalCost,
    double? averageCost,
  }) {
    return RowModel1(
      year: year ?? this.year,
      maintenanceCost: maintenanceCost ?? this.maintenanceCost,
      cumulativeMaintenanceCost:
          cumulativeMaintenanceCost ?? this.cumulativeMaintenanceCost,
      depreciationCost: depreciationCost ?? this.depreciationCost,
      totalCost: totalCost ?? this.totalCost,
      averageCost: averageCost ?? this.averageCost,
    );
  }
}
