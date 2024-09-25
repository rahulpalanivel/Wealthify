// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:io';

import 'package:app/data/model/Finance.dart';
import 'package:app/data/repository/dbRepository.dart' as dbrepository;
import 'package:app/utils/collections.dart' as collections;
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

List<String> formatDate(DateTime datetime) {
  String date = DateFormat.d().format(datetime);
  String monthName = DateFormat.MMMM().format(datetime);
  String year = DateFormat.y().format(datetime);
  List<String> datemonth = [date, monthName, year];
  return datemonth;
}

String formatAmount(double amount) {
  final formatter = NumberFormat.currency(locale: 'hi_IN', symbol: '₹');
  String value = formatter.format(amount);
  return value;
}

IconData iconForCategory(String Transcategory) {
  int idx = 0;
  idx = collections.Categories.indexOf(Transcategory);
  if (idx == -1) {
    idx = 0;
  }
  return collections.Icon[idx];
}

String findCategory(String desc) {
  String category = "Others";
  for (int i = 0; i < collections.categoriesAndKeywords.length; i++) {
    for (int j = 1; j < collections.categoriesAndKeywords[i].length; j++) {
      if (desc
          .toLowerCase()
          .contains(collections.categoriesAndKeywords[i][j])) {
        category = collections.categoriesAndKeywords[i][0];
        break;
      }
    }
  }
  return category;
}

List<double> getAmount(List<Finance> Records) {
  double income = 0;
  double expense = 0;
  for (int i = 0; i < Records.length; i++) {
    if (Records[i].amount >= 0) {
      income = income + Records[i].amount;
    } else {
      expense = expense + Records[i].amount;
    }
  }
  List<double> val = [];
  val.add(income);
  val.add(expense);

  return val;
}

double getAmountByCategory(List<Finance> Records, String Catergory) {
  double amount = 0;
  List<Finance> CategoryRecords =
      Records.where((element) => element.trancCategory == Catergory).toList();
  for (int i = 0; i < CategoryRecords.length; i++) {
    amount = amount + CategoryRecords[i].amount;
  }
  return amount;
}

double getamtforBudget(DateTime date, String category, String duration) {
  double amount = 0;
  if (duration == "Yearly") {
    amount = getAmountByCategory(
        dbrepository
            .getRecords()
            .where(
                (element) => formatDate(element.date)[2] == formatDate(date)[2])
            .toList(),
        category);
  }
  if (duration == "Monthly") {
    amount = getAmountByCategory(
        dbrepository
            .getRecords()
            .where((element) =>
                formatDate(element.date)[1] == formatDate(date)[1] &&
                formatDate(element.date)[2] == formatDate(date)[2])
            .toList(),
        category);
  }

  if (amount < 0) {
    amount = amount * -1;
  }
  return amount;
}

List<double> getAmountByDate(List<Finance> records) {
  Map<int, double> dailySums = {};
  for (var finance in records) {
    int day = finance.date.day;
    if (!dailySums.containsKey(day)) {
      dailySums[day] = 0;
    }
    dailySums[day] = dailySums[day]! + finance.amount;
  }
  List<double> amount = List<double>.filled(31, 0);
  dailySums.forEach((day, sum) {
    amount[day - 1] = sum;
  });
  return amount;
}

List<double> getAmountByMonth(List<Finance> records) {
  Map<int, double> monthlySums = {};
  for (var finance in records) {
    int month = finance.date.month;
    if (!monthlySums.containsKey(month)) {
      monthlySums[month] = 0;
    }
    monthlySums[month] = monthlySums[month]! + finance.amount;
  }
  List<double> amount = List<double>.filled(12, 0);
  monthlySums.forEach((month, sum) {
    amount[month - 1] = sum;
  });
  return amount;
}

List<String> getYearList(List<Finance> records) {
  List<String> yearList = [];
  if (records.isNotEmpty) {
    records.sort((a, b) => a.date.compareTo(b.date));
    int startYear = int.parse(formatDate(records.first.date)[2]);
    int endYear = int.parse(formatDate(records.last.date)[2]);
    for (int i = startYear; i <= endYear; i++) {
      yearList.add(i.toString());
    }
  }
  return yearList;
}

//////////==========>>>>>>>>>> File Selection <<<<<<<<<<==========//////////

Future<String?> pickXLSXFile() async {
  final result = await FilePicker.platform
      .pickFiles(type: FileType.custom, allowedExtensions: ['xlsx']);
  if (result != null) {
    return result.files.single.path;
  }
  return null;
}

List<List<dynamic>> parseXLSXFile(String filePath) {
  final bytes = File(filePath).readAsBytesSync();
  final excel = Excel.decodeBytes(bytes);

  final sheet = excel.sheets['Sheet 1'];
  final rows = sheet!.rows;

  return rows
      .map((row) => row.map((cell) => cell?.value.toString()).toList())
      .toList();
}

//////////==========>>>>>>>>>> Read SMS<<<<<<<<<<==========//////////

Future<List<String>> readSms() async {
  const smsChannel = MethodChannel("smsPlatform");
  try {
    final String result = await smsChannel.invokeMethod('readAllSms');
    print(result);
    String res = result.replaceAll('[', '').replaceAll(']', '').trim();
    List<String> list = res.split(', ');

    return list;
  } on PlatformException catch (e) {
    print("Internal Error: $e.message");
  }
  return [];
}
