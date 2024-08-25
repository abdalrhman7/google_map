class WeatherModel {
  Location? location;
  Current? current;

  WeatherModel({this.location, this.current});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    current =
    json['current'] != null ? Current.fromJson(json['current']) : null;
  }

}

class Location {
  String? name;
  String? region;
  String? country;


  Location(
      {this.name,
        this.region,
        this.country,
      });

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    region = json['region'];
    country = json['country'];
  }

}

class Current {
  double? tempC;
  Current(
      {
        this.tempC,
      });
  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
  }

}

class Condition {
  String? text;

  Condition({this.text});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }
}