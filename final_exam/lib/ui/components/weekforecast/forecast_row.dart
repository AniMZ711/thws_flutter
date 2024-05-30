import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skylinq/ui/components/weekforecast/heat_bar.dart';

class ForecastRow extends StatelessWidget {
  final String icon;
  final String time;
  final num avgtempC;
  final num maxTempC;
  final num minTempC;
  final num weekMaxTemp;
  final num weekMinTemp;

  const ForecastRow(
      {Key? key,
      required this.icon,
      required this.time,
      required this.avgtempC,
      required this.maxTempC,
      required this.minTempC,
      required this.weekMaxTemp,
      required this.weekMinTemp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime tempDate = DateFormat("yyyy-MM-dd").parse(time, true);
    DateTime currentDate = DateTime.now();

    String formattedDate = DateFormat('EE').format(tempDate);

    bool isToday = tempDate.day == currentDate.day &&
        tempDate.month == currentDate.month &&
        tempDate.year == currentDate.year;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 2),
        Container(
          margin: EdgeInsets.fromLTRB(6, 0, 6, 0),
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Text(isToday ? 'Now' : formattedDate,
              style: TextStyle(fontSize: 16)),
        ),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(),
          child: Image.network("https:${icon}", fit: BoxFit.cover),
        ),
        Container(
            width: 250,
            child: TemperatureGauge(
              maxTemp: maxTempC.toDouble(),
              avgTemp: avgtempC.toDouble(),
              minTemp: minTempC.toDouble(),
              weekMinTemp: weekMinTemp,
              weekMaxTemp: weekMaxTemp,
            )),
      ],
    );
  }
}
