import 'package:app/view/provider/summaryProvider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class linechart extends StatelessWidget {
  const linechart({super.key, required this.dataByDate});
  final List<double> dataByDate;

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
            width: 350,
            height: 380,
            child: LineChart(
              duration: Durations.medium3,
              LineChartData(
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
                            minIncluded: false,
                            maxIncluded: false,
                            interval: 2,
                            reservedSize: 25,
                            showTitles: true,
                            getTitlesWidget: bottomTitles))),
                lineBarsData: [
                  LineChartBarData(
                    spots: lineData(),
                    color: Colors.cyan,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  List<FlSpot> lineData() {
    return List.generate(dataByDate.length, (i) {
      return FlSpot(
          (i + 1).toDouble(),
          dataByDate[i] < 0
              ? (dataByDate[i] * -1).roundToDouble()
              : dataByDate[i].roundToDouble());
    });
  }

  Widget bottomTitles(double val, TitleMeta meta) {
    const style = TextStyle(
        color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 10);
    Widget text = const Text("");
    text = Text(
      val.toInt().toString(),
      style: style,
    );
    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }
}
