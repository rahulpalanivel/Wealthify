import 'package:app/domain/model/Budget.dart';
import 'package:app/domain/model/Finance.dart';
import 'package:app/domain/repository/repository.dart' as repository;
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

final financeBox = Hive.box('Finance');
final budgetbox = Hive.box('Budget');

void addRecord(Finance finance) {
  financeBox.add(finance);
}

void addRecords(List<List<dynamic>> data, String accountName) {
  for (int i = 1; i < data.length; i++) {
    String account = accountName;
    String user = "user";

    DateFormat format = DateFormat("dd/MM/yy");
    DateTime date = format.parse(data[i][0]);

    String desc = data[i][1];

    String trancType = "";

    if (data[i][4] != null) {
      trancType = "Expense";
    } else {
      trancType = "Income";
    }

    String trancCategory = repository.findCategory(desc);

    double amount = 0.0;
    if (data[i][4] != null) {
      amount = double.parse(data[i][4]) * -1;
    } else {
      amount = double.parse(data[i][5]);
    }

    var finance =
        Finance(account, user, date, desc, trancType, trancCategory, amount);
    addRecord(finance);
  }
}

List<Finance> getRecords() {
  List<Finance> Records = [];

  for (int i = 0; i < financeBox.length; i++) {
    var finance = Finance(
        financeBox.get(i).account,
        financeBox.get(i).user,
        financeBox.get(i).date,
        financeBox.get(i).desc,
        financeBox.get(i).trancType,
        financeBox.get(i).trancCategory,
        financeBox.get(i).amount);

    Records.add(finance);
  }
  Records.sort((b, a) => a.date.compareTo(b.date));
  return Records;
}

Future<void> deleteAllRecods() async {
  await financeBox.clear();
}

void newBudget(String category, String duration, double amount) {
  var budget = Budget("", DateTime.now(), category, duration, amount);
  budgetbox.add(budget);
}

List<Budget> getBudgets() {
  List<Budget> Records = [];

  for (int i = 0; i < budgetbox.length; i++) {
    var budget = Budget(
        budgetbox.get(i).user,
        budgetbox.get(i).date,
        budgetbox.get(i).trancCategory,
        budgetbox.get(i).duration,
        budgetbox.get(i).Budget_amount);

    Records.add(budget);
  }
  return Records;
}

void deleteAllBudgets() {
  budgetbox.clear();
}
