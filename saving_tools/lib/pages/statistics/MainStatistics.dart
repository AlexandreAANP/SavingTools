import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:saving_tools/appbar/ApplicationBar.dart';
import 'package:saving_tools/pages/statistics/LinesChartsStatistics.dart';
import 'package:saving_tools/pages/statistics/MonthStatistics.dart';
import 'package:saving_tools/sharedWidgets/Drawer.dart';
import 'package:saving_tools/sharedWidgets/NavBar.dart';

class MainStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 192, 241, 208),
      appBar: ApplicationBar(context: context,),
      drawer: MainDrawer(context: context,),
      body: Container(
        child: Center(
          child: ListView(
            children: [
                Container(
                  color: Colors.white,
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.insights,
                          color: const Color.fromARGB(255, 9, 102, 45),
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                          height: 10,
                        ),
                        Text(
                          "Statistics",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 9, 102, 45),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        ],
                      ),
                ),
                MonthStatistics(),
                Container(
                  
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Last 3 months statistics",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 9, 102, 45),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],	
                  )
                ),
                Container(
                  color: Colors.white,
                  child: LineChartsStatistics()
                )
                
            ],
          ),
          ),
        ),
      bottomNavigationBar: NavBar()
    );
  }
}