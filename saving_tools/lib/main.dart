import 'package:flutter/material.dart';
import 'package:saving_tools/Services/InvoiceService.dart';
import 'package:saving_tools/databaseConfig.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/AddInvoice.dart';
import 'package:saving_tools/pages/Invoices/ListInvoices/ListInvoice.dart';
import 'package:saving_tools/pages/main/MainPage.dart';


void main() async {
  databaseConfig dbConfig = databaseConfig();
  //Singleton Service

  InvoiceService.database = await dbConfig.getDatabase();
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
        '/listInvoice': (context) => ListInvoice(), //TODO CHANGE TO 'ListInvoice
        //TODO ADD MORE ROUTES
      },
    );
  }
}

