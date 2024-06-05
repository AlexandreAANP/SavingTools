import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:pie_chart/pie_chart.dart' as pie_chart;
import 'package:saving_tools/Services/InvoiceService.dart';
class PieChart extends StatefulWidget {
  const PieChart({Key? key}) : super(key: key);

  @override
  State<PieChart> createState() => _PieChartState();
}


class _PieChartState extends State<PieChart> {

  
  @override
  Widget build(BuildContext context) {
    
    return Container(
              alignment: Alignment.center,
              transformAlignment: Alignment.center,
              color: Color.fromARGB(255, 255, 255, 255),
              //width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Text(
                      "Expenses by category:",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      )
                    )
                  ),
                  buildPieChart(),
                ],
              ),
            );
  }


  Future<Map<String,double>> getData() async {
    return await InvoiceService().getInvoicesPercentage();
  }


  FutureBuilder<Map<String,double>> buildPieChart() {
    return FutureBuilder<Map<String,double>>(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if(snapshot.data!.isEmpty) {
            return Container(child:Text("Any invoice has been added yet, add an invoice to see the pie chart", textAlign: TextAlign.center,style: TextStyle(fontSize: 20)));
          }
          return pie_chart.PieChart(dataMap: snapshot.data!);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}