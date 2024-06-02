
import 'package:flutter/material.dart';


class InvoiceListTableHeader extends StatelessWidget {
  InvoiceListTableHeader({Key? key}) : super(key: key);

  // final List<Invoice> invoiceList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:30),
      color: Colors.white,
      padding: EdgeInsets.only(top:10, bottom: 10, left: 5, right: 5),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Invoice Name',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Date',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Amount',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Category',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}