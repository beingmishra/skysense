import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getBgImage(int condition, int isDay) {
  switch (condition) {
    case 1000:
      return isDay == 1
          ? "assets/images/sunny.jpg"
          : "assets/images/clear_night.jpg";
    case 1003:
      return "assets/images/cloudy.jpg";
    case 1063:
      return "assets/images/rainy.jpg";
    default:
      return "assets/images/stormy.jpg";
  }
}

String getAirQualityDescription(int index) {
  switch (index) {
    case 1:
      return "Air quality is excellent. Enjoy the fresh air!";
    case 2:
      return "Air quality is moderate. Sensitive individuals may experience minor discomfort.";
    case 3:
      return "Air quality is unhealthy for sensitive groups. Limit outdoor exertion.";
    case 4:
      return "Air quality is unhealthy. Avoid prolonged outdoor exposure.";
    case 5:
      return "Air quality is very unhealthy. Stay indoors and avoid outdoor activity.";
    case 6:
      return "Air quality is hazardous. Avoid all outdoor activity.";
    default:
      return "Unknown";
  }
}

String getUVIndexDescription(int index) {
  switch (index) {
    case 1:
    case 2:
      return "Low";
    case 3:
    case 4:
    case 5:
      return "Moderate";
    case 6:
    case 7:
      return "High";
    case 8:
    case 9:
    case 10:
      return "Very High";
    case 11:
      return "Extreme";
    default:
      return "Unknown";
  }
}

bool isDaytime(String sunrise, String sunset) {
  final now = DateTime.now();
  DateFormat formatter = DateFormat('hh:mm a');
  final parsedSunriseTime = formatter.parse(sunrise);
  final parsedSunsetTime = formatter.parse(sunset);
  final sunriseTime = DateTime.now().copyWith(
      hour: parsedSunriseTime.hour, minute: parsedSunriseTime.minute);
  var sunsetTime = DateTime.now()
      .copyWith(hour: parsedSunsetTime.hour, minute: parsedSunsetTime.minute);

  return now.isAfter(sunriseTime) && now.isBefore(sunsetTime);
}

Route createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}