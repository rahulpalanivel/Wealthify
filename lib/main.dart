import 'package:app/domain/model/Budget.dart';
import 'package:app/domain/model/Finance.dart';
import 'package:app/view/pages/start-screen.dart';
import 'package:app/view/provider/summaryProvider.dart';
import 'package:app/view/provider/transactionProvider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  Hive.registerAdapter(FinanceAdapter());
  Hive.registerAdapter(BudgetAdapter());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Box financeBox;
  late Box budgetBox;

  @override
  void initState() {
    super.initState();
    openBoxes();
  }

  Future<void> openBoxes() async {
    financeBox = await Hive.openBox('Finance');
    budgetBox = await Hive.openBox('Budget');
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => summaryProvider()),
        ChangeNotifierProvider(create: (context) => transactionProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: openBoxes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const StartScreen();
              }
            } else {
              return const Scaffold();
            }
          },
        ),
        // initialRoute: '/',
        // onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }

  @override
  void dispose() {
    financeBox.close();
    budgetBox.close();
    super.dispose();
  }
}
