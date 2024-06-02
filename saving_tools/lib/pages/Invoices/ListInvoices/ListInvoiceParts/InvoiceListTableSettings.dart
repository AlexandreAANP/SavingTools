import 'package:flutter/material.dart';
import 'package:saving_tools/Entities/Invoice.dart';
import 'package:saving_tools/Repositories/SearchTools/OrderBy.dart';
import 'package:saving_tools/Repositories/SearchTools/SearchLike.dart';
import 'package:saving_tools/pages/Invoices/ListInvoices/ListInvoiceParts/InvoiceListTable.dart';
import 'package:saving_tools/pages/Invoices/ListInvoices/ListInvoiceParts/SettingsParts/ListInvoicePagination.dart';
import 'package:saving_tools/pages/Invoices/ListInvoices/ListInvoiceParts/SettingsParts/ListInvoiceSettingsFilterByDate.dart';
import 'package:saving_tools/pages/Invoices/ListInvoices/ListInvoiceParts/SettingsParts/ListInvoiceSettingsSearchBy.dart';
import 'package:saving_tools/pages/Invoices/ListInvoices/ListInvoiceParts/SettingsParts/ListInvoiceSettingsSortyBy.dart';

// ignore: must_be_immutable
class InvoiceListTableSettings extends StatefulWidget {

  GlobalKey<InvoiceListTableState>? listTableKey;
  GlobalKey<InvoiceListTableSettingsState>? settings_state;
  InvoiceListTableSettings(this.listTableKey, {Key? settings_state}) : super(key: settings_state){
    this.settings_state = settings_state as GlobalKey<InvoiceListTableSettingsState>?;
  }

  @override
  InvoiceListTableSettingsState createState() => InvoiceListTableSettingsState(this.listTableKey,this.settings_state);
}



class InvoiceListTableSettingsState extends State<InvoiceListTableSettings> {
  
  GlobalKey<InvoiceListTableState>? listTableKey;
  GlobalKey<InvoiceListTableSettingsState>? settings_state;
  InvoiceListTableSettingsState(this.listTableKey, this.settings_state);


  OrderByEnum? orderByEnum = OrderByEnum.ASC;

  String searchField = "";
  String sortBy = "date";
  String day = "Any";
  String month = "Any";
  String year = "Any";
  List<String> daysList = List.generate(31, (index) => (index+1).toString());
  List<String> days = ["Any", ...List.generate(31, (index) => (index+1).toString())];
  List<String> monthsList = List.generate(12, (index) => (index+1).toString());
  List<String> months = ["Any", ...List.generate(12, (index) => (index+1).toString())];
  List<String> yearsList = List.generate(150, (index) => (1950+index).toString());
  List<String> years = ["Any", ...List.generate(100, (index) => (2000+index).toString())];


  void search(){

    Searchlike? searchLike;
    if(searchField != ""){
      searchLike = Searchlike({"invoice": searchField, "category": searchField}, multipleSearchCriteria: MultipleSearchCriteria.OR);
    }
    if(day != "Any" || month != "Any" || year != "Any"){
      searchLike = Searchlike({"date": "${day == "Any" ? "%" : day}/${month == "Any" ? "%" : month }/${year == "Any" ? "%" : year}"});
    }
    OrderBy? orderBy;
    orderBy = OrderBy({sortBy : orderByEnum == OrderByEnum.ASC ? OrderByEnum.ASC.name : OrderByEnum.DESC.name});
    

    listTableKey!.currentState!.setState(() {
      listTableKey!.currentState!.pageIndex = 1;
      listTableKey!.currentState!.searchLike=  searchLike; 
      listTableKey!.currentState!.orderBy = orderBy;
    });

    
  }
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        ListInvoicePagintation(this.listTableKey!),
        ListInvoiceSettingsSearchBy(settingsFilterByKey: settings_state!),

        ListInvoiceSettingsSortBy(this.settings_state),

        Container(
          // margin: EdgeInsets.only(right: 5, left: 5),
          color: Color.fromARGB(255, 240, 240, 240),
          padding: EdgeInsets.only(right: 10, left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Filter by date: ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  ),
                  
                ],
          ),
        
        Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text("Day", style: TextStyle(fontSize: 14)),
          ),
          Expanded(
            flex: 1,
            child: Text("Month", style: TextStyle(fontSize: 14),)
          ),
          Expanded(
            flex: 1,
            child: Text("Year", style: TextStyle(fontSize: 14),)
          )
        ],
      ),
      ListInvoiceSettingsFilterByDate(this.settings_state),
            ],
          ),
        ),

    
    ]);
  }

}