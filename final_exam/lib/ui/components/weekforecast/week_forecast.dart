import 'package:flutter/material.dart';
import 'package:skylinq/ui/components/weekforecast/forecast_row.dart';
import 'package:skylinq/data/models/forecast.dart';

class WeekForecast extends StatelessWidget {
  final Forecast forecastData;
  const WeekForecast({Key? key, required this.forecastData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ForecastDay> allDays = forecastData.forecast.forecastdays;
    num highestTemp = allDays
        .map((day) => day.day.maxtempC)
        .reduce((maxTemp, temp) => maxTemp > temp ? maxTemp : temp);
    num lowestTemp = allDays
        .map((day) => day.day.mintempC)
        .reduce((minTemp, temp) => minTemp < temp ? minTemp : temp);

    return Card(
        elevation: 2,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            height: 400,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.thermostat,
                    color: Colors.blue[700],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      '7-Day Forecast',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
                Expanded(
                  child: MediaQuery.removePadding(
                      context: context,
                      removeBottom: true,
                      child: ListView.builder(
                          itemCount: allDays.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ForecastRow(
                              icon:
                                  allDays[index].day.condition.icon.toString(),
                              time: allDays[index].date.toString(),
                              avgtempC: allDays[index].day.avgtempC,
                              maxTempC: allDays[index].day.maxtempC,
                              minTempC: allDays[index].day.mintempC,
                              weekMaxTemp: highestTemp,
                              weekMinTemp: lowestTemp,
                            );
                          })),
                ),
              ],
            )));
  }
}
