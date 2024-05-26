import "package:intl/intl.dart";
import "package:skylinq/data/models/current_weather.dart";

class Forecast {
  final Location location;
  final Current current;
  final ForecastData forecast;

  Forecast(
      {required this.location, required this.current, required this.forecast});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
      forecast: ForecastData.fromJson(json['forecast']),
    );
  }
}

class ForecastData {
  final List<ForecastDay> forecastdays;

  ForecastData({required this.forecastdays});

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    return ForecastData(
      forecastdays: List<ForecastDay>.from(
          json['forecastday'].map((x) => ForecastDay.fromJson(x))),
    );
  }
}

class ForecastDay {
  final DateTime date;
  final Day day;
  final List<Hour> hour;

  ForecastDay({required this.date, required this.day, required this.hour});

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      date: DateTime.parse(json['date']),
      day: Day.fromJson(json['day']),
      hour: List<Hour>.from(json['hour'].map((x) => Hour.fromJson(x))),
    );
  }
  @override
  String toString() {
    return 'ForecastDay{date: $date, day: $day}';
  }
}

class Hour {
  final String time;
  final num tempC;
  final num isDay;
  final Condition condition;

  Hour(
      {required this.time,
      required this.tempC,
      required this.isDay,
      required this.condition});

  factory Hour.fromJson(Map<String, dynamic> json) {
    return Hour(
      time: json['time'],
      tempC: json['temp_c'],
      isDay: json['is_day'],
      condition: Condition.fromJson(json['condition']),
    );
  }
  @override
  String toString() {
    return 'Hour{time: $time, tempC: $tempC, isDay: $isDay, condition: $condition}';
  }
}

class Day {
  final num maxtempC;
  final num mintempC;
  final num avgtempC;
  final Condition condition;

  Day(
      {required this.maxtempC,
      required this.mintempC,
      required this.avgtempC,
      required this.condition});

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxtempC: json['maxtemp_c'],
      mintempC: json['mintemp_c'],
      avgtempC: json['avgtemp_c'],
      condition: Condition.fromJson(json['condition']),
    );
  }

  @override
  String toString() {
    return 'Day{maxtempC: $maxtempC, mintempC: $mintempC, avgtempC: $avgtempC}';
  }
}
