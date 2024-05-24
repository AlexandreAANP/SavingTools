import 'package:flutter/material.dart';

class ApplicationBar extends AppBar {
  ApplicationBar({Key? key})
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
          leading: Icon(
            Icons.menu,
            color: Colors.white,
            ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
                ),
              onPressed: () {},
            ),
          ]
        ); 
}