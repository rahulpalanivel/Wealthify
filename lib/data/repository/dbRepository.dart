import 'package:app/data/model/Budget.dart';
import 'package:app/data/model/Finance.dart';
import 'package:app/data/model/UserData.dart';
import 'package:app/domain/repository.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class DbRepository {
  static final financeBox = Hive.box('Finance');
  static final budgetbox = Hive.box('Budget');
  static final userDataBox = Hive.box('UserData');

  static bool userExist() {
    var data = userDataBox.values.elementAtOrNull(0);
    if (data == null) {
      return false;
    } else {
      return true;
    }
  }

  static Userdata getUser() {
    Userdata userdata = userDataBox.values.elementAt(0);
    return userdata;
  }

  static void addUser(String userName, String password, int balance,
      bool deviceAuth, bool notifications, bool defaultTheme) {
    Userdata userdata = new Userdata(
        userName, balance, deviceAuth, notifications, password, defaultTheme);
    userDataBox.add(userdata);
  }

  static void addRecord(Finance finance) {
    financeBox.put(finance.desc, finance);
  }

  static void addRecords(List<List<dynamic>> data, String accountName) {
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

      String trancCategory = "";
      if (Repository.findCategory(desc) == "Others") {
        trancCategory = Repository.getCategoryFromDesc(desc);
      } else {
        trancCategory = Repository.findCategory(desc);
      }

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

  static List<Finance> getRecords() {
    List<Finance> Records = [];

    for (int i = 0; i < financeBox.length; i++) {
      var finance = Finance(
          financeBox.getAt(i).account,
          financeBox.getAt(i).user,
          financeBox.getAt(i).date,
          financeBox.getAt(i).desc,
          financeBox.getAt(i).trancType,
          financeBox.getAt(i).trancCategory,
          financeBox.getAt(i).amount);

      Records.add(finance);
    }
    Records.sort((b, a) => a.date.compareTo(b.date));
    return Records;
  }

  static Finance getRecord(String key) {
    var fin = financeBox.get(key);

    if (fin == null) {
      return Finance("", "", DateTime.now(), "", "", "", 0.00);
    } else {
      return financeBox.get(key);
    }
  }

  static void deleteRecord(String key) async {
    await financeBox.delete(key);
  }

  static void deleteAllRecords() async {
    await financeBox.clear();
  }

  static void newBudget(String category, String duration, double amount) {
    var budget = Budget("", DateTime.now(), category, duration, amount);
    budgetbox.add(budget);
  }

  static List<Budget> getBudgets() {
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

  static void deleteAllBudgets() async {
    await budgetbox.clear();
  }
}
