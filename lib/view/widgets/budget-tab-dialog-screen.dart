// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, sized_box_for_whitespace

import 'package:app/data/dbRepository.dart' as dbrepository;
import 'package:app/utils/collections.dart' as collections;
import 'package:app/view/provider/summaryProvider.dart';
import 'package:app/view/widgets/DropDownBox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BudgetDialog extends StatefulWidget {
  const BudgetDialog({super.key});

  @override
  State<BudgetDialog> createState() => _BudgetDialogState();
}

class _BudgetDialogState extends State<BudgetDialog> {
  List<String> Items = collections.Categories;
  String SelectedItem = "Others";
  List<String> Duration = ["Monthly", "Yearly"];
  String SelectedDuration = "Monthly";
  final amountcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<summaryProvider>(context, listen: false);
    return Dialog(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            "Set Budget: ",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Category:"),
                DropDownBox(
                    items: Items,
                    defaultItem: SelectedItem,
                    updatedValue: (String value) {
                      SelectedItem = value;
                    }),
              ],
            )),
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Type:"),
              DropDownBox(
                items: Duration,
                defaultItem: SelectedDuration,
                updatedValue: (String value) {
                  SelectedDuration = value;
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Amount:"),
              Container(
                height: 50,
                width: 150,
                child: TextField(
                    controller: amountcontroller,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(125, 0, 0, 0), width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(125, 0, 0, 0),
                                width: 2)))),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () => {
            dbrepository.newBudget(SelectedItem, SelectedDuration,
                double.parse(amountcontroller.text)),
            provider.updateBudgets(),
            Navigator.pop(context)
          },
          child: Text("Confirm"),
        ),
      ],
    ));
  }
}
