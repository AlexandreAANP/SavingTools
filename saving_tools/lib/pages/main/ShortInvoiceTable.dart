import 'package:flutter/material.dart';

class ShortInvoiceTable extends StatelessWidget {

  List<String> selectedInvoices = ["321","123","321","123","321","123","321","123"];

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: ScrollController(),
      child: Expanded(
        flex: 2,
        child:Container(
          child: DataTable(
              columns: [
                DataColumn(label: Text('Invoice')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Amount')),
              ],
              rows: selectedInvoices
                  .map((invoice) => DataRow(
                          cells: [
                            DataCell(Text(invoice)),
                            DataCell(Text(invoice)),
                            DataCell(Text(invoice)),
                          ],
                        ))
                  .toList(),
            ),
        )
      )
      
    );
  }
}