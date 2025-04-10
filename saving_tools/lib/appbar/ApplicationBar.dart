import 'package:flutter/material.dart';
import 'package:saving_tools/Repositories/WhoIs.dart';

class ApplicationBar extends AppBar {
  ApplicationBar({Key? key, BuildContext? context})
      : super(
          title: Center(
            child: Text(
              "Saving Tools",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              )
            ),
          backgroundColor: const Color.fromARGB(255, 0, 170, 65),
          elevation: 1,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                ),
              onPressed: () {
                            Scaffold.of(context).openDrawer();
                            },
            ),
          ),
          // leading: IconButton(
          //   icon: Icon(
          //           Icons.menu,
          //           color: Colors.white,
          //           ),
          //   onPressed: Scaffold.of(context!).openDrawer
            
          //   ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
                ),
              onPressed: () {
                WhoIs.setActualUsername("default");
                Navigator.pushNamed(context!, '/login');
              },
            ),
          ]
        ); 
}