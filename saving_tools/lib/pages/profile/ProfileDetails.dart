import 'package:flutter/material.dart';
import 'package:saving_tools/DTOs/UserDTO.dart';
import 'package:saving_tools/Entities/User.dart';
import 'package:saving_tools/Repositories/WhoIs.dart';
import 'package:saving_tools/Services/UserService.dart';

class ProfileDetails extends StatefulWidget {
  ProfileDetails({Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => ProfileDetailsState();

}

class ProfileDetailsState extends State<ProfileDetails> {
  UserDTO? actualUser;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:10, bottom: 10),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            "User Details:",
            style: TextStyle(
              color: const Color.fromARGB(255, 9, 102, 45),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 20),
            child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child:Text(
                        "Username: ",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 9, 102, 45),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )
                  )
                  ),
                  Expanded(
                    flex: 3,
                    child:FutureBuilder<UserDTO>(
                    future: getUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!.username,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 9, 102, 45),
                            fontSize: 20,
                          )
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    },
                  )
                  )
                ],
              )
          ),
        Container(
            margin: EdgeInsets.only(top: 10, left: 20, bottom: 10),
            child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child:Text(
                        "Email: ",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 9, 102, 45),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )
                  )
                  ),
                  Expanded(
                    flex: 3,
                    child:FutureBuilder<UserDTO>(
                    future: getUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!.email,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 9, 102, 45),
                            fontSize: 20,
                          )
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    },
                  )
                  ) 
                ],
              )
          ),
          Container(
          padding: EdgeInsets.only(bottom: 10),
          child: FutureBuilder<UserDTO>(
                    future: getUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if(snapshot.data!.username == "default"){
                          return SignIn();
                        }
                        return LogOut();
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    },
                  )
                  
        )
        ],
        
      ),
    );
  }

    Future<UserDTO> getUser() async {
      return await UserService().getUser(await WhoIs.getActualUsername());
    }

    Widget LogOut() {
      return TextButton(
                  onPressed: () {
                    WhoIs.setActualUsername("default");
                    if (ModalRoute.of(context)!.settings.name != '/login')
                        Navigator.of(context).popAndPushNamed("/login");
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Color.fromARGB(255, 0, 170, 65)),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ))),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto"),
                  ),
            );
    }

    Widget SignIn() {

      return TextButton(
                onPressed: () {
                  if (ModalRoute.of(context)!.settings.name != '/login')
                      Navigator.of(context).pushNamed("/login"); 
                },
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Color.fromARGB(255, 0, 170, 65)),
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ))),
                child: Text(
                  "Sign In",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Roboto"),
                ),
    );
    }
}