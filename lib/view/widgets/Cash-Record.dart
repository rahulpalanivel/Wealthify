// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:app/data/dbRepository.dart' as dbrepository;
import 'package:app/domain/model/Finance.dart';
import 'package:app/utils/collections.dart' as collections;
import 'package:app/view/provider/summaryProvider.dart';
import 'package:app/view/provider/transactionProvider.dart';
import 'package:app/view/widgets/DropDownBox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CashRecord extends StatefulWidget {
  const CashRecord(
      {super.key,
      required this.selectedTotal,
      required this.selectedYear,
      required this.selectedMonth});
  final bool selectedTotal;
  final String selectedYear;
  final int selectedMonth;

  @override
  State<CashRecord> createState() => _CashRecordState();
}

class _CashRecordState extends State<CashRecord> {
  List<String> Categories = collections.Categories;
  String SelectedCategory = collections.Categories.first;
  List<String> Transaction = ["Income", "Expense"];
  String SelectedTranc = "Expense";

  TextEditingController dateController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  DateTime selectdate = DateTime.now();

  Future<void> selectDate() async {
    DateTime? select = await showDatePicker(
        context: context,
        currentDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2500));

    if (select != null) {
      setState(() {
        dateController.text = select.toString().split(" ")[0];
        selectdate = select;
      });
    }
  }

  void addCashRecord(String tranc, DateTime date, String desc, String category,
      double amount) {
    if (tranc == "Expense") {
      amount = amount * -1;
    }
    var finance = Finance(" ", " ", date, desc, tranc, category, amount);
    dbrepository.addRecord(finance);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<summaryProvider>(context, listen: false);
    final tprovider = Provider.of<transactionProvider>(context, listen: false);

    bool selectedTotal = widget.selectedTotal;
    String selectedYear = widget.selectedYear;
    int selectedMonth = widget.selectedMonth;

    return Dialog(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Add new Record",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Transaction:"),
                    DropDownBox(
                      items: Transaction,
                      defaultItem: SelectedTranc,
                      updatedValue: (String value) {
                        SelectedTranc = value;
                      },
                    )
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Date:"),
                  SizedBox(
                      height: 50,
                      width: 150,
                      child: TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: const Color.fromARGB(125, 0, 0, 0),
                                    width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(125, 0, 0, 0),
                                    width: 2))),
                        onTap: () {
                          selectDate();
                        },
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Description:"),
                    SizedBox(
                        height: 50,
                        width: 150,
                        child: TextField(
                          controller: descController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(125, 0, 0, 0),
                                      width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(125, 0, 0, 0),
                                      width: 2))),
                        ))
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Category:"),
                    DropDownBox(
                      items: Categories,
                      defaultItem: SelectedCategory,
                      updatedValue: (String value) {
                        SelectedCategory = value;
                      },
                    )
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Amount:"),
                    SizedBox(
                        height: 50,
                        width: 150,
                        child: TextField(
                            controller: amountController,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(125, 0, 0, 0),
                                        width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(125, 0, 0, 0),
                                        width: 2)))))
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    addCashRecord(
                        SelectedTranc,
                        selectdate,
                        descController.text,
                        SelectedCategory,
                        double.parse(amountController.text));
                    Navigator.pop(context);
                    provider.updateValues(0, 0);
                    provider.updateRecords();
                    if (selectedTotal) {
                      tprovider.updateRecords(0, 0);
                    } else {
                      tprovider.updateRecords(
                          selectedMonth, int.parse(selectedYear));
                    }
                  },
                  child: Text("Confirm")),
            )
          ]),
    );
  }
}
