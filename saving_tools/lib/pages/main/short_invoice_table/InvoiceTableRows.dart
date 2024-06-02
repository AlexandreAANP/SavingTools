import 'package:flutter/material.dart';
import 'package:saving_tools/DTOs/InvoiceDTO.dart';
import 'package:saving_tools/pages/Invoices/ListInvoices/ViewInvoiceDetails.dart';


class InvoiceTableRows{
  List<Container> _rows = List<Container>.empty(growable: true);
  
  BuildContext context;
  InvoiceTableRows(this.context, Map<InvoiceDTO,List<int>> selectedInvoices, {Filter filter = Filter.all}) {
    this._rows = GenerateTableRows(selectedInvoices, filter);
  }

  List<Container> get rows => _rows;


  List<Container> GenerateTableRows(Map<InvoiceDTO,List<int>> selectedInvoices, Filter filter) {
    List<Container> rows = [];
    selectedInvoices.entries.forEach((element) {
      switch (filter) {
        case Filter.debit:
          if (element.key.amount! < 0) rows.add(_InvoiceTableRow(this.context, element.key, element.value));
          break;
        case Filter.credit:
          if (element.key.amount! > 0) rows.add(_InvoiceTableRow(this.context, element.key, element.value));
          break;
        case Filter.all:
          rows.add(_InvoiceTableRow(this.context, element.key, element.value));
          break;
        case Filter.none:
          break;
      }
    });
    
    return rows;
  }
}

enum Filter { debit, credit, all, none }

class _InvoiceTableRow extends Container {
  BuildContext context;
  _InvoiceTableRow(this.context, InvoiceDTO invoiceDTO, List<int> flexs)
      : super(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            border: Border(
              bottom: BorderSide(
                color: Color.fromARGB(255, 9, 102, 45),
                width: 1,
              ),
            ),
          ),
          margin: EdgeInsets.only(left: 10, right: 10),
          child: GestureDetector(
            onLongPress: () => ViewInvoiceDetails(context, invoiceDTO).show(),
            child: Row(children: [
              Expanded(flex: flexs[0], child: _InvoiceCell(invoiceDTO.invoice.toString(), invoiceDTO.date.toString())),
              Expanded(flex: flexs[1], child: _AmountCell(invoiceDTO.amount.toString() + "€", isDebit: invoiceDTO.amount! < 0)),
            ],)
          ) 
            
        );
}
class _AmountCell extends Container {
  _AmountCell(String text, {bool? isDebit = false})
      : super(
          margin: EdgeInsets.only(left: 5),
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: isDebit! ? Colors.red : Color.fromARGB(255, 9, 102, 45),
            ),
          )
        );
}

class _InvoiceCell extends Container {
  _InvoiceCell(String text, String date)
      : super(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Color.fromARGB(255, 9, 102, 45),
                width: 1
              ),
            ),
          ),
          margin: EdgeInsets.only(right: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Text(
                    date,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  )
            ]
          )
        );
}
