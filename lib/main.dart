import 'package:app/data/model/Budget.dart';
import 'package:app/data/model/Finance.dart';
import 'package:app/data/model/UserData.dart';
import 'package:app/view/pages/start-screen.dart';
import 'package:app/view/provider/summaryProvider.dart';
import 'package:app/view/provider/transactionProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:provider/provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);

  Hive.registerAdapter(FinanceAdapter());
  Hive.registerAdapter(BudgetAdapter());
  Hive.registerAdapter(UserdataAdapter());

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

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
  late Box userDataBox;

  @override
  void initState() {
    super.initState();
    openBoxes();
    splashScreen();
  }

  Future<void> openBoxes() async {
    financeBox = await Hive.openBox('Finance');
    budgetBox = await Hive.openBox('Budget');
    userDataBox = await Hive.openBox('UserData');
  }

  void splashScreen() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
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
        theme: ThemeData(
          textTheme: GoogleFonts.libreCaslonTextTextTheme(),
        ),
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
