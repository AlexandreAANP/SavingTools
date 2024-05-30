import 'package:flutter/material.dart';
import 'package:saving_tools/appbar/ApplicationBar.dart';
import 'package:saving_tools/pages/main/PieChart.dart';
import 'package:saving_tools/pages/main/short_invoice_table/ShortInvoiceTable.dart';
import 'package:saving_tools/sharedWidgets/NavBar.dart';
import 'package:saving_tools/sharedWidgets/ToolBarMessages.dart';

class MainPage extends StatelessWidget {

  MainPage({Key? key}) : super(key: key){}

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 192, 241, 208),
      appBar: ApplicationBar(),
      body: Column(
        children: [
          ToolBarMessages(),
          Expanded(
              child: Container(
                  child: ListView(
                    children: [
                               PieChart(),
                              ShortInvoiceTable()])
                      )
            )
        ],
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
