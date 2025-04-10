import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:saving_tools/Exceptions/UnauthorizedException.dart';
import 'package:saving_tools/Services/UserService.dart';

class Login extends StatefulWidget {
  

  
  
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _userService = UserService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool isLoading = false;
  String error = "";
  String errorMessage = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 170, 65),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold
              )
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0, 5)
                  )
                  ]
                ),
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.only(top:50, right: 20, left: 20, bottom: 20),
              child: Form( 
                key: _formKey,
                child: Column(
                  children: [
                    Container(child: Text(
                                      errorMessage,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20
                                      )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(
                        controller: username,
                        validator: (value) => value!.isEmpty ? "Please enter your email" : null,
                        decoration: InputDecoration(
                          hintText: "Username",
                          border: OutlineInputBorder()
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top:10, bottom: 10),
                      child: TextFormField(
                        obscureText: true,
                        controller: _password,
                        validator: (value) => value!.isEmpty ? "Please enter your password" : null,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder()
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20), 
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(Color.fromARGB(255, 0, 170, 65)),
                                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                                          EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10)),
                                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ))),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()){
                                try{

                                    await _userService.login(username: username.text, password: _password.text);
                                    Navigator.popAndPushNamed(context, '/main');
                                }
                                on UnauthorizedException catch(e){
                                    setState(() {
                                      errorMessage = e.message;
                                    });
                                }
                                  
                              }
                            },
                            child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 20),),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(Colors.green[100]!),
                                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                                          EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10)),
                                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ))),
                            onPressed: () {
                              Navigator.popAndPushNamed(context, '/register');
                            },
                            child: Text("Register", style: TextStyle(color: Colors.black, fontSize: 20)),
                          )
                        ]
                      )
                    )
                
                ],
                )

              ),
            ),
          ],
        ),
      ),
    );
  }
}