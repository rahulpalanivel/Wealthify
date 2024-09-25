import 'package:app/data/model/Finance.dart';
import 'package:app/domain/repository.dart' as repository;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class sms extends StatefulWidget {
  const sms({super.key});

  @override
  State<sms> createState() => _smsState();
}

class _smsState extends State<sms> {
  static const smsChannel = MethodChannel("smsPlatform");
  List<String> listt = [];
  List<Finance> flist = [];
  //var messages = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TextButton(
            onPressed: () async {
              try {
                final List<Object?> result =
                    await smsChannel.invokeMethod('readAllSms');
                //print(result.length);
                for (int i = 0; i < result.length; i++) {
                  if (result[i].toString().contains("AxisBK") ||
                      result[i].toString().contains("AXISBK")) {
                    if (result[i].toString().contains("Debit")) {
                      String str = result[i].toString().split("Message: ")[1];

                      List<String> ls = str.split("\n");

                      double amt = double.parse(ls[1].split(" ")[1]) * -1;

                      DateFormat format = DateFormat("dd-MM-yy");

                      String dt = ls[3].toString();
                      DateTime date = format.parse(dt);

                      String desc = ls[4];

                      String trancCategory = repository.findCategory(desc);

                      var finance = Finance(
                          " ", " ", date, desc, "Expense", trancCategory, amt);

                      if (!repository.checkIfExist(finance)) {
                        flist.add(finance);
                      }
                    } else if (result[i].toString().contains("credited")) {}
                  }
                }
                print(flist.length);
                setState(() {
                  listt = flist
                      .map((e) =>
                          "Narration: " +
                          e.desc.toString() +
                          " Amount: " +
                          e.amount.toString())
                      .toList();
                });
              } on PlatformException catch (e) {
                print("Internal Error: $e.message");
              }
            },
            child: Text("read sms"),
          ),
          listt.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(listt[index]),
                    );
                  },
                  itemCount: flist.length,
                ))
              : SizedBox()
        ],
      )),
    );
  }
}
