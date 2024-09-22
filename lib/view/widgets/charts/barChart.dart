import 'package:app/view/provider/summaryProvider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class barChart extends StatelessWidget {
  const barChart({super.key, required this.dataByCategory});
  final List<double> dataByCategory;

  @override
  Widget build(BuildContext context) {
    return Consumer<summaryProvider>(builder: (context, provider, child) {
      return Container(
        height: 420,
        width: 380,
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
            height: 380,
            child: BarChart(
              swapAnimationDuration: Durations.medium3,
              BarChartData(
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                        reservedSize: 40,
                        showTitles: true,
                        getTitlesWidget: bottomTitles),
                  ),
                ),
                barGroups: dataSet(),
              ),
            ),
          ),
        ),
      );
    });
  }

  List<BarChartGroupData> dataSet() {
    return List.generate(dataByCategory.length, (i) {
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
              toY: dataByCategory[i].roundToDouble() < 0
                  ? dataByCategory[i].roundToDouble() * -1
                  : dataByCategory[i].roundToDouble(),
              color: Colors.cyan,
              width: 15,
              borderRadius: BorderRadius.circular(4)),
        ],
      );
    });
  }

  bool checkVal(List data) {
    if (data.every((e) => e == 0)) {
      return false;
    }
    return true;
  }

  Widget bottomTitles(double val, TitleMeta meta) {
    const style = TextStyle(
        color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14);
    Widget text = const Text("");
    switch (val.toInt()) {
      case 0:
        text = const Text(
          'Jan',
          style: style,
        );
        break;
      case 1:
        text = const Text(
          'Feb',
          style: style,
        );
        break;
      case 2:
        text = const Text(
          'Mar',
          style: style,
        );
        break;
      case 3:
        text = const Text(
          'Apr',
          style: style,
        );
        break;
      case 4:
        text = const Text(
          'May',
          style: style,
        );
        break;
      case 5:
        text = const Text(
          'Jun',
          style: style,
        );
        break;
      case 6:
        text = const Text(
          'Jul',
          style: style,
        );
        break;
      case 7:
        text = const Text(
          'Aug',
          style: style,
        );
        break;
      case 8:
        text = const Text(
          'Sep',
          style: style,
        );
        break;
      case 9:
        text = const Text(
          'Oct',
          style: style,
        );
        break;
      case 10:
        text = const Text(
          'Nov',
          style: style,
        );
        break;
      case 11:
        text = const Text(
          'Dec',
          style: style,
        );
        break;
      default:
        break;
    }
    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }
}