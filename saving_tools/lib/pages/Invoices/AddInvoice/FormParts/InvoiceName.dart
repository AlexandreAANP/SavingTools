

import 'package:flutter/material.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/AddInvoice.dart';

import 'package:saving_tools/pages/Invoices/AddInvoice/FormParts/InvoicesColors.dart';

// ignore: must_be_immutable
class InvoiceName extends StatefulWidget {
  
  GlobalKey<AddInvoiceState> Scaffold_key = GlobalKey<AddInvoiceState>();
  GlobalKey<FormState>? formKey;
  InvoiceName({Key? key, required GlobalKey<AddInvoiceState> Scaffold_key, required GlobalKey<FormState> formKey}) : super(key: key){
    this.Scaffold_key = Scaffold_key;
    this.formKey = formKey;
  }

  @override
  _InvoiceNameState createState() => _InvoiceNameState(Scaffold_key: Scaffold_key, formKey:formKey!);
}

class _InvoiceNameState extends State<InvoiceName>{
  
  GlobalKey<AddInvoiceState>?  Scaffold_key;
  GlobalKey<FormState>? formKey;
  _InvoiceNameState({required GlobalKey<AddInvoiceState> Scaffold_key, required GlobalKey<FormState> formKey}){
    this.Scaffold_key = Scaffold_key;
    this.formKey = formKey;
  }

  String formInvoice = "";
  TextEditingController controller = TextEditingController();


  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'invalid invoice value';
    }
    setState(() {
       Scaffold_key!.currentState!.invoiceNameValue = value;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Row(children: [
                    Expanded(
                        flex: 7,
                        child: Container(
                          // color: Colors.white,
                          child: Focus( 
                            onFocusChange: (hasFocus) {
                              setState(() {
                                formInvoice = controller.text;

                              });
                            },
                              child: TextFormField(
                              controller: controller,
                              validator:validator,
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.invoiceType!),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              )
                            ),
                          ),
                        ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          // color: Colors.white,
                          child: IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.invoiceType!),
                              size: 30,
                            ),
                            onPressed: () {
                              setState(() {
                                controller.clear();
                              });
                            },
                          ),
                        ))
                  ]),
                );
  }

}