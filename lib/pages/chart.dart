import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter_fiebase/components/background.dart';
import 'package:project_flutter_fiebase/components/indicator.dart';

class Chart extends StatefulWidget {
  const Chart({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: AspectRatio(
        aspectRatio: 1.5,
        child: Card(
          color: Colors.white70,
          child: Row(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                        pieTouchData: PieTouchData(touchCallback:
                            (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection.touchedSectionIndex;
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 50,
                        sections: showingSections()),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Indicator(
                    color: Colors.deepPurpleAccent,
                    text: 'Halloween',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Indicator(
                    color: Colors.pinkAccent,
                    text: 'Doraemon',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Indicator(
                    color: Colors.indigoAccent,
                    text: 'Black Adam',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Indicator(
                    color: Colors.lightGreen,
                    text: 'Doctor G',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
              const SizedBox(
                width: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color:  Colors.pinkAccent,
            value: 50,
            title: '50%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.indigoAccent,
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.lightGreen,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.deepPurpleAccent,
            value: 25,
            title: '25%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
