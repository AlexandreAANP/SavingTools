import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:saving_tools/Entities/Goal.dart';
import 'package:saving_tools/Services/GoalService.dart';

class MainGoals extends StatefulWidget {
  @override
  _MainGoalsState createState() => _MainGoalsState();
}

class _MainGoalsState extends State<MainGoals> {
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
            Goals()
         
        ]
      )
    );
    
  }


  Future<List<Goal>> _getGoals() async  {
    return await GoalService().getGoals(7);
  }

  FutureBuilder Goals (){
    return FutureBuilder(
      future: _getGoals(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Widget> goals = [];
          for (Goal goal in snapshot.data!) {
            String percentValue = (goal.percent! * 100).toStringAsFixed(0) + "%";
            goals.add(CreateWidgetGoal(goal.description!, goal.date!, goal.percent!, percentValue));
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

  Widget CreateWidgetGoal(String Description, String date, double percent, String percentText) {
    return Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child:Text(
                                  Description,
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 9, 102, 45),
                                    fontSize: 17,
                                    
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  )
                              ),
                              Expanded(
                                child:Text(
                                    "Expired at:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 9, 102, 45),
                                      fontSize: 17,
                                  )
                                )
                              )
                              
                            ]
                          ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: ProgressBar(percent, percentText)
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(date,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 9, 102, 45),
                            fontSize: 17,
                          )
                        ),
                      )
                    ]
                  )
                ],
              ),
            );
  }


  Widget ProgressBar(double percentage, String percentText) {
    return new LinearPercentIndicator(
                
                animation: true,
                lineHeight: 20.0,
                animationDuration: 2000,
                percent: percentage,
                center: Text(percentText, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                barRadius: Radius.circular(12),
                progressColor: const Color.fromARGB(255, 9, 102, 45),
              );
  }
}