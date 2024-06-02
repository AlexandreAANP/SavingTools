import 'package:flutter/material.dart';
import 'package:saving_tools/DTOs/InvoiceDTO.dart';
import 'package:sqflite/sqflite.dart';

class ViewInvoiceDetails{

  BuildContext context;
  InvoiceDTO invoice;

  ViewInvoiceDetails(this.context, this.invoice);

  void show() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Invoice details"),
          content: getInvoiceDetails(),
          actions: [
            Container(
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 0, 170, 65),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Close",
                  style: TextStyle(
                    color: Colors.white,
                  ))
              )
            )
            
          ],
        );
      });
  }

  Container getInvoiceDetails(){
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getRow("Invoice", invoice.invoice.toString()),
          getRow("Date", invoice.date.toString()),
          getRow("Amount", invoice.amount.toString() + "€"),
          getRow("Category", invoice.category.toString()),
          getRow("Type", invoice.type.toString()),
        ],
      )
    );
  }

  Container getRow(String key, String value){
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              key + ": ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
              )
            )
          ),
          Expanded(
            flex: 3,
            child:Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            value,
            style: TextStyle(
              fontSize: 18
            )
          )
        )
        ],
      ),
    );
  }
}