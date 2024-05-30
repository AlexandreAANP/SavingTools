import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/AddInvoice.dart';

enum InvoiceTypeEnum { 
  debit,
  credit 
}

// ignore: must_be_immutable
class InvoiceType extends StatefulWidget {
  GlobalKey<AddInvoiceState> Scaffold_key = GlobalKey<AddInvoiceState>();

  InvoiceType({Key? key, required GlobalKey<AddInvoiceState> scaffoldKey})
      : super(key: key){
        this.Scaffold_key = scaffoldKey;
      }

  @override
  _InvoiceTypeState createState() =>
      _InvoiceTypeState(scaffoldKey: Scaffold_key);
}

class _InvoiceTypeState extends State<InvoiceType>{

  GlobalKey<AddInvoiceState>? Scaffold_key = null;

  static const Color _creditColor = const Color.fromARGB(255, 9, 102, 45);
  static const Color _debitColor = const Color.fromARGB(255, 102, 9, 9);

  InvoiceTypeEnum? _invoiceType = InvoiceTypeEnum.debit;

  _InvoiceTypeState({required GlobalKey<AddInvoiceState> scaffoldKey}) {
    this.Scaffold_key = scaffoldKey;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    margin: EdgeInsets.only(bottom: 30, top: 30),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: const Text("Type:",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 15, 6),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ))),
                        Expanded(
                            flex: 3,
                            child: ListTile(
                              title: const Text(
                                'Debit',
                                style: TextStyle(
                                  color: _debitColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              leading: Radio<InvoiceTypeEnum>(
                                value: InvoiceTypeEnum.debit,
                                groupValue: _invoiceType,
                                onChanged: (InvoiceTypeEnum? value) {
                                  setState(() {
                                    _invoiceType = value;

                                    Scaffold_key!.currentState!
                                        .setState(() {
                                      Scaffold_key!.currentState!
                                          .invoiceType = value;
                                      
                                    });
                                  });
                                },
                              ),
                            )),
                        Expanded(
                            flex: 3,
                            child: ListTile(
                              title: const Text(
                                'Credit',
                                style: TextStyle(
                                  color: _creditColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              leading: Radio<InvoiceTypeEnum>(
                                value: InvoiceTypeEnum.credit,
                                groupValue: _invoiceType,
                                onChanged: (InvoiceTypeEnum? value) {
                                  setState(() {
                                    _invoiceType = value;
                                    Scaffold_key!.currentState!
                                        .setState(() {
                                      Scaffold_key!.currentState!
                                          .invoiceType = value;

                                    });
                                  });
                                },
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            );
  }
  
}