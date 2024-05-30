import 'package:flutter/material.dart';
import 'package:saving_tools/appbar/ApplicationBar.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/AddInvoiceForm.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/FormParts/InvoiceType.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/FormParts/InvoicesColors.dart';
import 'package:saving_tools/sharedWidgets/NavBar.dart';
import 'package:saving_tools/sharedWidgets/ToolBarMessages.dart';

class AddInvoice extends StatefulWidget {
  GlobalKey<AddInvoiceState> addInvoiceKey = GlobalKey<AddInvoiceState>();
  AddInvoice({Key? key, required GlobalKey<AddInvoiceState> addInvoiceKey})
      : super(key: key) {
    this.addInvoiceKey = addInvoiceKey;
  }

  @override
  State<StatefulWidget> createState() =>
      AddInvoiceState(addInvoiceKey: this.addInvoiceKey);
}

class AddInvoiceState extends State<AddInvoice> {
  GlobalKey<AddInvoiceState> addInvoiceKey = GlobalKey<AddInvoiceState>();
  GlobalKey<AddInvoiceFormState> addInvoiceFormKey = GlobalKey<AddInvoiceFormState>();
  AddInvoiceState({Key? key, required GlobalKey<AddInvoiceState> addInvoiceKey})
      : super() {
    this.addInvoiceKey = addInvoiceKey;
  }

  String? invoiceNameValue;
  DateTime? invoiceDateValue;
  double? invoiceAmountValue;
  String? invoiceCategoryValue;
  
  InvoiceTypeEnum? invoiceType = InvoiceTypeEnum.debit; //this is the default value

  InvoiceTypeEnum? getInvoiceType() => invoiceType;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: InvoiceColors.GetLightColor(invoiceType),
      appBar: ApplicationBar(),
      body: Column(
        children: [
          ToolBarMessages(),
          Expanded(
              child: Container(
                  child: Column(
                    children: [
                            Container(
                              // flex: 1,
                              child: Center(
                                child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_to_photos_outlined,
                                    color: InvoiceColors.GetDarkColor(invoiceType),
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                    height: 10,
                                  ),
                                  Text(
                                    "Add new Invoice",
                                    style: TextStyle(
                                      color: InvoiceColors.GetDarkColor(invoiceType),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                     ),
                                   ),
                                  ],
                                ),
                              )
                              )
                            ),
                            AddInvoiceForm(key: addInvoiceFormKey, Scaffold_key: addInvoiceKey),
          ])))
        ],
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
