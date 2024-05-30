import 'package:flutter/material.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/AddInvoice.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/FormParts/DatePicker.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/FormParts/InvoicesColors.dart';

// ignore: must_be_immutable
class InvoiceDate extends StatefulWidget {
  GlobalKey<AddInvoiceState>? Scaffold_key;

  InvoiceDate({Key? key, required GlobalKey<AddInvoiceState> Scaffold_key})
      : super(key: key) {
    this.Scaffold_key = Scaffold_key;
  }

  @override
  _InvoiceDateState createState() => _InvoiceDateState(Scaffold_key: Scaffold_key!);
}

class _InvoiceDateState extends State<InvoiceDate> {
  GlobalKey<AddInvoiceState>? Scaffold_key;

  _InvoiceDateState({required GlobalKey<AddInvoiceState> Scaffold_key}) {
    this.Scaffold_key = Scaffold_key;
  }

  String date = "";

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Container(
              // color: Colors.white,
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: controller,
                validator: validator,
                style: TextStyle(
                  color: InvoiceColors.GetDarkColor(
                      Scaffold_key!.currentState!.getInvoiceType()),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        Expanded(
            flex: 1,
            child: Container(
              // color: Colors.white,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: DatePicker(
                onDateSelected: (date) {
                  setState(() {
                    print(
                        "Date selected: ${date.day}/${date.month}/${date.year}");
                    controller.text = "${date.day}/${date.month}/${date.year}";
                  });
                },
              ),
            ))
      ],
    );
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Invalid date';
    }
    List<String> dateParts = value.split("/");
    if (dateParts.length != 3) {
      return 'Invalid date';
    }

    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    if (day < 1 || day > 31) {
      return 'Invalid date';
    } else if (day < 10) {
      dateParts[0] = "0$day";
    }
    if (month < 1 || month > 12) {
      return 'Invalid date';
    } else if (month < 10) {
      dateParts[1] = "0$month";
    }
    if (year < 2000 || year > 2100) {
      return 'Invalid date';
    }
    setState(() {
      Scaffold_key!.currentState!.invoiceDateValue = DateTime.utc(year, month, day);
    });
    return null;
  }
}
