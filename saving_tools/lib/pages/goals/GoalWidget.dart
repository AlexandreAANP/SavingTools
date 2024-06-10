import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:saving_tools/Entities/Goal.dart';

class GoalWidget extends StatelessWidget{
  final String description;
  final double percent;
  final String percentText;
  final String date;


  GoalWidget({required this.description, required this.percent, required this.percentText, required this.date});

  @override
  Widget build(BuildContext context) {
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
                                  description,
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