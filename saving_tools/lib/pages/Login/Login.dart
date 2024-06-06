import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Login"),
            ElevatedButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, "/main");
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}