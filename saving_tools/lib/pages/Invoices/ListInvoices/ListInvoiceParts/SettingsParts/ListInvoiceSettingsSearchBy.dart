import 'package:flutter/material.dart';
import 'package:saving_tools/pages/Invoices/ListInvoices/ListInvoiceParts/InvoiceListTableSettings.dart';

class ListInvoiceSettingsSearchBy extends StatefulWidget {
  final GlobalKey<InvoiceListTableSettingsState> settingsFilterByKey;
  ListInvoiceSettingsSearchBy({Key? key, required this.settingsFilterByKey}) : super(key: key);

  @override
  _listInvoiceSettingsSearchByState createState() => _listInvoiceSettingsSearchByState(settingsFilterByKey);
}

class _listInvoiceSettingsSearchByState extends State<ListInvoiceSettingsSearchBy> {
  final GlobalKey<InvoiceListTableSettingsState> settingsFilterByKey;
  _listInvoiceSettingsSearchByState(this.settingsFilterByKey);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: TextFormField(
            decoration: InputDecoration(
              iconColor: Colors.black,
              labelText: "Search...",
              border: OutlineInputBorder(),
              focusColor: Colors.black,
            ),
            onChanged: (value) {
              settingsFilterByKey.currentState!.searchField = value;
            },
          ),
        ),
        Expanded(
          flex: 1,
          
          child: Container(
            margin: EdgeInsets.only(left: 10),
            color: Colors.white,
            child: ElevatedButton(
                onPressed: () {
                  settingsFilterByKey.currentState!.search();
                },
                child: Icon(Icons.search, color: Colors.green[900],),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.green[100]!),
                ),
              
            ),
          
          ),
        ),
        
      ],
    )
    );
  }
}