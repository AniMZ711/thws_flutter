import "package:flutter/material.dart";
import "package:skylinq/data/models/forecast.dart";
import "package:skylinq/ui/components/scrollbar/forecast_card.dart";

class ForecastScroll extends StatelessWidget {
  final Forecast forecastData;
  const ForecastScroll({Key? key, required this.forecastData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Hour> allHours = forecastData.forecast.forecastdays[0].hour;

    List<Hour> filteredHours = allHours
        .where((hour) => DateTime.parse(hour.time).hour >= DateTime.now().hour)
        .toList();

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filteredHours.length,
        itemBuilder: (context, index) {
          return ForecastCard(
              icon: filteredHours[index].condition.icon,
              time: filteredHours[index].time,
              tempC: filteredHours[index].tempC.toInt().toString());
        });
  }
}
