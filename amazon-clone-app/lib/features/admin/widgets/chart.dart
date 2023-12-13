import 'package:flutter/material.dart';
import 'package:charts_flutter_maintained/charts_flutter_maintained.dart'
    as charts;
import 'package:amazoncloneapp/features/admin/models/sales.dart';

class SalesCharts extends StatelessWidget {
  final List<charts.Series<Sales, String>> seriesList;
  const SalesCharts({super.key, required this.seriesList});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}
