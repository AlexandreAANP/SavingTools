
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:saving_tools/Services/StatisticsService.dart';


class LineChartsStatistics extends StatefulWidget {

  LineChartsStatistics();
  
  @override
  State<StatefulWidget> createState() => LinesChartsStatisticsState();
  
}

class LinesChartsStatisticsState extends State<LineChartsStatistics>{
  LinesChartsStatisticsState();
  List<String> Months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
  List<String>? last3Months;
  double maxAmount = 100;
  double maxX = 90;
  @override
  void initState() {
    maxAmount = 100;
    int currentMonth = DateTime.now().month;
    List<String> last3Months = [Months[currentMonth-3], Months[currentMonth-2], Months[currentMonth-1]];
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child:Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: (){
                    setState(() {
                      maxAmount = maxAmount/2;
                    });
              },
              child: Icon(Icons.zoom_in, size: 30, color: const Color.fromARGB(255, 9, 102, 45),),
              ),
              ElevatedButton(
                onPressed: (){
                setState(() {
                      maxAmount = maxAmount*2;
                });
              },
              child: Icon(Icons.zoom_out, size: 30, color: const Color.fromARGB(255, 9, 102, 45)),
              ),
            ],
          )
        ),
        Container(
      color: Colors.white,
      height: 300,
      padding: const EdgeInsets.all(20),
      child: FutureBuilder<LineChartData>(
        future: invoicesData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return LineChart(
                      snapshot.data!,
                      duration: const Duration(milliseconds: 250),
                    );
          } else {
            return Container(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      
    )
      ], 
    );
  }

  Future<LineChartData> get invoicesData async => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: await titlesYValues,
        borderData: borderData,
        lineBarsData: await lineBarsData,
        minX: 0,
        maxX: await getMaxX(),
        maxY: await getMaxY(),
        minY: 0,
      );

    Future<double> getMaxY() async {
      
      return maxAmount;
    }

    Future<double> getMaxX() async {
      return maxX;
    }

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.8),
        ),
      );

  Future<FlTitlesData> get titlesYValues async => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: await leftTitles(),
        ),
      );

  Future<List<LineChartBarData>> get lineBarsData async => [
        await lineChartBarDebitData,
        await lineChartBarDataCredit,
      ];

  LineTouchData get lineTouchData2 => const LineTouchData(
        enabled: false,
      );




  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    int intValue = value.toInt();
    String text = intValue.toString();
    if(text.length > 6){
      text = text.substring(0, 6) + 'K';
    }


    return Text(text, overflow: TextOverflow.visible, maxLines: 1, style: style, textAlign: TextAlign.center,);
  }

  Future<SideTitles> leftTitles() async => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: (await getMaxY())/5,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    if(last3Months == null ){
      int currentMonth = DateTime.now().month;
       last3Months = [Months[currentMonth-3], Months[currentMonth-2], Months[currentMonth-1]];
    }
    switch (value.toInt()) {
      case 15:
        text = Text(last3Months!.elementAt(0), style: style);
        break;
      case 45:
        text = Text(last3Months!.elementAt(1), style: style);
        break;
      case 75:
        text = Text(last3Months!.elementAt(2), style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom:
              BorderSide(color: Colors.brown, width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  Future<LineChartBarData> get lineChartBarDebitData async => LineChartBarData(
        isCurved: false,
        color: const Color.fromARGB(255, 199, 0, 0),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: await getDebitData(),
      );

  Future<LineChartBarData> get lineChartBarDataCredit async => LineChartBarData(
        isCurved: false,
        color: const Color.fromARGB(255, 0, 147, 56),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(
          show: false,
          color: Colors.blueGrey,
        ),
        spots: await getCreditData(),
      );

  Future<List<FlSpot>> getCreditData() async{
    int yearIncrementer = (DateTime.now().month - 2) < 0 ? -1 : 0;
    int initialMonth = (DateTime.now().month - 2) < 0 ? 12 + (DateTime.now().month - 2) : DateTime.now().month - 2;
    List<FlSpot>data = await StatisticsService().getCreditData(
                        initialMonth: DateTime.utc(DateTime.now().year + yearIncrementer,initialMonth,1),
                        finalMonth: DateTime.now(),
                        maxValue: maxAmount,
                        );
    return data;
  }


  Future<List<FlSpot>> getDebitData() async{
    int yearIncrementer = (DateTime.now().month - 2) < 0 ? -1 : 0;
    int initialMonth = (DateTime.now().month - 2) < 0 ? 12 + (DateTime.now().month - 2) : DateTime.now().month - 2;
    List<FlSpot> data = await StatisticsService().getDebitData(
                        initialMonth: DateTime.utc(DateTime.now().year + yearIncrementer,initialMonth,1),
                        finalMonth: DateTime.now(),
                        maxValue: maxAmount
                        );
    return data;
  }


}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 37,
              ),
              const Text(
                'Monthly Sales',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 37,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: LineChartsStatistics(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
            ),
            onPressed: () {
              setState(() {
                isShowingMainData = !isShowingMainData;
              });
            },
          )
        ],
      ),
    );
  }
}