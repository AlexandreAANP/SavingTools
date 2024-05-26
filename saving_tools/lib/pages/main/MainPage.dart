import 'package:flutter/material.dart';
import 'package:saving_tools/appbar/ApplicationBar.dart';
import 'package:saving_tools/pages/main/PieChart.dart';
import 'package:saving_tools/pages/main/short_invoice_table/ShortInvoiceTable.dart';
import 'package:saving_tools/sharedWidgets/NavBar.dart';
import 'package:saving_tools/sharedWidgets/ToolBarMessages.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 192, 241, 208),
        appBar: ApplicationBar(),
        body: Column(
          children: [
            ToolBarMessages(),
            //ShortInvoiceTable(),
            Expanded(
              child:Container(
                  child: ListView(children: [
                    PieChart(),
                    ShortInvoiceTable()
                    //Container(child:PieChart(), height: 900,) ,
                    // Container(
                    //   height: 900,
                    //   child: Column(children:[ShortInvoiceTable()]),
                    // )
                    
                  ])
                )
            ) 
            
          ],
        ),
        bottomNavigationBar: NavBar(),
      ),
    );
  }
}