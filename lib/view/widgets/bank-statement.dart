// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, use_build_context_synchronously, sized_box_for_whitespace

import 'package:app/domain/repository/repository.dart' as repository;
import 'package:app/view/pages/transaction-datadisplay-tab.dart';
import 'package:app/view/widgets/DropDownBox.dart';
import 'package:flutter/material.dart';

class BankStatement extends StatefulWidget {
  const BankStatement({
    super.key,
    required this.selectedTotal,
    required this.selectedMonth,
    required this.selectedYear,
  });

  final bool selectedTotal;
  final String selectedYear;
  final int selectedMonth;

  @override
  State<BankStatement> createState() => _BankStatementState();
}

class _BankStatementState extends State<BankStatement> {
  List<String> Items = ["Bank1", "Bank2", "Bank3", "Other"];
  String SelectedItem = "Other";

  List<List<dynamic>> Data = [];
  void pickAndDisplayData() async {
    final filePath = await repository.pickXLSXFile();
    if (filePath != null) {
      Data = repository.parseXLSXFile(filePath);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TransactionData(
                  data: Data,
                  account: SelectedItem,
                  selectedTotal: widget.selectedTotal,
                  selectedMonth: widget.selectedMonth,
                  selectedYear: widget.selectedYear,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            "Select Bank : ",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 15,
          ),
          DropDownBox(
            items: Items,
            defaultItem: SelectedItem,
            updatedValue: (String value) {
              SelectedItem = value;
            },
          ),
          SizedBox(
            height: 15,
          ),
          IconButton(
              onPressed: pickAndDisplayData,
              icon: const CircleAvatar(
                backgroundColor: Colors.lightBlue,
                radius: 20.0,
                child: Icon(Icons.add, color: Colors.white),
              )),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
