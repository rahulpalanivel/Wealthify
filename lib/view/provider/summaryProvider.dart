// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:app/data/model/Finance.dart';
import 'package:app/data/repository/dbRepository.dart';
import 'package:app/domain/repository.dart';
import 'package:app/utils/collections.dart' as collections;
import 'package:flutter/material.dart';

import '../../data/model/Budget.dart';

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

  List<Finance> transactionRecords = DbRepository.getRecords();
  List<Budget> budgetRecords = DbRepository.getBudgets();
  List<String> yearList = Repository.getYearList(DbRepository.getRecords());

  Map<int, List<double>> dataByDate = {};
  Map<int, List<double>> dataByMonth = {};
  List<double> dataByCategory = [];

  void defaultValues(int month, int year) {
    List<Finance> records = [];
    List<double> values = [];

    if (month == 0 && year == 0) {
      records = DbRepository.getRecords();
      values = Repository.getAmount(records);
    } else if (month != 0) {
      records = DbRepository.getRecords()
          .where((element) =>
              Repository.formatDate(element.date)[1].substring(0, 3) ==
                  months[month] &&
              Repository.formatDate(element.date)[2] == year.toString())
          .toList();

      values = Repository.getAmount(records);
    } else {
      records = DbRepository.getRecords()
          .where((element) =>
              Repository.formatDate(element.date)[2] == year.toString())
          .toList();

      values = Repository.getAmount(records);
    }

    incoming = values[0];
    outgoing = values[1];

    FoodnDrinks = Repository.getAmountByCategory(records, "Food & Drinks");
    Shopping = Repository.getAmountByCategory(records, "Shopping");
    Groceries = Repository.getAmountByCategory(records, "Groceries");
    Medical = Repository.getAmountByCategory(records, "Medical");
    Bills = Repository.getAmountByCategory(records, "Bills");
    Travel = Repository.getAmountByCategory(records, "Travel");
    Transfer = Repository.getAmountByCategory(records, "Transfer");
    CreditCard = Repository.getAmountByCategory(records, "Credit Card");
    Education = Repository.getAmountByCategory(records, "Education");
    Home = Repository.getAmountByCategory(records, "Home");
    Salary = Repository.getAmountByCategory(records, "Salary");
    Others = Repository.getAmountByCategory(records, "Others");

    transactionRecords = records;

    yearList = Repository.getYearList(DbRepository.getRecords());

    dataByCategory = [
      Others,
      FoodnDrinks,
      Medical,
      Shopping,
      Bills,
      Groceries,
      Travel,
      Transfer,
      CreditCard,
      Education,
      Home,
      Salary,
    ];

    dataByDate = Repository.getAmountByDate(records);
    dataByMonth = Repository.getAmountByMonth(records);
  }

  void updateDefault(int month, int year) {
    defaultValues(month, year);
  }

  void updateValues(int month, int year) {
    defaultValues(month, year);
    notifyListeners();
  }

  void updateRecords() {
    transactionRecords = DbRepository.getRecords();
    yearList = Repository.getYearList(DbRepository.getRecords());
    notifyListeners();
  }

  void updateBudgets() {
    budgetRecords = DbRepository.getBudgets();
    notifyListeners();
  }

  void deleteRecords() {
    DbRepository.deleteAllRecords();
    List<Finance> records = [];
    transactionRecords = records;
    notifyListeners();
  }

  void deleteBudgets() {
    DbRepository.deleteAllBudgets();
    budgetRecords = [];
    updateBudgets();
    budgetRecords = [];
    notifyListeners();
  }
}
