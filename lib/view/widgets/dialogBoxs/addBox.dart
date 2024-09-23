import 'package:app/view/widgets/dialogBoxs/Cash-Record.dart';
import 'package:app/view/widgets/dialogBoxs/bank-statement.dart';
import 'package:app/view/widgets/dialogBoxs/budget-tab-dialog-screen.dart';
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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const BankStatement(
                        selectedTotal: true,
                        selectedMonth: 0,
                        selectedYear: "0",
                      );
                    },
                  );
                },
                style: ButtonStyle(
                    backgroundColor:
                        const WidgetStatePropertyAll(Colors.lightBlue),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    )),
                child: const Text(
                  "Add Bank statement",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const CashRecord(
                            selectedTotal: true,
                            selectedYear: "0",
                            selectedMonth: 0,
                          );
                        });
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          const WidgetStatePropertyAll(Colors.lightBlue),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      )),
                  child: const Text(
                    "Add Cash Record",
                    style: TextStyle(color: Colors.white),
                  )),
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
                  style: ButtonStyle(
                      backgroundColor:
                          const WidgetStatePropertyAll(Colors.lightBlue),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      )),
                  child: const Text(
                    "Add new Budget",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
