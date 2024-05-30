import "package:intl/intl.dart";

class CurrentWeather {
  final Location location;
  final Current current;

  CurrentWeather({required this.location, required this.current});

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
    );
  }

  @override
  String toString() {
    return 'CurrentWeather{location: $location, current: $current}';
  }
}

class Current {
  num tempC;
  num feelslikeC;
  Condition condition;
  num uv;

  Current({
    required this.tempC,
    required this.feelslikeC,
    required this.condition,
    required this.uv,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      tempC: json['temp_c'],
      feelslikeC: json['feelslike_c'],
      condition: Condition.fromJson(json['condition']),
      uv: json['uv'],
    );
  }

  @override
  String toString() {
    return 'Current{tempC: $tempC, feelslikeC: $feelslikeC, condition: $condition, uv: $uv}';
  }
}

class Condition {
  String text;
  String icon;
  num code;

  Condition({required this.text, required this.icon, required this.code});

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
      icon: json['icon'],
      code: json['code'],
    );
  }

  @override
  String toString() {
    return 'Condition{text: $text, icon: $icon, code: $code}';
  }
}

class Location {
  String name;
  DateTime localtime;
  String? region;
  String? country;

  Location(
      {required this.name, required this.localtime, this.region, this.country});

  factory Location.fromJson(Map<String, dynamic> json) {
    DateFormat format =
        DateFormat("yyyy-MM-dd H:mm"); // Adjust the format string as needed
    DateTime parsedDate;

    try {
      parsedDate = format.parse(json['localtime']);
    } catch (e) {
      // Handle the error or assign a default date
      parsedDate = DateTime.now();
      //TODO: implement logger
      print('Error parsing date: $e');
    }

    return Location(
      name: json['name'],
      localtime: parsedDate,
      region: json['region'],
      country: json['country'],
    );
  }

  @override
  String toString() {
    return 'Location{name: $name, localtime: $localtime, region: $region, country: $country}';
  }
}
