// To parse super JSON data, do
//
//     final weatherDataModel = weatherDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:skysense/src/domain/entities/weather_data_entity.dart';

WeatherDataModel weatherDataModelFromJson(String str) => WeatherDataModel.fromJson(json.decode(str));

String weatherDataModelToJson(WeatherDataModel data) => json.encode(data.toJson());

class WeatherDataModel extends WeatherDataEntity {

  WeatherDataModel({
    required super.location,
    required super.current,
    required super.forecast,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) => WeatherDataModel(
    location: Location.fromJson(json["location"]),
    current: Current.fromJson(json["current"]),
    forecast: Forecast.fromJson(json["forecast"]),
  );

}

class Current extends CurrentEntity{

  Current({
    super.lastUpdatedEpoch,
    super.lastUpdated,
    required super.tempC,
    required super.tempF,
    required super.isDay,
    required super.condition,
    required super.windMph,
    required super.windKph,
    required super.windDegree,
    required super.windDir,
    required super.pressureMb,
    required super.pressureIn,
    required super.precipMm,
    required super.precipIn,
    required super.humidity,
    required super.cloud,
    required super.feelslikeC,
    required super.feelslikeF,
    required super.windchillC,
    required super.windchillF,
    required super.heatindexC,
    required super.heatindexF,
    required super.dewpointC,
    required super.dewpointF,
    required super.visKm,
    required super.visMiles,
    required super.uv,
    required super.gustMph,
    required super.gustKph,
    super.timeEpoch,
    super.time,
    super.snowCm,
    super.willItRain,
    super.chanceOfRain,
    super.willItSnow,
    super.chanceOfSnow,
    required super.airQuality,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    lastUpdatedEpoch: json["last_updated_epoch"],
    lastUpdated: json["last_updated"],
    tempC: json["temp_c"]?.toDouble(),
    tempF: json["temp_f"]?.toDouble(),
    isDay: json["is_day"],
    condition: Condition.fromJson(json["condition"]),
    windMph: json["wind_mph"]?.toDouble(),
    windKph: json["wind_kph"]?.toDouble(),
    windDegree: json["wind_degree"],
    windDir: json["wind_dir"],
    pressureMb: json["pressure_mb"],
    pressureIn: json["pressure_in"]?.toDouble(),
    precipMm: json["precip_mm"],
    precipIn: json["precip_in"],
    humidity: json["humidity"],
    cloud: json["cloud"],
    feelslikeC: json["feelslike_c"]?.toDouble(),
    feelslikeF: json["feelslike_f"]?.toDouble(),
    windchillC: json["windchill_c"]?.toDouble(),
    windchillF: json["windchill_f"]?.toDouble(),
    heatindexC: json["heatindex_c"]?.toDouble(),
    heatindexF: json["heatindex_f"]?.toDouble(),
    dewpointC: json["dewpoint_c"]?.toDouble(),
    dewpointF: json["dewpoint_f"]?.toDouble(),
    visKm: json["vis_km"],
    visMiles: json["vis_miles"],
    uv: json["uv"].toString(),
    gustMph: json["gust_mph"]?.toDouble(),
    gustKph: json["gust_kph"]?.toDouble(),
    timeEpoch: json["time_epoch"],
    time: json["time"],
    snowCm: json["snow_cm"],
    willItRain: json["will_it_rain"],
    chanceOfRain: json["chance_of_rain"],
    willItSnow: json["will_it_snow"],
    chanceOfSnow: json["chance_of_snow"],
    airQuality: AirQuality.fromJson(json["air_quality"]),
  );

}

class Condition extends ConditionEntity{

  Condition({
    required super.text,
    required super.icon,
    required super.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
    text: json["text"],
    icon: json["icon"],
    code: json["code"],
  );
}

class Forecast extends ForecastEntity {

  Forecast({
    required super.forecastday,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
    forecastday: List<Forecastday>.from(json["forecastday"].map((x) => Forecastday.fromJson(x))),
  );

}

class Forecastday extends ForecastdayEntity {

  Forecastday({
    required super.date,
    required super.dateEpoch,
    required super.day,
    required super.astro,
    required super.hour,
  });

  factory Forecastday.fromJson(Map<String, dynamic> json) => Forecastday(
    date: DateTime.parse(json["date"]),
    dateEpoch: json["date_epoch"],
    day: Day.fromJson(json["day"]),
    astro: Astro.fromJson(json["astro"]),
    hour: List<Current>.from(json["hour"].map((x) => Current.fromJson(x))),
  );


}

class Astro extends AstroEntity {

  Astro({
    required super.sunrise,
    required super.sunset,
    required super.moonrise,
    required super.moonset,
    required super.moonPhase,
    required super.moonIllumination,
    required super.isMoonUp,
    required super.isSunUp,
  });

  factory Astro.fromJson(Map<String, dynamic> json) => Astro(
    sunrise: json["sunrise"],
    sunset: json["sunset"],
    moonrise: json["moonrise"],
    moonset: json["moonset"],
    moonPhase: json["moon_phase"],
    moonIllumination: json["moon_illumination"],
    isMoonUp: json["is_moon_up"],
    isSunUp: json["is_sun_up"],
  );


}

class Day extends DayEntitiy {

  Day({
    required super.maxtempC,
    required super.maxtempF,
    required super.mintempC,
    required super.mintempF,
    required super.avgtempC,
    required super.avgtempF,
    required super.maxwindMph,
    required super.maxwindKph,
    required super.totalprecipMm,
    required super.totalprecipIn,
    required super.totalsnowCm,
    required super.avgvisKm,
    required super.avgvisMiles,
    required super.avghumidity,
    required super.dailyWillItRain,
    required super.dailyChanceOfRain,
    required super.dailyWillItSnow,
    required super.dailyChanceOfSnow,
    required super.condition,
    required super.uv,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    maxtempC: json["maxtemp_c"],
    maxtempF: json["maxtemp_f"],
    mintempC: json["mintemp_c"]?.toDouble(),
    mintempF: json["mintemp_f"]?.toDouble(),
    avgtempC: json["avgtemp_c"]?.toDouble(),
    avgtempF: json["avgtemp_f"]?.toDouble(),
    maxwindMph: json["maxwind_mph"]?.toDouble(),
    maxwindKph: json["maxwind_kph"],
    totalprecipMm: json["totalprecip_mm"],
    totalprecipIn: json["totalprecip_in"],
    totalsnowCm: json["totalsnow_cm"],
    avgvisKm: json["avgvis_km"],
    avgvisMiles: json["avgvis_miles"],
    avghumidity: json["avghumidity"],
    dailyWillItRain: json["daily_will_it_rain"],
    dailyChanceOfRain: json["daily_chance_of_rain"],
    dailyWillItSnow: json["daily_will_it_snow"],
    dailyChanceOfSnow: json["daily_chance_of_snow"],
    condition: Condition.fromJson(json["condition"]),
    uv: json["uv"],
  );


}

class Location extends LocationEntity {

  Location({
    required super.name,
    required super.region,
    required super.country,
    required super.lat,
    required super.lon,
    required super.tzId,
    required super.localtimeEpoch,
    required super.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    name: json["name"],
    region: json["region"],
    country: json["country"],
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
    tzId: json["tz_id"],
    localtimeEpoch: json["localtime_epoch"],
    localtime: json["localtime"],
  );
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class AirQuality extends AirQualityEntity {

  AirQuality({
    super.co,
    super.no2,
    super.o3,
    super.so2,
    super.pm25,
    super.pm10,
    super.usEpaIndex,
    super.gbDefraIndex,
    super.aqiData,
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) => AirQuality(
    co: json["co"]?.toDouble(),
    no2: json["no2"]?.toDouble(),
    o3: json["o3"]?.toDouble(),
    so2: json["so2"]?.toDouble(),
    pm25: json["pm2_5"]?.toDouble(),
    pm10: json["pm10"]?.toDouble(),
    usEpaIndex: json["us-epa-index"],
    gbDefraIndex: json["gb-defra-index"],
    aqiData: json["aqi_data"],
  );

}