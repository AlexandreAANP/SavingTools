import 'package:flutter/material.dart';
import 'package:saving_tools/DTOs/InvoiceDTO.dart';
import 'package:saving_tools/Services/InvoiceService.dart';
import 'package:saving_tools/pages/main/short_invoice_table/InvoiceTableRows.dart';
import 'package:saving_tools/pages/main/short_invoice_table/InvoiceTablesHeaders.dart';

class ShortInvoiceTable extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShortInvoiceTableState();
}

class _ShortInvoiceTableState extends State<ShortInvoiceTable> {

  Future<Map<InvoiceDTO, List<int>>> allInvoices() async {
    List<InvoiceDTO> invoices = [];
    if(this.showDebits && this.showCredits)
      invoices = await InvoiceService().ListInvoicesShortTableAllTypes();
    else if(this.showDebits)
      invoices = await InvoiceService().ListDebitInvoicesShortTableAllTypes();
    else if(this.showCredits)
      invoices = await InvoiceService().ListCreditInvoicesShortTableAllTypes();

    Map<InvoiceDTO, List<int>> selectedInvoices = {};
    invoices.forEach((element) {
      selectedInvoices[element] = [2, 1];
    });
    return selectedInvoices;
  }


  Map<String, int> headers = {"Invoice": 2, "Amount": 1};

  bool showDebits = true;
  bool showCredits = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 500,
        margin: EdgeInsets.only(bottom: 20),
        color: Color.fromARGB(255, 192, 241, 208),
        child: Column(
          children: [
            Expanded(flex: 1, child: GenerateTableSettings()),
            Expanded(flex: 3, child: GenerateTable()),
            Expanded(flex: 1, child: GenerateButtonInvoiceTable())
          ],
        ));
  }

  

  Container GenerateTableSettings() {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 5),
        padding: EdgeInsets.only(left: 10, right: 10, top: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 0, 170, 65),
        ),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Last Invoices",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Roboto",
              ),
            ),
            Text(
              "Settings",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: "Roboto",
              ),
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                
                children: [
                  Text(
                    "Show Debits",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: "Roboto",
                    ),
                  ),
                  Switch(
                    activeColor: Colors.white,
                    activeTrackColor: const Color.fromARGB(255, 1, 145, 49),
                    inactiveTrackColor: const Color.fromARGB(255, 30, 86, 49),
                    inactiveThumbColor: Colors.white,
                    value: showDebits,
                    onChanged: (e) => setState(() {
                      this.showDebits = e;
                    }),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "Show Credits",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: "Roboto",
                    ),
                  ),
                  Switch(
                    activeColor: Colors.white,
                    activeTrackColor: const Color.fromARGB(255, 1, 145, 49),
                    inactiveTrackColor: const Color.fromARGB(255, 30, 86, 49),
                    inactiveThumbColor: Colors.white,
                    value: showCredits,
                    onChanged: (e) => setState(() {
                      this.showCredits = e;
                    }),
                  )
                ],
              ),
            ],
          ),
        ]));
  }

  FutureBuilder<Map<InvoiceDTO, List<int>>> GenerateTable(){
    return FutureBuilder<Map<InvoiceDTO, List<int>>>(
        future: allInvoices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                color: Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InvoiceTableHeaders(headers).headers,
                    ...InvoiceTableRows(context, snapshot.data!, filter: Filter.all).rows,
                  ],
                ));
          }
        }
        );
  } 

  


  Container GenerateButtonInvoiceTable() {
    return Container(
        child: Center(
            child: TextButton(
      onPressed: () {
        
        if (ModalRoute.of(context)!.settings.name != '/listInvoice')
            Navigator.of(context).pushNamed("/listInvoice");
        
      },
      style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all<Color>(Color.fromARGB(255, 0, 170, 65)),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ))),
      child: Text(
        "View more",
        style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto"),
      ),
    ))
    
    );
  }

}