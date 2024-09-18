// ignore_for_file: non_constant_identifier_names

import 'package:app/view/pages/Budget-tab.dart';
import 'package:app/view/pages/Summary-tab.dart';
import 'package:app/view/pages/Transactions-tab.dart';
import 'package:app/view/pages/home-screen.dart';
import 'package:app/view/widgets/addBox.dart';
import 'package:app/view/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int index = 0;
  List Screen = [
    const Home(),
    SummaryTab(),
    const TransactionTab(),
    const BudgetTab()
  ];
  List Titles = [
    "Welcome Rahul",
    "Transaction Overview",
    "Transaction Records",
    "Budgets"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 237, 247),
        shadowColor: const Color.fromARGB(255, 243, 237, 247),
        elevation: 1,
        scrolledUnderElevation: 1,
        surfaceTintColor: const Color.fromARGB(255, 243, 237, 247),
        toolbarHeight: 80,
        title: Text(
          Titles[index],
          style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: Color.fromARGB(255, 27, 118, 192)),
        ),
      ),
      body: Screen[index],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Addbox();
              });
        },
        backgroundColor: const Color.fromARGB(255, 33, 150, 243),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 0;
                  });
                },
                child: Icon(
                  Icons.home,
                  size: 30,
                  color: index == 0
                      ? const Color.fromARGB(255, 33, 150, 243)
                      : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 1;
                  });
                },
                child: Icon(
                  Icons.bar_chart_outlined,
                  size: 30,
                  color: index == 1
                      ? const Color.fromARGB(255, 33, 150, 243)
                      : Colors.grey,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 2;
                  });
                },
                child: Icon(
                  Icons.history_outlined,
                  size: 30,
                  color: index == 2
                      ? const Color.fromARGB(255, 33, 150, 243)
                      : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 3;
                  });
                },
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 30,
                  color: index == 3
                      ? const Color.fromARGB(255, 33, 150, 243)
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
