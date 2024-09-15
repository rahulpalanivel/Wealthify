// ignore_for_file: prefer_const_constructors
import 'package:app/view/provider/summaryProvider.dart';
import 'package:app/view/provider/transactionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  void wipeData(BuildContext context) {
    final provider = Provider.of<summaryProvider>(context, listen: false);
    final tprovider = Provider.of<transactionProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(
          "Wipe Data",
          textAlign: TextAlign.center,
        ),
        contentPadding: EdgeInsets.all(10),
        children: [
          Text(
            "Are you sure you want to clear all data?",
            textAlign: TextAlign.center,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TextButton(
              onPressed: () => {Navigator.pop(context)},
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => {
                provider.deleteRecords(),
                provider.deleteBudgets(),
                provider.updateValues(0, 0),
                tprovider.deleteRecords(),
                Navigator.pop(context)
              },
              child: Text("Confirm"),
            )
          ])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Rahul Palanivel"),
            accountEmail: Text("rahulpalanivel@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(),
            ),
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 178, 175, 175)),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.cleaning_services),
            title: Text("Wipe Data"),
            onTap: () => {wipeData(context)},
          )
        ],
      ),
    );
  }
}
