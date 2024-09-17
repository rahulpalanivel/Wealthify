// ignore_for_file: unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, non_constant_identifier_names, must_be_immutable

import 'package:app/data/repository/dbRepository.dart' as dbrepository;
import 'package:app/domain/repository.dart' as repository;
import 'package:app/utils/collections.dart' as collections;
import 'package:app/view/provider/summaryProvider.dart';
import 'package:app/view/widgets/Categories.dart';
import 'package:app/view/widgets/TransactionBox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SummaryTab extends StatelessWidget {
  SummaryTab({super.key});
  int _selectedIndex = 0;
  bool selectedTotal = true;

  List<String> months = collections.months;
  List<String> yearList = repository.getYearList(dbrepository.getRecords());
  int currentYear = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<summaryProvider>(context, listen: true);
    provider.defaultValues(0, 0);

    return Consumer<summaryProvider>(
      builder: (context, providerValue, child) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TransactionBox(
                          color: Colors.green,
                          value: providerValue.incoming,
                          type: 'Incoming',
                        ),
                        TransactionBox(
                          color: Colors.blue,
                          value:
                              (providerValue.incoming + providerValue.outgoing),
                          type: 'Balance',
                        ),
                        TransactionBox(
                          color: Colors.red,
                          value: providerValue.outgoing,
                          type: 'Outgoing',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 35,
                          width: 400,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    selectedTotal = true;
                                    provider.updateValues(0, 0);
                                  },
                                  child: Text("Total",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: selectedTotal == true
                                              ? Colors.black
                                              : const Color.fromARGB(
                                                  255, 200, 202, 202)))),
                              IconButton(
                                  onPressed: () {
                                    if (currentYear > 0) {
                                      currentYear--;
                                      selectedTotal = false;
                                      _selectedIndex = 0;
                                      provider.updateValues(
                                          0, int.parse(yearList[currentYear]));
                                    }
                                  },
                                  icon: Icon(Icons.arrow_back)),
                              Text(
                                  yearList.isNotEmpty
                                      ? yearList[currentYear]
                                      : "null",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              IconButton(
                                  onPressed: () {
                                    if (currentYear < (yearList.length - 1)) {
                                      currentYear++;
                                      selectedTotal = false;
                                      _selectedIndex = 0;
                                      provider.updateValues(
                                          0, int.parse(yearList[currentYear]));
                                    }
                                  },
                                  icon: Icon(Icons.arrow_forward))
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 400,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: [
                              for (int i = 0; i < months.length; i++)
                                TextButton(
                                  onPressed: () => {
                                    if (yearList.isNotEmpty)
                                      {
                                        selectedTotal = false,
                                        _selectedIndex = i,
                                        provider.updateValues(
                                            i, int.parse(yearList[currentYear]))
                                      },
                                  },
                                  style: ButtonStyle(
                                    foregroundColor: WidgetStateProperty.all(
                                      selectedTotal == true
                                          ? const Color.fromARGB(
                                              255, 200, 202, 202)
                                          : _selectedIndex == i
                                              ? const Color.fromARGB(
                                                  255, 0, 0, 0)
                                              : const Color.fromARGB(
                                                  255, 200, 202, 202),
                                    ),
                                  ),
                                  child: Text(months[i]),
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.count(
                  //physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: [
                    Category(
                        category: 'Food & Drinks',
                        value: providerValue.FoodnDrinks),
                    Category(
                        category: 'Shopping', value: providerValue.Shopping),
                    Category(
                        category: 'Groceries', value: providerValue.Groceries),
                    Category(category: 'Medical', value: providerValue.Medical),
                    Category(category: 'Bills', value: providerValue.Bills),
                    Category(category: 'Travel', value: providerValue.Travel),
                    Category(
                        category: 'Transfer', value: providerValue.Transfer),
                    Category(
                        category: 'Credit Card',
                        value: providerValue.CreditCard),
                    Category(
                        category: 'Education', value: providerValue.Education),
                    Category(category: 'Home', value: providerValue.Home),
                    Category(category: 'Salary', value: providerValue.Salary),
                    Category(category: 'Others', value: providerValue.Others),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
