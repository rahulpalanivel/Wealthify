import 'package:app/view/provider/summaryProvider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FLow extends StatelessWidget {
  const FLow({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<summaryProvider>(builder: (context, provider, child) {
      provider.defaultValues(0, 0);

      double FoodnDrinks = provider.FoodnDrinks < 0
          ? (provider.FoodnDrinks * -1)
          : provider.FoodnDrinks;
      double Shopping =
          provider.Shopping < 0 ? (provider.Shopping * -1) : provider.Shopping;
      double Groceries = provider.Groceries < 0
          ? (provider.Groceries * -1)
          : provider.Groceries;
      double Medical =
          provider.Medical < 0 ? (provider.Medical * -1) : provider.Medical;
      double Bills =
          provider.Bills < 0 ? (provider.Bills * -1) : provider.Bills;
      double Travel =
          provider.Travel < 0 ? (provider.Travel * -1) : provider.Travel;
      double Transfer =
          provider.Transfer < 0 ? (provider.Transfer * -1) : provider.Transfer;
      double CreditCard = provider.CreditCard < 0
          ? (provider.CreditCard * -1)
          : provider.CreditCard;
      double Education = provider.Education < 0
          ? (provider.Education * -1)
          : provider.Education;
      double Home = provider.Home < 0 ? (provider.Home * -1) : provider.Home;
      double Salary =
          provider.Salary < 0 ? (provider.Salary * -1) : provider.Salary;
      double Others =
          provider.Others < 0 ? (provider.Others * -1) : provider.Others;

      List data = [FoodnDrinks, Shopping, Groceries, Medical, Bills, Travel, Transfer, CreditCard, Education, Home, Salary, Others];

      return Container(
        height: 320,
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
              checkVal(data)
                  ? PieChartData(
                      sections: data(),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      startDegreeOffset: 90)
                  : PieChartData(sections: [
                      PieChartSectionData(
                        value: 100,
                        color: Colors.white,
                        showTitle: false,
                        radius: 60,
                      )
                    ], sectionsSpace: 0, centerSpaceRadius: 60),
            ),
          ),
        ),
      );
    });
  }

  bool checkVal(List data) {
    for
    return true;
  }

  List<PieChartSectionData> data() {
    return [];
  }
}
