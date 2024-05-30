

import 'package:flutter/material.dart';
import 'package:saving_tools/Repositories/CategoryRepository.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/AddInvoice.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/FormParts/InvoicesColors.dart';

// ignore: must_be_immutable
class InvoiceCategory extends StatefulWidget {
  GlobalKey<AddInvoiceState>? Scaffold_key;
  InvoiceCategory({Key? key, required GlobalKey<AddInvoiceState> Scaffold_key})
      : super(key: key) {
    this.Scaffold_key = Scaffold_key;
  }

  @override
  _InvoiceCategoryState createState() => _InvoiceCategoryState(Scaffold_key: Scaffold_key!);
}

class _InvoiceCategoryState extends State<InvoiceCategory> {
  GlobalKey<AddInvoiceState>? Scaffold_key;
  final _categoryRepository = CategoryRepository();
  _InvoiceCategoryState({required GlobalKey<AddInvoiceState> Scaffold_key}) {
    this.Scaffold_key = Scaffold_key;
  }

  String category = "";
  String? dropdownValue = "Select category";
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {


    return Row(
          children: [
            Expanded(
                flex: 4,
                child:  getDropDown()
                
            ),
            Expanded(
              flex:2,
              child: IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType()),
                  size: 30,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Add new category"),
                          content: TextField(
                            controller: controller,
                            onChanged: (value) {
                              setState(() {
                                category = value;
                              });
                            },
                          ),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  setState(()  {
                                    _categoryRepository.addCategory(category);
                                    
                                    controller.clear();
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: Text("Add"))
                          ],
                        );
                      });
                },
              )
            )
          ],
        );
  }

  Future<List<DropdownMenuItem<String>>> getCategories() async {
    List<DropdownMenuItem<String>> items = [];
    List<String> categories = await _categoryRepository.getCategories();
    for (String category in categories) {
      items.add(DropdownMenuItem<String>(
        value: category,
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.category,
                  color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType()),
                )),
            Container(
                child: Text(category,
                    style: TextStyle(
                      color:
                          InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType()),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )))
          ],
        ),
      ));
    }
    items.add(DropdownMenuItem<String>(
      value: "Select category",
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.category,
                color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType()),
              )),
          Container(
              child: Text("Select category",
                  style: TextStyle(
                    color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType()),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )))
        ],
      ),
    )
    );
    return items;
  }


  FutureBuilder<List<DropdownMenuItem<String>>> getDropDown() {
    return FutureBuilder(
      future: getCategories(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.keyboard_arrow_down,
                color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType())),
            elevation: 16,
            style:
                TextStyle(color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType())),
            underline: Container(
              height: 2,
              color: InvoiceColors.GetDarkColor(Scaffold_key!.currentState!.getInvoiceType()),
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
                Scaffold_key!.currentState!.invoiceCategoryValue = value;
              });
            },
            items: snapshot.data,
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }


}