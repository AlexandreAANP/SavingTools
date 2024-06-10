import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:saving_tools/DTOs/GoalDTO.dart';
import 'package:saving_tools/Entities/Goal.dart';
import 'package:saving_tools/Services/GoalService.dart';
import 'package:saving_tools/pages/goals/GoalWidget.dart';

class ShortMainGoals extends StatefulWidget {
  @override
  _ShortMainGoalsState createState() => _ShortMainGoalsState();
}

class _ShortMainGoalsState extends State<ShortMainGoals> {
  final int MAX_GOAL = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:0, bottom: 2),
      padding: EdgeInsets.only(left: 5, right: 5),
      color: Colors.white,
      child: Column(
          children: [
            Container(
              child: Text(
                "Main Goals",
                style: TextStyle(
                  color: const Color.fromARGB(255, 9, 102, 45),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )
              ),
            ),
            Goals(),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child:TextButton(
                                onPressed: () {
                                  if (ModalRoute.of(context)!.settings.name != '/goals')
                                      Navigator.of(context).pushNamed("/goals");
                                  
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
                                  "View more",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Roboto"),
                                ),
                              ),
                    )
        ]
      )
    );
    
  }


  Future<List<GoalDTO>> _getGoals() async  {
    return await GoalService().getGoals(3);
  }

  FutureBuilder Goals (){
    return FutureBuilder(
      future: _getGoals(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.length == 0) {
            return Text(
              "No goals yet",
              style: TextStyle(
                color: const Color.fromARGB(255, 9, 102, 45),
                fontSize: 17,
              )
              );
          }
          List<Widget> goals = [];
          for (GoalDTO goal in snapshot.data!) {
            goals.add(GoalWidget(
              description: goal.description,
              date: goal.date,
              percent: goal.percent,
              percentText:  goal.percentText));
            
          }
          return Column(
            children: [...goals],
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  
}