import 'package:flutter/material.dart';

class ApplicationBarContent extends StatefulWidget {
  const ApplicationBarContent({Key? key}) : super(key: key);

  @override
  State<ApplicationBarContent> createState() => _ApplicationBarContentState("Saving Tools");

}


class _ApplicationBarContentState extends State<ApplicationBarContent> {
  String title = "";

  _ApplicationBarContentState(String title){
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            this.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

}