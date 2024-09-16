import 'package:app/view/widgets/Cash-Record.dart';
import 'package:app/view/widgets/bank-statement.dart';
import 'package:app/view/widgets/budget-tab-dialog-screen.dart';
import 'package:flutter/material.dart';

class Addbox extends StatelessWidget {
  const Addbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: () => {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const BankStatement(
                              selectedTotal: true,
                              selectedMonth: 0,
                              selectedYear: "0",
                            );
                          },
                        )
                      },
                  child: const Text("Add Bank statement")),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: () => {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const CashRecord(
                                selectedTotal: true,
                                selectedYear: "0",
                                selectedMonth: 0,
                              );
                            }),
                        // provider.yearList =
                        //     repository.getYearList(dbrepository.getRecords())
                      },
                  child: const Text("Add Cash Record")),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const BudgetDialog();
                      },
                    );
                  },
                  child: const Text("Add new Budget")),
            ),
          ],
        ),
      ),
    );
  }
}
