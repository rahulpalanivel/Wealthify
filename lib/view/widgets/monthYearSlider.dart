import 'package:app/data/repository/dbRepository.dart' as dbrepository;
import 'package:app/domain/repository.dart' as repository;
import 'package:app/utils/collections.dart' as collections;
import 'package:app/view/provider/transactionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Monthyearslider extends StatelessWidget {
  const Monthyearslider({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    bool selectedTotal = true;
    int currentYear = 0;
    List<String> months = collections.months;
    List<String> yearList = repository.getYearList(dbrepository.getRecords());
    return Consumer<transactionProvider>(
      builder: (context, provider, child) {
        return SizedBox(
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
                        selectedIndex = i,
                        provider.updateRecords(
                            i, int.parse(yearList[currentYear]))
                      },
                  },
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(
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
        );
      },
    );
  }
}
