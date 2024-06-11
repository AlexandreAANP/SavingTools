import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:saving_tools/Services/StatisticsService.dart';

class MonthStatistics extends StatefulWidget {
  MonthStatistics({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MonthStatisticsState();
}

class MonthStatisticsState extends State<MonthStatistics>{

List<String> months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
String? actualMonth;
String? totalExpended = "0";
String? totalEarned = "0";

  @override
  void initState() {
    actualMonth = months[DateTime.now().month - 1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return Column(
    children: [
      Container(
        color: Colors.white,
        child: Divider(
        color: const Color.fromARGB(255, 9, 102, 45),
        height: 20,
        thickness: 1,
        indent: 0,
        endIndent: 0,
      ) 
      ),
      Container(
                  color: Colors.white,
                  child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text("Month review",
                          textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 9, 102, 45),
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            )
                      )
                  ],) 
                  ),
                Container(
                  color: Colors.white,
                  child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButton<String>(
                                value: actualMonth,
                                icon: Icon(Icons.keyboard_arrow_down,
                                    color: Colors.black),
                                elevation: 16,
                                
                                style:
                                    TextStyle(
                                      color: const Color.fromARGB(255, 9, 102, 45),
                                      fontSize: 20,
                                      
                                      ),
                                underline: Container(
                                  height: 2,
                                  color:  Color.fromARGB(255, 9, 102, 45),
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    actualMonth = value!;
                                    
                                  });
                                },
                                items: months
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value.toString(),
                                      textAlign: TextAlign.center, style: TextStyle(
                                      color: const Color.fromARGB(255, 9, 102, 45),
                                      fontSize: 20,
                                    )
                                    )
                                  );
                                }).toList(),
                              )
                          ],
                  ) 
                  ),
                Container(
                  padding: EdgeInsets.only(top: 40),
                  color: Colors.white,
                  child: Row(
                        children: [
                          Expanded(
                            flex:1,
                            child: FutureBuilder(
                                future: getExpended(),
                                builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                                  if (snapshot.hasData) {
                                    return CircularPercentIndicator(
                                                radius: 100.0,
                                                animation: true,
                                                animationDuration: 1200,
                                                lineWidth: 15.0,
                                                percent: snapshot.data!["debitPercent"],
                                                center: new Text(
                                                  "Expended ${snapshot.data!["totalExpended"]}€",
                                                  style:
                                                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                ),
                                                circularStrokeCap: CircularStrokeCap.butt,
                                                backgroundColor: const Color.fromARGB(255, 9, 102, 45),
                                                progressColor: Colors.red,
                                              );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                            ) 
                            
                            ),
                          Expanded(
                            flex:1,
                            child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.square,
                                            color: const Color.fromARGB(255, 207, 0, 0),
                                            size: 30,
                                          ),
                                          FutureBuilder(future: getExpended(),
                                                  builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(
                                                        "Expended: ${formatNumber(snapshot.data!["totalExpended"])}€",
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          color: const Color.fromARGB(255, 212, 0, 0),
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      );
                                                    } else {
                                                      return CircularProgressIndicator();
                                                    }
                                                  }, 
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.square,
                                            color: const Color.fromARGB(255, 9, 102, 45),
                                            size: 30,
                                          ),
                                          FutureBuilder(
                                            future: getExpended(),
                                            builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(
                                                        "Earned: ${formatNumber(snapshot.data!["totalEarned"])}€",
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          color: const Color.fromARGB(255, 212, 0, 0),
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      );
                                                    } else {
                                                      return CircularProgressIndicator();
                                                    }
                                                  },)
                                        ],
                                      )
                                    ],
                                  )
                                ),
                              ],
                            )
                          ),
            Container(
              color: Colors.white,
              child: Divider(
              color: const Color.fromARGB(255, 9, 102, 45),
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ) 
      )
    ],
   );
  }

  String formatNumber(double number){

    if (number < 1000){
      return number.toString();
    }
    if (number < 1000000){
      return (number/1000).toStringAsFixed(2) + "K";
    }
    return (number/1000000).toStringAsFixed(2) + "M";
  }

  Future<Map<String,dynamic>> getExpended() async {
    int indexMonth = months.indexOf(actualMonth!) + 1;
    List<double> debitCreditOfMonth = await StatisticsService().getMonthReview(indexMonth, DateTime.now().year);
    double debitModule = -1 * debitCreditOfMonth[0];
    double debitPercent = debitModule / (debitModule + debitCreditOfMonth[1]);
    double creditPercent = debitCreditOfMonth[1] / (debitModule + debitCreditOfMonth[1]);

    if(debitCreditOfMonth[0] == 0 || debitCreditOfMonth[1] == 0){
      return {"debitPercent": 0.5, "creditPercent": 0.5, "totalExpended": debitCreditOfMonth[0], "totalEarned": debitCreditOfMonth[1]};
    }
    return {"debitPercent": debitPercent, "creditPercent": creditPercent, "totalExpended": -debitCreditOfMonth[0], "totalEarned": debitCreditOfMonth[1]};
  }
  
}