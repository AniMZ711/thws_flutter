import 'package:flutter/material.dart';

class TemperatureGauge extends StatelessWidget {
  final double maxTemp;
  final double avgTemp;
  final num weekMaxTemp;
  final num weekMinTemp;
  final double minTemp;
  final double rangeStart = 15;
  final double rangeEnd = 25;

  const TemperatureGauge({
    Key? key,
    required this.maxTemp,
    required this.avgTemp,
    required this.weekMaxTemp,
    required this.weekMinTemp,
    required this.minTemp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //calculate width and offset for day's temperature range
    double rangeWidth = (maxTemp - minTemp) / (weekMaxTemp - weekMinTemp);
    double rangeOffset = (minTemp - weekMinTemp) / (weekMaxTemp - weekMinTemp);
    //calculate offset for average temperature marker
    double averageOffset =
        (avgTemp - weekMinTemp) / (weekMaxTemp - weekMinTemp);
    final displayMinTemp = minTemp;
    final displayMaxTemp = maxTemp;

    //color stops for gradient
    List<Map<String, dynamic>> temperatureColors = [
      {'temp': -10, 'color': Colors.deepPurple[800]!},
      {'temp': -7.5, 'color': Colors.deepPurple[800]!},
      {'temp': -5, 'color': Colors.purple[700]!},
      {'temp': -2.5, 'color': Colors.purple[700]!},
      {'temp': 0, 'color': Colors.blue[800]!},
      {'temp': 2.5, 'color': Colors.blue[800]!},
      {'temp': 5, 'color': Colors.lightBlue},
      {'temp': 7.5, 'color': Colors.lightBlue},
      {'temp': 10, 'color': Colors.cyan},
      {'temp': 12.5, 'color': Colors.cyan},
      {'temp': 15, 'color': Colors.green},
      {'temp': 17.5, 'color': Colors.green},
      {'temp': 20, 'color': Colors.yellow},
      {'temp': 22.5, 'color': Colors.yellow},
      {'temp': 25, 'color': Colors.orange},
      {'temp': 27.5, 'color': Colors.orange},
      {'temp': 30, 'color': Colors.red[800]!},
      {'temp': 32.5, 'color': Colors.red[800]!},
      {'temp': 35, 'color': Colors.red[900]!}
    ];

    // Prepare the gradient colors and stops based on the temperatures
    List<Color> colors = [];
    List<double> stops = [];

    // Populate the colors and stops from the temperature-color mapping
    for (var entry in temperatureColors) {
      double relativePosition =
          (entry['temp'] - displayMinTemp) / (displayMaxTemp - displayMinTemp);
      if (relativePosition >= 0 && relativePosition <= 1) {
        colors.add(entry['color']);
        stops.add(relativePosition);
      }
    }

    // Ensure gradient covers the full range of the widget if colors list is too short
    if (colors.isEmpty || stops.isEmpty) {
      colors = [Colors.blue, Colors.red]; // Default
      stops = [0.0, 1.0];
    } else {
      //Add  start and end colors to ensure the gradient covers full range
      if (stops.first != 0.0) {
        colors.insert(0, colors.first);
        stops.insert(0, 0.0);
      }
      if (stops.last != 1.0) {
        colors.add(colors.last);
        stops.add(1.0);
      }
    }

    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
          width: 45,
          child: Center(
              child: Opacity(
            opacity: 0.5,
            child: Text(
              minTemp.toString() + "°",
              style: TextStyle(fontSize: 16),
            ),
          )),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 120,
                height: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[300]),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 120 * rangeOffset,
                      width: 120 * rangeWidth,
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: colors,
                              stops: stops),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 120 * averageOffset - 5,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color.fromARGB(255, 147, 147, 147),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 45,
          child: Center(
              child: Text(maxTemp.toString() + "°",
                  style: TextStyle(fontSize: 16))),
        ),
      ]),
    );
  }
}
