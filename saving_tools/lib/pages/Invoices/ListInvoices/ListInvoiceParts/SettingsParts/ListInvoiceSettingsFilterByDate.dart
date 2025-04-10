import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:saving_tools/pages/Invoices/ListInvoices/ListInvoiceParts/InvoiceListTableSettings.dart';

// ignore: must_be_immutable
class ListInvoiceSettingsFilterByDate extends StatefulWidget {

  GlobalKey<InvoiceListTableSettingsState>? settingskey;
  ListInvoiceSettingsFilterByDate(this.settingskey);

  @override
  _ListInvoiceSettingsFilterByDateState createState() =>
      _ListInvoiceSettingsFilterByDateState(settingskey);
}

class _ListInvoiceSettingsFilterByDateState extends State<ListInvoiceSettingsFilterByDate> {

  GlobalKey<InvoiceListTableSettingsState>? settingskey;
  _ListInvoiceSettingsFilterByDateState(this.settingskey);

  String day = "Any";
  String month = "Any";
  String year = "Any";
  List<String> days = ["Any", ...List.generate(31, (index) => (index + 1).toString())];
  List<String> months = ["Any", ...List.generate(12, (index) => (index + 1).toString())];
  List<String> years = ["Any", ...List.generate(150, (index) => (1950 + index).toString())];

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Expanded(
              flex: 1,
                child: DropdownButton<String>(
                
                value: day,
                icon: Icon(Icons.keyboard_arrow_down,),
                elevation: 16,
                
                underline: Container(
                  height: 2,
                  
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    day = value!;
                    this.settingskey!.currentState!.day = value;
                  });
                },
                items: days.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        
                        Container(
                            child: Text(value,
                                style: TextStyle(
                                  // color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType()),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )))
                      ],
                    ),
                  );
                }).toList(),
              ),
              ),
              Expanded(
              flex: 1,
                child: DropdownButton<String>(
                value: month,
                icon: Icon(Icons.keyboard_arrow_down,),
                elevation: 16,
                // style:
                //     TextStyle(color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType())),
                underline: Container(
                  height: 2,
                  // color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType()),
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    month = value!;
                    this.settingskey!.currentState!.month = value;
                  });
                },
                items: months.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        
                        Container(
                            child: Text(value,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )))
                      ],
                    ),
                  );
                }).toList(),
              ),
              ),
              Expanded(
              flex: 1,
                child: DropdownButton<String>(
                value: year,
                icon: Icon(Icons.keyboard_arrow_down,),
                elevation: 16,
                // style:
                //     TextStyle(color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType())),
                underline: Container(
                  height: 2,
                  // color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType()),
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    year = value!;
                    this.settingskey!.currentState!.year = value;
                    
                  });
                },
                items: years.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        
                        Container(
                            child: Text(value,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )))
                      ],
                    ),
                  );
                }).toList(),
              ),
              ),
          ],
        );
  }

}