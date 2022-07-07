class ForcastDaysModel {
  ForcastDaysModel({
    double? lat,
    double? lon,
    String? timezone,
    int? timezoneOffset,
    Current? current,
    List<Daily>? daily,
    List<Alerts>? alerts,}){
    _lat = lat;
    _lon = lon;
    _timezone = timezone;
    _timezoneOffset = timezoneOffset;
    _current = current;
    _daily = daily;
    _alerts = alerts;
  }

  ForcastDaysModel.fromJson(dynamic json) {
    _lat = json['lat'].toDouble();
    _lon = json['lon'].toDouble();
    _timezone = json['timezone'];
    _timezoneOffset = json['timezone_offset'];
    _current = json['current'] != null ? Current.fromJson(json['current']) : null;
    if (json['daily'] != null) {
      _daily = [];
      json['daily'].forEach((v) {
        _daily?.add(Daily.fromJson(v));
      });
    }
    if (json['alerts'] != null) {
      _alerts = [];
      json['alerts'].forEach((v) {
        _alerts?.add(Alerts.fromJson(v));
      });
    }
  }
  double? _lat;
  double? _lon;
  String? _timezone;
  int? _timezoneOffset;
  Current? _current;
  List<Daily>? _daily;
  List<Alerts>? _alerts;

  double? get lat => _lat;
  double? get lon => _lon;
  String? get timezone => _timezone;
  int? get timezoneOffset => _timezoneOffset;
  Current? get current => _current;
  List<Daily>? get daily => _daily;
  List<Alerts>? get alerts => _alerts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['lon'] = _lon;
    map['timezone'] = _timezone;
    map['timezone_offset'] = _timezoneOffset;
    if (_current != null) {
      map['current'] = _current?.toJson();
    }
    if (_daily != null) {
      map['daily'] = _daily?.map((v) => v.toJson()).toList();
    }
    if (_alerts != null) {
      map['alerts'] = _alerts?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Alerts {
  Alerts({
    String? senderName,
    String? event,
    int? start,
    int? end,
    String? description,
    List<String>? tags,}){
    _senderName = senderName;
    _event = event;
    _start = start;
    _end = end;
    _description = description;
    _tags = tags;
  }

  Alerts.fromJson(dynamic json) {
    _senderName = json['sender_name'];
    _event = json['event'];
    _start = json['start'];
    _end = json['end'];
    _description = json['description'];
    _tags = json['tags'] != null ? json['tags'].cast<String>() : [];
  }
  String? _senderName;
  String? _event;
  int? _start;
  int? _end;
  String? _description;
  List<String>? _tags;

  String? get senderName => _senderName;
  String? get event => _event;
  int? get start => _start;
  int? get end => _end;
  String? get description => _description;
  List<String>? get tags => _tags;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sender_name'] = _senderName;
    map['event'] = _event;
    map['start'] = _start;
    map['end'] = _end;
    map['description'] = _description;
    map['tags'] = _tags;
    return map;
  }

}

class Daily {
  Daily({
    int? dt,
    int? sunrise,
    int? sunset,
    int? moonrise,
    int? moonset,
    double? moonPhase,
    Temp? temp,
    int? pressure,
    int? humidity,
    double? dewPoint,
    double? windSpeed,
    int? windDeg,
    double? windGust,
    List<Weather>? weather,
    int? clouds,
    double? pop,
    double? rain,
    double? uvi,}){
    _dt = dt;
    _sunrise = sunrise;
    _sunset = sunset;
    _moonrise = moonrise;
    _moonset = moonset;
    _moonPhase = moonPhase;
    _temp = temp;
    _pressure = pressure;
    _humidity = humidity;
    _dewPoint = dewPoint;
    _windSpeed = windSpeed;
    _windDeg = windDeg;
    _windGust = windGust;
    _weather = weather;
    _clouds = clouds;
    _pop = pop;
    _rain = rain;
    _uvi = uvi;
  }

  Daily.fromJson(dynamic json) {
    _dt = json['dt'];
    _sunrise = json['sunrise'];
    _sunset = json['sunset'];
    _moonrise = json['moonrise'];
    _moonset = json['moonset'];
    _moonPhase = json['moon_phase'].toDouble();
    _temp = json['temp'] != null ? Temp.fromJson(json['temp']) : null;
    _pressure = json['pressure'];
    _humidity = json['humidity'];
    _dewPoint = json['dew_point'].toDouble();
    _windSpeed = json['wind_speed'].toDouble();
    _windDeg = json['wind_deg'];
    _windGust = json['wind_gust'].toDouble();
    if (json['weather'] != null) {
      _weather = [];
      json['weather'].forEach((v) {
        _weather?.add(Weather.fromJson(v));
      });
    }
    _clouds = json['clouds'];
  }
  int? _dt;
  int? _sunrise;
  int? _sunset;
  int? _moonrise;
  int? _moonset;
  double? _moonPhase;
  Temp? _temp;
  int? _pressure;
  int? _humidity;
  double? _dewPoint;
  double? _windSpeed;
  int? _windDeg;
  double? _windGust;
  List<Weather>? _weather;
  int? _clouds;
  double? _pop;
  double? _rain;
  double? _uvi;

  int? get dt => _dt;
  int? get sunrise => _sunrise;
  int? get sunset => _sunset;
  int? get moonrise => _moonrise;
  int? get moonset => _moonset;
  double? get moonPhase => _moonPhase;
  Temp? get temp => _temp;
  int? get pressure => _pressure;
  int? get humidity => _humidity;
  double? get dewPoint => _dewPoint;
  double? get windSpeed => _windSpeed;
  int? get windDeg => _windDeg;
  double? get windGust => _windGust;
  List<Weather>? get weather => _weather;
  int? get clouds => _clouds;
  double? get pop => _pop;
  double? get rain => _rain;
  double? get uvi => _uvi;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dt'] = _dt;
    map['sunrise'] = _sunrise;
    map['sunset'] = _sunset;
    map['moonrise'] = _moonrise;
    map['moonset'] = _moonset;
    map['moon_phase'] = _moonPhase;
    if (_temp != null) {
      map['temp'] = _temp?.toJson();
    }
    map['pressure'] = _pressure;
    map['humidity'] = _humidity;
    // map['dew_point'] = _dewPoint;
    map['wind_speed'] = _windSpeed;
    map['wind_deg'] = _windDeg;
    map['wind_gust'] = _windGust;
    if (_weather != null) {
      map['weather'] = _weather?.map((v) => v.toJson()).toList();
    }
    map['clouds'] = _clouds;
    map['pop'] = _pop;
    map['rain'] = _rain;
    map['uvi'] = _uvi;
    return map;
  }
}

class Weather {
  Weather({
    int? id,
    String? main,
    String? description,
    String? icon,}){
    _id = id;
    _main = main;
    _description = description;
    _icon = icon;
  }

  Weather.fromJson(dynamic json) {
    _id = json['id'];
    _main = json['main'];
    _description = json['description'];
    _icon = json['icon'];
  }
  int? _id;
  String? _main;
  String? _description;
  String? _icon;

  int? get id => _id;
  String? get main => _main;
  String? get description => _description;
  String? get icon => _icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['main'] = _main;
    map['description'] = _description;
    map['icon'] = _icon;
    return map;
  }

}

class Temp {
  Temp({
    double? day,
    double? min,
    double? max,
    double? night,
    double? eve,
    double? morn,}){
    _day = day;
    _min = min;
    _max = max;
    _night = night;
    _eve = eve;
    _morn = morn;
  }

  Temp.fromJson(dynamic json) {
    _day = json['day'].toDouble();
    _min = json['min'].toDouble();
    _max = json['max'].toDouble();
    _night = json['night'].toDouble();
    _eve = json['eve'].toDouble();
    _morn = json['morn'].toDouble();
  }
  double? _day;
  double? _min;
  double? _max;
  double? _night;
  double? _eve;
  double? _morn;

  double? get day => _day;
  double? get min => _min;
  double? get max => _max;
  double? get night => _night;
  double? get eve => _eve;
  double? get morn => _morn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = _day;
    map['min'] = _min;
    map['max'] = _max;
    map['night'] = _night;
    map['eve'] = _eve;
    map['morn'] = _morn;
    return map;
  }

}

class Current {
  Current({
    int? dt,
    int? sunrise,
    int? sunset,
    double? temp,
    int? pressure,
    int? humidity,
    double? dewPoint,
    double? uvi,
    int? clouds,
    int? visibility,
    double? windSpeed,
    int? windDeg,
    double? windGust,
    List<Weather>? weather,}){
    _dt = dt;
    _sunrise = sunrise;
    _sunset = sunset;
    _temp = temp;
    _pressure = pressure;
    _humidity = humidity;
    _dewPoint = dewPoint;
    _uvi = uvi;
    _clouds = clouds;
    _visibility = visibility;
    _windSpeed = windSpeed;
    _windDeg = windDeg;
    _windGust = windGust;
    _weather = weather;
  }

  Current.fromJson(dynamic json) {
    _dt = json['dt'];
    _sunrise = json['sunrise'];
    _sunset = json['sunset'];
    _temp = json['temp'].toDouble();
    _pressure = json['pressure'];
    _humidity = json['humidity'];
    _dewPoint = json['dew_point'].toDouble();
    _uvi = json['uvi'].toDouble();
    _clouds = json['clouds'];
    _visibility = json['visibility'];
    _windSpeed = json['wind_speed'].toDouble();
    _windDeg = json['wind_deg'];
    if (json['weather'] != null) {
      _weather = [];
      json['weather'].forEach((v) {
        _weather?.add(Weather.fromJson(v));
      });
    }

  }
  int? _dt;
  int? _sunrise;
  int? _sunset;
  double? _temp;
  int? _pressure;
  int? _humidity;
  double? _dewPoint;
  double? _uvi;
  int? _clouds;
  int? _visibility;
  double? _windSpeed;
  int? _windDeg;
  double? _windGust;
  List<Weather>? _weather;

  int? get dt => _dt;
  int? get sunrise => _sunrise;
  int? get sunset => _sunset;
  double? get temp => _temp;
  int? get pressure => _pressure;
  int? get humidity => _humidity;
  double? get dewPoint => _dewPoint;
  double? get uvi => _uvi;
  int? get clouds => _clouds;
  int? get visibility => _visibility;
  double? get windSpeed => _windSpeed;
  int? get windDeg => _windDeg;
  double? get windGust => _windGust;
  List<Weather>? get weather => _weather;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dt'] = _dt;
    map['sunrise'] = _sunrise;
    map['sunset'] = _sunset;
    map['temp'] = _temp;
    map['pressure'] = _pressure;
    map['humidity'] = _humidity;
    map['uvi'] = _uvi;
    map['clouds'] = _clouds;
    map['visibility'] = _visibility;
    map['wind_speed'] = _windSpeed;
    map['wind_deg'] = _windDeg;
    map['wind_gust'] = _windGust;
    if (_weather != null) {
      map['weather'] = _weather?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}