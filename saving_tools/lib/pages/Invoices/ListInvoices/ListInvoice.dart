import 'package:flutter/material.dart';
import 'package:saving_tools/appbar/ApplicationBar.dart';
import 'package:saving_tools/pages/Invoices/ListInvoices/ListInvoiceParts/InvoiceListTable.dart';
import 'package:saving_tools/pages/Invoices/ListInvoices/ListInvoiceParts/InvoiceListTableHeader.dart';
import 'package:saving_tools/pages/Invoices/ListInvoices/ListInvoiceParts/InvoiceListTableSettings.dart';
import 'package:saving_tools/sharedWidgets/NavBar.dart';
import 'package:saving_tools/sharedWidgets/ToolBarMessages.dart';

class ListInvoice extends StatelessWidget{
  final invoiceListTableKey = GlobalKey<InvoiceListTableState>();
  final invoiceListTableSettingsKey = GlobalKey<InvoiceListTableSettingsState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 192, 241, 208),
        appBar: ApplicationBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ToolBarMessages(key: Key("ToolBarMessages"),),
            Container(
              color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.format_list_bulleted,
                      color: const Color.fromARGB(255, 9, 102, 45),
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                      height: 10,
                    ),
                    Text(
                      "Invoice List",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 9, 102, 45),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ],
                  ),
                ),
            InvoiceListTableHeader(),
            Expanded(
              child: InvoiceListTable(key: invoiceListTableKey)
            ),

            
          ],
        ),
        bottomNavigationBar: NavBar(),
      );
  }
  
}