import 'package:flutter/material.dart';

class InvoiceTableHeaders {
  List<Expanded> _headers = [];
  InvoiceTableHeaders(Map<String, int> headers) {
    headers.entries.forEach((element) {
      _headers.add(Expanded(flex: element.value, child: _HeaderCell(element.key)));
    });
  }

  Center get headers => Center(child:Row(children: _headers));
}

class _HeaderCell extends Container{
  _HeaderCell(String text)
      : super(
          decoration: BoxDecoration(
            
            border: Border(
              bottom: BorderSide(
                color: Color.fromARGB(255, 9, 102, 45),
                width: 1,
              ),
              
            ),
          ),
          margin: EdgeInsets.all(10),
          child: Text(text,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0))),
        );
}