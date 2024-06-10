import 'package:flutter/material.dart';
import 'package:saving_tools/DTOs/GoalDTO.dart';
import 'package:saving_tools/Services/GoalService.dart';
import 'package:saving_tools/pages/goals/GoalWidget.dart';

class GoalsList extends StatefulWidget {
  const GoalsList({Key? key}) : super(key: key);

  @override
  GoalsListState createState() => GoalsListState();
}

class GoalsListState extends State<GoalsList> {
  final int MAX_GOAL = 5;
  final GlobalKey<GoalsListState> _goalList = GlobalKey<GoalsListState>();
  @override
  Widget build(BuildContext context) {
    return 
      Container(
        key: _goalList,
        color: Colors.white,
        child: getGoals(),
      );
    
  }


  Widget getGoals () {
    return FutureBuilder(
      future: GoalService().getGoals(5),
      builder: (BuildContext context, AsyncSnapshot<List<GoalDTO>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.length == 0) {
            return Center(
              child: Text(
                "Any Goal created yet",
                style: TextStyle(
                  color: const Color.fromARGB(255, 9, 102, 45),
                  fontSize: 20,
                )
                ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GoalWidget(
                    description: snapshot.data![index].description,
                    percent: snapshot.data![index].percent,
                    percentText: snapshot.data![index].percentText,
                    date: snapshot.data![index].date,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                          child: Text(
                              "Value of goal: "+ snapshot.data![index].amount.toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 9, 102, 45),
                                fontSize: 17,
                              )
                            ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 237, 237, 237)),
                          ),
                          onPressed: () {
                            GoalService().deleteGoal(snapshot.data![index].id);
                            setState(() {
                              
                            });
                          },
                          child: Icon(
                            Icons.delete,
                            color: const Color.fromARGB(255, 255, 0, 0),
                            ),
                        
                        ),
                      )
                    ],
                  ),
                  // Divider(
                  //   color: Colors.black,
                  // )
                ],
              );
            },
          );
        } 
        else if(snapshot.hasError){
          return Center(
            child: Text("Error"),
          );
        }        
        else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }        
      },
    );
  }
}