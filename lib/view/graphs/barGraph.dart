import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class barGraph extends StatelessWidget {
  const barGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData());
  }
}
