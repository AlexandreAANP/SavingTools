import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/AddInvoice.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/FormParts/InvoicesColors.dart';

// ignore: must_be_immutable
class InvoiceAmount extends StatefulWidget {
  GlobalKey<AddInvoiceState>? Scaffold_key;
  InvoiceAmount({Key? key, required GlobalKey<AddInvoiceState> Scaffold_key, required })
      : super(key: key) {
    this.Scaffold_key = Scaffold_key;
  }

  @override
  _InvoiceAmountState createState() => _InvoiceAmountState(Scaffold_key: Scaffold_key!);
}


class _InvoiceAmountState extends State<InvoiceAmount> {
  GlobalKey<AddInvoiceState>? Scaffold_key;

  _InvoiceAmountState({required GlobalKey<AddInvoiceState> Scaffold_key}) {
    this.Scaffold_key = Scaffold_key;
  }

  String amount = "";
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              // color: Colors.white,
              child: TextFormField(
                
                  
                  validator: validator,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter
                        .singleLineFormatter
                  ],
                  style: TextStyle(
                    color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType()!),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )
                  )
                  );
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'invalid invoice value';
    }
    if (double.tryParse(value) == null) {
      return 'invalid invoice value';
    }
    setState(() {
      Scaffold_key!.currentState!.invoiceAmountValue = double.tryParse(value);
    });
    return null;
  }
}