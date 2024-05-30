import 'package:flutter/material.dart';
import 'package:saving_tools/appbar/ApplicationBar.dart';
import 'package:saving_tools/sharedWidgets/NavBar.dart';
import 'package:saving_tools/sharedWidgets/ToolBarMessages.dart';

class ListInvoice extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 192, 241, 208),
        appBar: ApplicationBar(),
        body: Column(
          children: [
            ToolBarMessages(key: Key("ToolBarMessages"),),
            Expanded(
              child:Container(
                  child: ListView(children: [
                    Text("List Invoice")
                  ])
                )
            ) 
            
          ],
        ),
        bottomNavigationBar: NavBar(),
      ),
    );
  }
  
}