import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skylinq/data/models/forecast.dart';
import 'package:skylinq/ui/pages/locations_page.dart';

class WeatherCard extends StatelessWidget {
  final Forecast forecast;

  const WeatherCard({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          width: 400,
          height: 300,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12)),
          child: Column(children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangeLocationPage()),
                );
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(width: 8),
                    Text(
                      forecast.location.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
                DateFormat('EEEE, d MMMM yyyy HH:mm')
                    .format(forecast.location.localtime),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.white)),
            SizedBox(
                width: 250,
                child: Center(
                    child: Text("${forecast.current.tempC.toInt()}°C",
                        style: const TextStyle(
                            fontSize: 68,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)))),
            const Divider(
              color: Colors.white,
              thickness: 1,
              indent: 25,
              endIndent: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                          child: Column(children: [
                            Icon(Icons.speed_sharp, color: Colors.white),
                            Text("UV Index",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))
                          ]),
                        ),
                        Center(
                            child: Text(forecast.current.uv.toInt().toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold))),
                      ]),
                ),
                //Vertical line
                Container(height: 75, width: 1, color: Colors.white),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          child: Image.network(
                              "https:${forecast.current.condition.icon}",
                              fit: BoxFit.contain),
                        ),
                        Center(
                            child: Text(forecast.current.condition.text,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                      ]),
                ),
                Container(height: 75, width: 1, color: Colors.white),
                Container(
                  padding: const EdgeInsets.all(4),
                  width: 100,
                  height: 100,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "${forecast.forecast.forecastdays[0].day.maxtempC.toString()}°C",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                        Text(
                            "${forecast.forecast.forecastdays[0].day.mintempC.toString()}°C",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500))
                      ]),
                ),
              ],
            )
          ]))
    ]);
  }
}
