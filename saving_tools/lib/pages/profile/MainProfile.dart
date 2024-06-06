import 'package:flutter/material.dart';
import 'package:saving_tools/appbar/ApplicationBar.dart';
import 'package:saving_tools/pages/profile/MainGoals.dart';
import 'package:saving_tools/pages/profile/ProfileDetails.dart';
import 'package:saving_tools/sharedWidgets/Drawer.dart';
import 'package:saving_tools/sharedWidgets/NavBar.dart';
import 'package:saving_tools/sharedWidgets/ToolBarMessages.dart';

class MainProfile extends StatelessWidget {
  const MainProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 192, 241, 208),
      appBar: ApplicationBar(context: context,),
      drawer: MainDrawer(context: context,),
      body: Column(
        children: [
          ToolBarMessages(),
          Expanded(
              child: Container(
                  child: ListView(
                    children: [
                               Container(
                                  color: Colors.white,
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: const Color.fromARGB(255, 9, 102, 45),
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 10,
                                          height: 10,
                                        ),
                                        Text(
                                          "Profile",
                                          style: TextStyle(
                                            color: const Color.fromARGB(255, 9, 102, 45),
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        ],
                                      ),
                                    ),
                                
                                ProfileDetails(),
                                MainGoals(),
                                ]
                               ),
                               
                      )
            )
        ],
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}