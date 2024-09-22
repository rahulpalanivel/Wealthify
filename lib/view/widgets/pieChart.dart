// ignore_for_file: non_constant_identifier_names

import 'package:app/utils/collections.dart' as collections;
import 'package:app/view/provider/summaryProvider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pchart extends StatelessWidget {
  const Pchart({super.key, required this.dataByCategory});
  final List<double> dataByCategory;

  @override
  Widget build(BuildContext context) {
    return Consumer<summaryProvider>(builder: (context, provider, child) {
      //provider.defaultValues(0, 0);

      return Container(
        height: 360,
        width: 360,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(124, 161, 159, 0.294),
              offset: Offset(0, 6),
              blurRadius: 12,
              spreadRadius: 6,
            ),
          ],
          color: const Color.fromARGB(255, 243, 237, 247),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: SizedBox(
            height: 250,
            child: PieChart(
              checkVal(dataByCategory)
                  ? PieChartData(
                      sections: dataSet(dataByCategory),
                      sectionsSpace: 0,
                      centerSpaceRadius: 0,
                      startDegreeOffset: 90)
                  : PieChartData(sections: [
                      PieChartSectionData(
                        value: 100,
                        color: Colors.white,
                        showTitle: false,
                        radius: 60,
                      )
                    ], sectionsSpace: 0, centerSpaceRadius: 60),
              swapAnimationDuration: Durations.medium3,
            ),
          ),
        ),
      );
    });
  }

  List<PieChartSectionData> dataSet(List data) {
    return List.generate(12, (i) {
      return PieChartSectionData(
          value: dataByCategory[i] < 0
              ? (dataByCategory[i] * -1)
              : dataByCategory[i],
          color: collections.colorList[i],
          showTitle: false,
          radius: 160,
          badgeWidget: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(collections.Icon[i]),
          ),
          badgePositionPercentageOffset: 1);
    });
  }

  bool checkVal(List data) {
    if (data.every((e) => e == 0)) {
      return false;
    }
    return true;
  }
}
