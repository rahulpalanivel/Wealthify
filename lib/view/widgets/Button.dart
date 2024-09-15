// ignore_for_file: avoid_unnecessary_containers

import 'package:app/data/dbRepository.dart' as dbrepository;
import 'package:app/domain/repository/repository.dart' as repository;
import 'package:app/utils/collections.dart' as collections;
import 'package:app/view/provider/summaryProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    bool selectedTotal = true;

    List<String> months = collections.months;
    List<String> yearList = repository.getYearList(dbrepository.getRecords());
    int currentYear = 0;

    final provider = Provider.of<summaryProvider>(context, listen: false);
    return Container(
      child: Column(children: [
        Row(
          children: [
            SizedBox(
              height: 35,
              width: MediaQuery.of(context).size.width,
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
                                  : const Color.fromARGB(255, 200, 202, 202)))),
                  IconButton(
                      onPressed: () {
                        if (currentYear > 0) {
                          currentYear--;
                          selectedTotal = false;
                          selectedIndex = 0;
                          provider.updateValues(
                              0, int.parse(yearList[currentYear]));
                        }
                      },
                      icon: const Icon(Icons.arrow_back)),
                  Text(yearList.isNotEmpty ? yearList[currentYear] : "null",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  IconButton(
                      onPressed: () {
                        if (currentYear < (yearList.length - 1)) {
                          currentYear++;
                          selectedTotal = false;
                          selectedIndex = 0;
                          provider.updateValues(
                              0, int.parse(yearList[currentYear]));
                        }
                      },
                      icon: const Icon(Icons.arrow_forward))
                ],
              ),
            )
          ],
        ),
        //Second row
        Row(
          children: [
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
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
                            selectedIndex = i,
                            provider.updateValues(
                                i, int.parse(yearList[currentYear]))
                          },
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(
                          selectedTotal == true
                              ? const Color.fromARGB(255, 200, 202, 202)
                              : selectedIndex == i
                                  ? const Color.fromARGB(255, 0, 0, 0)
                                  : const Color.fromARGB(255, 200, 202, 202),
                        ),
                      ),
                      child: Text(months[i]),
                    ),
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }
}
