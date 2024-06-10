import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:saving_tools/Services/StatisticsService.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  final int MAX_GOAL = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:7, bottom: 2),
      padding: EdgeInsets.only(left: 5, right: 5),
      color: Colors.white,
      child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                "Statistics",
                style: TextStyle(
                  color: const Color.fromARGB(255, 9, 102, 45),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex:1,
                  child: FutureBuilder(
                    future: getExpendedOfActualMonth(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        return CircularPercentIndicator(
                          radius: 100.0,
                          animation: true,
                          animationDuration: 1200,
                          lineWidth: 15.0,
                          percent: snapshot.data!["debitPercent"],
                          center: new Text(
                            "Expended ${snapshot.data!["totalExpended"]}€",
                            style:
                                new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                          ),
                          circularStrokeCap: CircularStrokeCap.butt,
                          backgroundColor: const Color.fromARGB(255, 9, 102, 45),
                          progressColor: Colors.red,
                        );
                      }
                    }
                  )
                  

                  ),
                Expanded(
                  flex:1,
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: getExpendedOfActualMonth(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.square,
                                    color: const Color.fromARGB(255, 207, 0, 0),
                                    size: 30,
                                  ),
                                  Text(
                                    "Expended: ${snapshot.data!["totalExpended"]}€",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 212, 0, 0),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                          }
                        }),
                      
                      FutureBuilder(
                        future: getExpendedOfActualMonth(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.square,
                                    color: const Color.fromARGB(255, 9, 102, 45),
                                    size: 30,
                                  ),
                                  Text(
                                    "Earned: ${snapshot.data!["totalEarned"]}€",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 9, 102, 45),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                          }
                        }
                      ),
                      
                    ],
                  )
                ),
              ],
            ),
             Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child:TextButton(
                                onPressed: () {
                                  if (ModalRoute.of(context)!.settings.name != '/statistics')
                                      Navigator.of(context).pushNamed("/statistics"); 
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

  Future<Map<String,dynamic>> getExpendedOfActualMonth() async {

    List<double> debitCreditOfMonth = await StatisticsService().getMonthReview(DateTime.now().month, DateTime.now().year);
    double debitModule = -1 * debitCreditOfMonth[0];
    double debitPercent = debitModule / (debitModule + debitCreditOfMonth[1]);
    double creditPercent = debitCreditOfMonth[1] / (debitModule + debitCreditOfMonth[1]);

    if(debitCreditOfMonth[0] == 0 || debitCreditOfMonth[1] == 0){
      return {"debitPercent": 0.5, "creditPercent": 0.5, "totalExpended": debitCreditOfMonth[0], "totalEarned": debitCreditOfMonth[1]};
    }
    return {"debitPercent": debitPercent, "creditPercent": creditPercent, "totalExpended": -debitCreditOfMonth[0], "totalEarned": debitCreditOfMonth[1]};
  }
}