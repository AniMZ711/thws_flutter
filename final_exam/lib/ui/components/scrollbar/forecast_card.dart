import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:intl/intl.dart";
import "package:skylinq/data/models/forecast.dart";

class ForecastCard extends StatelessWidget {
  final String icon;
  final String time;
  final String tempC;
  const ForecastCard(
      {Key? key, required this.icon, required this.time, required this.tempC})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
        child: SizedBox(
          width: 90,
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                      child:
                          Text(DateTime.parse(time).hour.toString() + ":00")),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(),
                    child: Image.network("https:$icon", fit: BoxFit.cover),
                  ),
                  Container(child: Text("${tempC}°C")),
                ],
              ),
            ),
          ),
        ));
  }
}
