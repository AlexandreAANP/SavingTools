import 'package:flutter/material.dart';
import 'package:saving_tools/Entities/Invoice.dart';
import 'package:saving_tools/pages/Invoices/ListInvoices/ListInvoiceParts/InvoiceListTableSettings.dart';

class ListInvoiceSettingsSortBy extends StatefulWidget {
  GlobalKey<InvoiceListTableSettingsState>? InvoiceSettingsStatekey;
  ListInvoiceSettingsSortBy(this.InvoiceSettingsStatekey, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => ListInvoiceSettingsSortByState(this.InvoiceSettingsStatekey);
}

enum OrderByEnum { 
  ASC,
  DESC 
}
class ListInvoiceSettingsSortByState extends State<ListInvoiceSettingsSortBy>{

  GlobalKey<InvoiceListTableSettingsState>? settingsStateKey;
  ListInvoiceSettingsSortByState(this.settingsStateKey);
  String dropdownValue = "date";
  List<String> fields = Invoice.getFields();
  OrderByEnum? _orderByEnum = OrderByEnum.ASC;
  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Text("Sort by: ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
            ),
            Expanded(
              flex: 2,
                child: DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.keyboard_arrow_down,),
                elevation: 16,
                underline: Container(
                  height: 2,
                  // color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType()),
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                    this.settingsStateKey!.currentState!.sortBy = value;
                  });
                },
                items: fields.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: Text(value,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  // color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType()),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )))
                      ],
                    ),
                  );
                }).toList(),
              ),
              ),

              Expanded(
                        flex: 2,
                        child: ListTile(
                          contentPadding: EdgeInsets.only(left: 0, right: 0),
                          title: const Text(
                            'ASC',
                            style: TextStyle(
                              // color: _debitColor,
                              fontSize: 13,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: Radio<OrderByEnum>(
                            value: OrderByEnum.ASC,
                            fillColor: WidgetStateProperty.all(const Color.fromARGB(255, 0, 75, 3)),
                            overlayColor: WidgetStateProperty.all(const Color.fromARGB(255, 0, 75, 3)),
                            groupValue: _orderByEnum,
                            onChanged: (OrderByEnum? value) {
                              setState(() {
                                _orderByEnum = value;
                                this.settingsStateKey!.currentState!.orderByEnum = value;
                                  
                                });
                              }
                            )
                          ),
                    ),
                    Expanded(
                              flex: 2,
                              child: ListTile(
                                contentPadding: EdgeInsets.only(left: 0, right: 0),
                                title: const Text(
                                  'DESC',
                                  style: TextStyle(
                                    // color: _creditColor,
                                    fontSize: 13,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                leading: Radio<OrderByEnum>(
                                  fillColor: WidgetStateProperty.all(const Color.fromARGB(255, 0, 75, 3)),
                                  overlayColor: WidgetStateProperty.all(const Color.fromARGB(255, 0, 75, 3)),
                                  value: OrderByEnum.DESC,
                                  groupValue: _orderByEnum,
                                  onChanged: (OrderByEnum? value) {
                                    setState(() {
                                      _orderByEnum = value;
                                      });
                                    })
                                  
                                )
                    )
          ],
      
    );
  }
}