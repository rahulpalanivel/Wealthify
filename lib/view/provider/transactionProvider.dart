// ignore_for_file: camel_case_types

import 'package:app/data/dbRepository.dart' as dbrepository;
import 'package:app/domain/model/Finance.dart';
import 'package:app/domain/repository/repository.dart' as repository;
import 'package:app/utils/collections.dart' as collections;
import 'package:flutter/material.dart';

class transactionProvider extends ChangeNotifier {
  List<Finance> transactionRecords = dbrepository.getRecords();
  List<String> months = collections.months;
  List<String> yearList = repository.getYearList(dbrepository.getRecords());

  void updateRecords(int month, int year) {
    if (month == 0 && year == 0) {
      transactionRecords = dbrepository.getRecords();
    } else if (month != 0) {
      transactionRecords = dbrepository
          .getRecords()
          .where((element) =>
              repository.formatDate(element.date)[1].substring(0, 3) ==
                  months[month] &&
              repository.formatDate(element.date)[2] == year.toString())
          .toList();
    } else {
      transactionRecords = dbrepository
          .getRecords()
          .where((element) =>
              repository.formatDate(element.date)[2] == year.toString())
          .toList();
    }
    yearList = repository.getYearList(dbrepository.getRecords());
    notifyListeners();
  }

  void deleteRecords() {
    dbrepository.deleteAllRecords();
    List<Finance> records = [];
    transactionRecords = records;
    notifyListeners();
  }
}
