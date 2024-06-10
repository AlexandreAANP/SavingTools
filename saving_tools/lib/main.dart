import 'package:flutter/material.dart';
import 'package:saving_tools/Entities/User.dart';
import 'package:saving_tools/Repositories/UserRepository.dart';
import 'package:saving_tools/Services/GoalService.dart';
import 'package:saving_tools/Services/InvoiceService.dart';
import 'package:saving_tools/Services/UserService.dart';
import 'package:saving_tools/databaseConfig.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/AddInvoice.dart';
import 'package:saving_tools/pages/Invoices/ListInvoices/ListInvoice.dart';
import 'package:saving_tools/pages/Login/Login.dart';
import 'package:saving_tools/pages/Login/Register.dart';
import 'package:saving_tools/pages/goals/MainGoals.dart';
import 'package:saving_tools/pages/main/MainPage.dart';
import 'package:saving_tools/pages/profile/MainProfile.dart';
import 'package:saving_tools/pages/statistics/MainStatistics.dart';
import 'package:sqflite/sqflite.dart';


void main() async {
  databaseConfig dbConfig = databaseConfig();
  //Singleton Service
  Database db = await dbConfig.getDatabase();
  InvoiceService.database = db;
  UserService.database = db;
  GoalService.database = db;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<AddInvoiceState> addInvoiceKey = GlobalKey<AddInvoiceState>();

  MyApp({super.key});

  
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MainPage(),
      routes: {
        '/main': (context) => MainPage(),
        '/addInvoice': (context) => AddInvoice(key: addInvoiceKey, addInvoiceKey: addInvoiceKey),
        '/listInvoice': (context) => ListInvoice(),
        "/profile": (context) => MainProfile(),
        "/login": (context) => Login(),
        "/register": (context) => Register(),
        "/goals": (context) => MainGoals(),
        "/statistics": (context) => MainStatistics(),
        //TODO ADD MORE ROUTES
      },
    );
  }
}

