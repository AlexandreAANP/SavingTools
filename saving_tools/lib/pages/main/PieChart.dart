import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:pie_chart/pie_chart.dart' as pie_chart;
class PieChart extends StatefulWidget {
  const PieChart({Key? key}) : super(key: key);

  @override
  State<PieChart> createState() => _PieChartState();
}


class _PieChartState extends State<PieChart> {

  Map<String, double> dataMap = {
    "Casa": 10,
    "Pet": 30,
    "Carro": 40,
    "Comida": 20,
    "Outros": 10,
  };

  
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height * 0.5);
    pie_chart.PieChart pieChart = pie_chart.PieChart(dataMap: dataMap);
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
                      "Gastos em categorias",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      )
                    )
                  ),
                  pieChart,
                ],
              ),
            );
  }
}