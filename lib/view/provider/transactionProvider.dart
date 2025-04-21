// ignore_for_file: camel_case_types

import 'package:app/data/model/Finance.dart';
import 'package:app/data/repository/dbRepository.dart';
import 'package:app/domain/repository.dart';
import 'package:app/utils/collections.dart' as collections;
import 'package:flutter/material.dart';

class transactionProvider extends ChangeNotifier {
  List<String> months = collections.months;

  List<Finance> transactionRecords = [];
  List<String> yearList = [];

  void defaultValues(int month, int year) {
    if (month == 0 && year == 0) {
      transactionRecords = DbRepository.getRecords();
    } else if (month != 0) {
      transactionRecords = DbRepository.getRecords()
          .where((element) =>
              Repository.formatDate(element.date)[1].substring(0, 3) ==
                  months[month] &&
              Repository.formatDate(element.date)[2] == year.toString())
          .toList();
    } else {
      transactionRecords = DbRepository.getRecords()
          .where((element) =>
              Repository.formatDate(element.date)[2] == year.toString())
          .toList();
    }
    yearList = Repository.getYearList(DbRepository.getRecords());
  }

  void updateRecords(int month, int year) {
    if (month == 0 && year == 0) {
      transactionRecords = DbRepository.getRecords();
    } else if (month != 0) {
      transactionRecords = DbRepository.getRecords()
          .where((element) =>
              Repository.formatDate(element.date)[1].substring(0, 3) ==
                  months[month] &&
              Repository.formatDate(element.date)[2] == year.toString())
          .toList();
    } else {
      transactionRecords = DbRepository.getRecords()
          .where((element) =>
              Repository.formatDate(element.date)[2] == year.toString())
          .toList();
    }

    yearList = Repository.getYearList(DbRepository.getRecords());
    notifyListeners();
  }

  void deleteRecords() {
    DbRepository.deleteAllRecords();
    List<Finance> records = [];
    transactionRecords = records;
    notifyListeners();
  }
}
