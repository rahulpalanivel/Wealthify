// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:app/data/repository/dbRepository.dart' as dbrepository;
import 'package:app/domain/model/Finance.dart';
import 'package:app/domain/repository/repository.dart' as repository;
import 'package:app/utils/collections.dart' as collections;
import 'package:flutter/material.dart';

import '../../domain/model/Budget.dart';

class summaryProvider extends ChangeNotifier {
  double incoming = 0;
  double outgoing = 0;
  double FoodnDrinks = 0;
  double Shopping = 0;
  double Groceries = 0;
  double Medical = 0;
  double Bills = 0;
  double Travel = 0;
  double Transfer = 0;
  double CreditCard = 0;
  double Education = 0;
  double Home = 0;
  double Salary = 0;
  double Others = 0;

  List<String> months = collections.months;

  List<Finance> transactionRecords = dbrepository.getRecords();
  List<Budget> budgetRecords = dbrepository.getBudgets();

  void defaultValues(int month, int year) {
    List<Finance> records = [];
    List<double> values = [];

    if (month == 0 && year == 0) {
      records = dbrepository.getRecords();
      values = repository.getAmount(records);
    } else if (month != 0) {
      records = dbrepository
          .getRecords()
          .where((element) =>
              repository.formatDate(element.date)[1].substring(0, 3) ==
                  months[month] &&
              repository.formatDate(element.date)[2] == year.toString())
          .toList();

      values = repository.getAmount(records);
    } else {
      records = dbrepository
          .getRecords()
          .where((element) =>
              repository.formatDate(element.date)[2] == year.toString())
          .toList();

      values = repository.getAmount(records);
    }

    incoming = values[0];
    outgoing = values[1];

    FoodnDrinks = repository.getAmountByCategory(records, "Food & Drinks");
    Shopping = repository.getAmountByCategory(records, "Shopping");
    Groceries = repository.getAmountByCategory(records, "Groceries");
    Medical = repository.getAmountByCategory(records, "Medical");
    Bills = repository.getAmountByCategory(records, "Bills");
    Travel = repository.getAmountByCategory(records, "Travel");
    Transfer = repository.getAmountByCategory(records, "Transfer");
    CreditCard = repository.getAmountByCategory(records, "Credit Card");
    Education = repository.getAmountByCategory(records, "Education");
    Home = repository.getAmountByCategory(records, "Home");
    Salary = repository.getAmountByCategory(records, "Salary");
    Others = repository.getAmountByCategory(records, "Others");

    transactionRecords = records;
  }

  void updateValues(int month, int year) {
    defaultValues(month, year);
    notifyListeners();
  }

  void updateRecords() {
    transactionRecords = dbrepository.getRecords();
    notifyListeners();
  }

  void updateBudgets() {
    budgetRecords = dbrepository.getBudgets();
    notifyListeners();
  }
}