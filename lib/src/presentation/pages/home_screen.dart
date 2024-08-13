import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skysense/core/utils/helpers.dart';
import 'package:skysense/main.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:skysense/src/data/models/weather_data_model.dart';
import 'package:skysense/src/presentation/bloc/weather_bloc.dart';
import 'package:skysense/src/presentation/pages/search_screen.dart';
import 'package:skysense/src/presentation/widgets/loading_view_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  WeatherDataModel? weatherDataModel;


  @override
  void initState() {
    super.initState();
    _getCurrentAddress();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: getAppBar(),
      body: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherLoading) {
            setState(() {
              isLoading = true;
            });
          }

          if (state is WeatherFailure) {
            toastLong(state.error);
            setState(() {
              isLoading = false;
            });
          }

          if (state is WeathersDisplaySuccess) {
            setState(() {
              isLoading = false;
              weatherDataModel = state.weatherData;
              print(weatherDataModel!.current.condition.code);
            });
          }
        },
        child: isLoading
            ? const LoadingViewWidget()
            : weatherDataModel == null
                ? const LoadingViewWidget()
                : Stack(
                    children: [
                      Image.asset(
                        getBgImage(weatherDataModel!.current.condition.code,
                            weatherDataModel!.current.isDay),
                        fit: BoxFit.cover,
                        height: size.height,
                        width: size.width,
                      ),
                      Container(
                        height: size.height,
                        width: size.width,
                        color: const Color(0xff20242E).withOpacity(0.5),
                      ),
                      buildWeatherView(size)
                    ],
                  ),
      ),
    );
  }

  Future<void> _getCurrentAddress() async {
    var perms = await Geolocator.checkPermission();

    if (perms != LocationPermission.always &&
        perms != LocationPermission.whileInUse) {
      await Geolocator.requestPermission();
      _getCurrentAddress();
      return;
    }

    currentLocation ??= await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentLocation!.latitude, currentLocation!.longitude);
    if (placemarks.first.locality != null) {
      BlocProvider.of<WeatherBloc>(context)
          .add(GetWeatherEvent(locationName: placemarks.first.locality!));
    } else {
      toastLong("Unable to fetch location");
    }
  }

  buildCurrentView(Size size) {
    return SizedBox(
      height: size.height * 0.8,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            weatherDataModel!.location.name,
            style: GoogleFonts.nunito(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: const Color(0xffFDFDFC)),
          ),
          Text(
            DateFormat("hh:mm a - EEEE, dd MMM yy").format(DateTime.now()),
            style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xffFDFDFC)),
          ),
          const Spacer(),
          Text(
            "${weatherDataModel!.current.tempC}°",
            style: GoogleFonts.nunito(
                fontSize: 80,
                fontWeight: FontWeight.w600,
                color: const Color(0xffFDFDFC)),
          ),
          Row(
            children: [
              Image.network(
                  "https:${weatherDataModel!.current.condition.icon}"),
              12.width,
              Text(
                weatherDataModel!.current.condition.text,
                style: GoogleFonts.nunito(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffFDFDFC)),
              ),
            ],
          ),
          Divider(
            color: Colors.white.withOpacity(0.75),
          ).paddingSymmetric(vertical: 32),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Wind",
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade400),
                  ),
                  16.height,
                  Text(
                    weatherDataModel!.current.windKph.toString(),
                    style: GoogleFonts.nunito(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Text(
                    "km/h",
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  12.height,
                  LinearProgressIndicator(
                    color: Colors.green,
                    value: weatherDataModel!.current.windKph / 100,
                    backgroundColor: textSecondaryColor,
                  )
                ],
              ).expand(),
              SizedBox(
                width: size.width * 0.15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rain",
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade400),
                  ),
                  16.height,
                  Text(
                    (weatherDataModel!.current.chanceOfRain ?? 0).toString(),
                    style: GoogleFonts.nunito(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Text(
                    "%",
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  12.height,
                  LinearProgressIndicator(
                    color: Colors.green,
                    value: (weatherDataModel!.current.chanceOfRain ?? 0) / 100,
                    backgroundColor: textSecondaryColor,
                  )
                ],
              ).expand(),
              SizedBox(
                width: size.width * 0.15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Humidity",
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade400),
                  ),
                  16.height,
                  Text(
                    (weatherDataModel!.current.humidity).toString(),
                    style: GoogleFonts.nunito(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Text(
                    "%",
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  12.height,
                  LinearProgressIndicator(
                    color: Colors.redAccent,
                    value: weatherDataModel!.current.humidity / 100,
                    backgroundColor: textSecondaryColor,
                  )
                ],
              ).expand(),
            ],
          ),
        ],
      ),
    );
  }

  buildHourlyView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hourly",
          style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xffFDFDFC)),
        ),
        12.height,
        HorizontalList(
            itemCount: weatherDataModel!.forecast.forecastday.first.hour.length,
            spacing: 12.0,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              var data =
                  weatherDataModel!.forecast.forecastday.first.hour[index];
              return Blur(
                blur: 10,
                child: Container(
                  decoration: boxDecorationWithRoundedCorners(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(colors: [
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0.2),
                      ])),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        data.time == null
                            ? "-"
                            : DateFormat("h a")
                                .format(DateTime.parse(data.time!)),
                        style: GoogleFonts.nunito(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: const Color(0xffFDFDFC)),
                      ),
                      4.height,
                      Image.network(
                        "https:${data.condition.icon}",
                        height: 42,
                      ),
                      4.height,
                      Text(
                        "${data.tempC}°",
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: const Color(0xffFDFDFC)),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }

  buildUpcomingForecast(Size size) {
    return Blur(
      blur: 10,
      child: Container(
        width: size.width,
        decoration: boxDecorationWithRoundedCorners(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(colors: [
              Colors.white.withOpacity(0.3),
              Colors.white.withOpacity(0.2),
            ])),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${weatherDataModel!.forecast.forecastday.length - 1} Day Forecast",
              style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xffFDFDFC)),
            ),
            Divider(
              thickness: 1.5,
              color: Colors.grey.shade200.withOpacity(0.5),
            ),
            Column(
              children: weatherDataModel!.forecast.forecastday
                  .map((data) => Row(
                        children: [
                          Text(
                            DateFormat("EEEE").format(data.date),
                            style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: const Color(0xffFDFDFC)),
                          ).expand(),
                          Image.network(
                            "https:${data.day.condition.icon}",
                            height: 42,
                          ),
                          Text(
                            "${data.day.mintempC}° - ${data.day.maxtempC}°",
                            style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: const Color(0xffFDFDFC)),
                            textAlign: TextAlign.end,
                          ).expand(),
                        ],
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  buildSunriseSetView() {
    return Blur(
      blur: 10,
      child: Container(
        decoration: boxDecorationWithRoundedCorners(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(colors: [
              Colors.white.withOpacity(0.3),
              Colors.white.withOpacity(0.2),
            ])),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.air,
                  color: Colors.grey.shade300,
                ),
                8.width,
                Text(
                  isDaytime(
                          weatherDataModel!
                              .forecast.forecastday.first.astro.sunrise,
                          weatherDataModel!
                              .forecast.forecastday.first.astro.sunset)
                      ? "Next is Sunset"
                      : "Next is Sunrise",
                  style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffFDFDFC)),
                ),
              ],
            ),
            Divider(
              thickness: 1.5,
              color: Colors.grey.shade200.withOpacity(0.5),
            ),
            8.height,
            Row(
              children: [
                const Icon(
                  Icons.sunny,
                  color: Colors.amber,
                ),
                8.width,
                Text(
                  weatherDataModel!.forecast.forecastday.first.astro.sunrise,
                  style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffFDFDFC)),
                ),
              ],
            ),
            12.height,
            Row(
              children: [
                const Icon(
                  Icons.nightlight,
                  color: Colors.purpleAccent,
                ),
                8.width,
                Text(
                  weatherDataModel!.forecast.forecastday.first.astro.sunset,
                  style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffFDFDFC)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  buildAirQualityView() {
    return Blur(
      blur: 10,
      child: Container(
        decoration: boxDecorationWithRoundedCorners(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(colors: [
              Colors.white.withOpacity(0.3),
              Colors.white.withOpacity(0.2),
            ])),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.air,
                  color: Colors.grey.shade300,
                ),
                8.width,
                Text(
                  "Air Quality",
                  style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffFDFDFC)),
                ),
              ],
            ),
            Divider(
              thickness: 1.5,
              color: Colors.grey.shade200.withOpacity(0.5),
            ),
            8.height,
            Text(
              getAirQualityDescription(
                  weatherDataModel!.current.airQuality.usEpaIndex!),
              style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xffFDFDFC)),
            ),
          ],
        ),
      ),
    );
  }

  buildFeelsLikeAndUvView() {
    return IntrinsicHeight(
      child: Row(
        children: [
          Blur(
            blur: 10,
            child: Container(
              decoration: boxDecorationWithRoundedCorners(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.2),
                  ])),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.thermostat,
                        color: Colors.grey.shade300,
                      ),
                      8.width,
                      Text(
                        "Feels Like",
                        style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xffFDFDFC)),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.grey.shade200.withOpacity(0.5),
                  ),
                  8.height,
                  Text(
                    "${weatherDataModel!.current.feelslikeC.toString()}°",
                    style: GoogleFonts.nunito(
                        fontSize: 28,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xffFDFDFC)),
                  ),
                  Text(
                    weatherDataModel!.current.feelslikeC >
                            weatherDataModel!.current.tempC
                        ? "It feels warmer than the actual temperature"
                        : weatherDataModel!.current.feelslikeC <
                                weatherDataModel!.current.tempC
                            ? "It feels colder than the actual temperature"
                            : "It feels same as the actual temperature",
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.shade400),
                  ).expand(),
                ],
              ),
            ),
          ).expand(),
          16.width,
          Blur(
            blur: 10,
            child: Container(
              decoration: boxDecorationWithRoundedCorners(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.2),
                  ])),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.sunny,
                        color: Colors.grey.shade300,
                      ),
                      8.width,
                      Text(
                        "UV Index",
                        style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xffFDFDFC)),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.grey.shade200.withOpacity(0.5),
                  ),
                  8.height,
                  Text(
                    weatherDataModel!.current.uv.toString(),
                    style: GoogleFonts.nunito(
                        fontSize: 28,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xffFDFDFC)),
                  ),
                  Text(
                    getUVIndexDescription(
                        (double.tryParse(weatherDataModel!.current.uv) ?? 0.0)
                            .ceil()),
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.shade400),
                  ),
                ],
              ),
            ),
          ).expand(),
        ],
      ),
    );
  }

  buildWindInfoView() {
    return Blur(
      blur: 10,
      child: Container(
        decoration: boxDecorationWithRoundedCorners(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(colors: [
              Colors.white.withOpacity(0.3),
              Colors.white.withOpacity(0.2),
            ])),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.air,
                  color: Colors.grey.shade300,
                ),
                8.width,
                Text(
                  "Wind",
                  style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffFDFDFC)),
                ),
              ],
            ),
            Divider(
              thickness: 1.5,
              color: Colors.grey.shade200.withOpacity(0.5),
            ),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Wind",
                  style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Text(
                  "${weatherDataModel!.current.windKph} kph",
                  style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade400),
                ),
              ],
            ),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Gusts",
                  style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Text(
                  "${weatherDataModel!.current.gustKph} kph",
                  style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade400),
                ),
              ],
            ),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Direction",
                  style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Text(
                  "${weatherDataModel!.current.windDegree} ${weatherDataModel!.current.windDir}",
                  style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildWeatherView(Size size) {
    return SafeArea(
      child: ListView(
        children: [
          buildCurrentView(size),
          40.height,
          buildHourlyView(),
          24.height,
          buildUpcomingForecast(size),
          16.height,
          buildSunriseSetView(),
          16.height,
          buildAirQualityView(),
          16.height,
          buildFeelsLikeAndUvView(),
          16.height,
          buildWindInfoView(),
        ],
      ).paddingAll(16),
    );
  }


  getAppBar() {
    return AppBar(
      leading: const Icon(
        Icons.search,
        size: 32,
        color: Color(0xffFDFDFC),
      ).onTap(() {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(bgImage: getBgImage(weatherDataModel!.current.condition.code,
            weatherDataModel!.current.isDay))));
      }),
      actions: [
        const Icon(Icons.menu, size: 32, color: Color(0xffFDFDFC))
            .paddingRight(16)
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
