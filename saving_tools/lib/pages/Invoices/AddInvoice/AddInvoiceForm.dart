
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:saving_tools/Services/InvoiceService.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/AddInvoice.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/FormParts/InvoiceAmount.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/FormParts/InvoiceCategory.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/FormParts/InvoiceDate.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/FormParts/InvoiceName.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/FormParts/InvoiceType.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/FormParts/InvoicesColors.dart';

// ignore: must_be_immutable
class AddInvoiceForm extends StatefulWidget {
  // this key it's used to get the invoicetype state
  GlobalKey<AddInvoiceState>? Scaffold_key = null;
  AddInvoiceForm({Key? key, required GlobalKey<AddInvoiceState> Scaffold_key})
      : super(key: key) {
    this.Scaffold_key = Scaffold_key;
  }

  @override
  State<AddInvoiceForm> createState() =>
      AddInvoiceFormState(Scaffold_key: Scaffold_key!);
}




class AddInvoiceFormState extends State<AddInvoiceForm> {
  GlobalKey<AddInvoiceState>? Scaffold_key;
  AddInvoiceFormState({required GlobalKey<AddInvoiceState> Scaffold_key}) {
    this.Scaffold_key = Scaffold_key;
  }

  final _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InvoiceType(scaffoldKey: Scaffold_key!,),
                Row(
                  children: [
                    Expanded(
                        child: Text("Invoice:",
                            style: TextStyle(
                              color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType()!),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )))
                  ],
                ),
                InvoiceName(Scaffold_key: Scaffold_key!, formKey: _formKey,),
                Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Text("Date:",
                            style: TextStyle(
                              color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType()!),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ))),
                    Expanded(
                        flex: 2,
                        child: Text("Amount:",
                            style: TextStyle(
                              color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType()!),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )))
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: InvoiceDate(Scaffold_key: Scaffold_key!,)
                    ),
                    Expanded(
                        flex: 2,
                        child: InvoiceAmount(Scaffold_key: Scaffold_key!,) 
                        
                        
                      )
                  ],
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 30),
                    child: Text("Category:",
                        style: TextStyle(
                          color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType()!),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ))
                    
                ),
                Container(
                    child: InvoiceCategory(Scaffold_key: Scaffold_key!,)
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                 InvoiceService().addInvoice(
                                    invoiceName: Scaffold_key!.currentState!.invoiceNameValue!,
                                    Date: Scaffold_key!.currentState!.invoiceDateValue!,
                                    Category: Scaffold_key!.currentState!.invoiceCategoryValue!,
                                    Type: Scaffold_key!.currentState!.getInvoiceType()!,
                                    Amount: Scaffold_key!.currentState!.invoiceAmountValue!);
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Added Invoice: ${Scaffold_key!.currentState?.invoiceNameValue} ${Scaffold_key!.currentState?.invoiceAmountValue} ${Scaffold_key!.currentState?.invoiceCategoryValue}'),
                                  ));
                              }
                            },
                            child: Text(
                              Scaffold_key!.currentState!.getInvoiceType() == InvoiceTypeEnum.debit
                                  ? 'Submit Debit'
                                  : 'Submit Credit',
                              style: TextStyle(
                                color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType()),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  
}
