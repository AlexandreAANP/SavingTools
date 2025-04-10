import 'package:flutter/material.dart';

import 'package:saving_tools/appbar/ApplicationBar.dart';
import 'package:saving_tools/pages/goals/AddGoal.dart';
import 'package:saving_tools/pages/goals/GoalList.dart';
import 'package:saving_tools/sharedWidgets/Drawer.dart';
import 'package:saving_tools/sharedWidgets/NavBar.dart';

class MainGoals extends StatefulWidget {
  
  const MainGoals({Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => MainGoalsState();
}

class MainGoalsState extends State<MainGoals> {

  final GlobalKey<GoalsListState> _goalsListState = GlobalKey<GoalsListState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 192, 241, 208),
      appBar: ApplicationBar(context: context,),
      drawer: MainDrawer(context: context,),
      body: Container(
        child: Center(
          child: Column(
            children: [
              AddGoal(listKey: _goalsListState),
              Container(
                margin: EdgeInsets.only(top: 10),
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.flag,
                      color: const Color.fromARGB(255, 9, 102, 45),
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                      height: 10,
                    ),
                    Text(
                      "Goals",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 9, 102, 45),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],	
                )
              ),
              Expanded(
                flex: 2,
                child: GoalsList(key: _goalsListState)
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar()
    );
  }
}
