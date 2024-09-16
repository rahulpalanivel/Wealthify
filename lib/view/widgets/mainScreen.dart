import 'package:app/view/pages/Budget-tab.dart';
import 'package:app/view/pages/Summary-tab.dart';
import 'package:app/view/pages/Transactions-tab.dart';
import 'package:app/view/pages/new-home-screen.dart';
import 'package:app/view/widgets/addBox.dart';
import 'package:app/view/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int index_color = 0;
  List Screen = [Home(), SummaryTab(), TransactionTab(), BudgetTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: const Text('Welcome Rahul'),
      ),
      body: Screen[index_color],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Addbox();
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 33, 150, 243),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 0;
                  });
                },
                child: Icon(
                  Icons.home,
                  size: 30,
                  color: index_color == 0
                      ? Color.fromARGB(255, 33, 150, 243)
                      : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 1;
                  });
                },
                child: Icon(
                  Icons.bar_chart_outlined,
                  size: 30,
                  color: index_color == 1
                      ? Color.fromARGB(255, 33, 150, 243)
                      : Colors.grey,
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 2;
                  });
                },
                child: Icon(
                  Icons.history_outlined,
                  size: 30,
                  color: index_color == 2
                      ? Color.fromARGB(255, 33, 150, 243)
                      : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 3;
                  });
                },
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 30,
                  color: index_color == 3
                      ? Color.fromARGB(255, 33, 150, 243)
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
