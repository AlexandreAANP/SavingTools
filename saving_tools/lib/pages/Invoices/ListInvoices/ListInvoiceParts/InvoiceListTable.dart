

import 'package:flutter/material.dart';
import 'package:saving_tools/DTOs/InvoiceDTO.dart';
import 'package:saving_tools/Repositories/InvoiceRepository.dart';
import 'package:saving_tools/Repositories/SearchTools/OrderBy.dart';
import 'package:saving_tools/Repositories/SearchTools/SearchLike.dart';
import 'package:saving_tools/Services/InvoiceService.dart';
import 'package:saving_tools/pages/Invoices/ListInvoices/ListInvoiceParts/InvoiceListTableSettings.dart';
import 'package:saving_tools/pages/Invoices/ListInvoices/ViewInvoiceDetails.dart';

// ignore: must_be_immutable
class InvoiceListTable extends StatefulWidget{
  GlobalKey<InvoiceListTableState> key = GlobalKey<InvoiceListTableState>();
  final GlobalKey<InvoiceListTableSettingsState> settings_state = GlobalKey<InvoiceListTableSettingsState>();
  InvoiceListTable({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => InvoiceListTableState(this.key, settingsStateKey: settings_state);

}

class InvoiceListTableState extends State<InvoiceListTable>{

  GlobalKey<InvoiceListTableState>? key;
  final GlobalKey<InvoiceListTableSettingsState> settingsStateKey;
  InvoiceListTableState(this.key,{required this.settingsStateKey});

  Searchlike? searchLike;
  OrderBy? orderBy;
  int numberOfInvoices = 0;
  int limit = 8;
  int pageIndex = 1;
  



  @override
  Widget build(BuildContext context) {
    return Container(
              color: Colors.white,
              child:ListView(
                children:[
                  Container(
                            color: Colors.white,
                            height: 300,
                            child:getInvoices()
                          ),
                  
                  Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: InvoiceListTableSettings(this.key, settings_state: this.settingsStateKey)
                          )
                  
                  ]
              )
            );

  }



  Future<List<InvoiceDTO>> getAllInvoices(Searchlike? searchLike, OrderBy? orderBy) async {

    Map<String, dynamic> response = await InvoiceService().ListAllSearch(
                                                                searchlike: searchLike,
                                                                orderBy: orderBy,
                                                                limit: this.limit,
                                                                offset: (this.pageIndex-1)*this.limit);
    if(this.numberOfInvoices != response["total"] as int){
      setState(() {
        this.numberOfInvoices = response["total"] as int;
      });
    }
    return response["invoices"] as List<InvoiceDTO>;
  }


  FutureBuilder<List<InvoiceDTO>> getInvoices(){
    return FutureBuilder(
      future: getAllInvoices(this.searchLike, this.orderBy),
      builder: (BuildContext context, AsyncSnapshot<List<InvoiceDTO>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
           return Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: CircularProgressIndicator()
            )
           );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index) {
              InvoiceDTO invoice = snapshot.data!.elementAt(index);
              return Container(
                    decoration: BoxDecoration(
                      color: invoice.amount! > 0 ? Colors.green[100] : Colors.red[100],
                      border: BorderDirectional(bottom: BorderSide(color: Colors.black, width: 1))
                    ),
                    padding: EdgeInsets.all(5),
                    
                    child: GestureDetector(
                      onLongPress: () {
                        ViewInvoiceDetails(context, invoice).show();
                      },
                      child:Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: 
                              Container(                          
                                child: Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    invoice.invoice ?? "",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18
                                    ),
                                    )
                                )
                            ),
                            Expanded(
                              flex:2,
                              child: Text(
                                invoice.date ?? "",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14
                                )
                              )
                            ),
                            Expanded(
                              flex: 1,
                              
                              child: Text(
                                
                                invoice.amount!.toString() + "€"
                              )
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                textAlign: TextAlign.center,
                                invoice.category ?? ""
                              )
                            )
                          ],
                        )
                  )
              ); 
            },
          );
        }
      },
    );
  }


  
}