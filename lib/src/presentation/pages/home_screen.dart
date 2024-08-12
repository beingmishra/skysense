import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skysense/main.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:skysense/src/data/models/weather_data_model.dart';
import 'package:skysense/src/presentation/bloc/weather_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showSearch = false;
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
      appBar: AppBar(
        leading: const Icon(
          Icons.search,
          size: 32,
          color: Color(0xffFDFDFC),
        ),
        actions: [
          const Icon(Icons.menu, size: 32, color: Color(0xffFDFDFC))
              .paddingRight(16)
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if(state is WeatherLoading){
            setState(() {
              isLoading = true;
            });
          }

          if(state is WeatherFailure){
            toastLong(state.error);
            setState(() {
              isLoading = false;
            });
          }

          if(state is WeathersDisplaySuccess){
            setState(() {
              isLoading = false;
              weatherDataModel = state.weatherData;
            });

          }
        },
        child: isLoading ? const Center(child: CircularProgressIndicator(
          color: Colors.black,
        ),) : weatherDataModel == null ? const SizedBox() : Stack(
          children: [
            Image.asset("assets/images/stormy.jpg",
              fit: BoxFit.cover,
              height: size.height,
              width: size.width,),
            Container(
              height: size.height,
              width: size.width,
              color: const Color(0xff20242E).withOpacity(0.5),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
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
                          Text(DateFormat("hh:mm a - EEEE, dd MMM yy").format(
                              DateTime.now()),
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
                              Image.network("https:${weatherDataModel!.current.condition.icon}"),
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
                                  Text("Wind", style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey.shade400),),
                                  16.height,
                                  Text(weatherDataModel!.current.windKph.toString(), style: GoogleFonts.nunito(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),),
                                  Text("km/h", style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),),
                                  12.height,
                                  const LinearProgressIndicator(
                                    color: Colors.green,
                                    value: 0.3,
                                    backgroundColor: textSecondaryColor,
                                  )
                                ],
                              ).expand(),
                              SizedBox(width: size.width * 0.15,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Rain", style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey.shade400),),
                                  16.height,
                                  Text((weatherDataModel!.current.chanceOfRain ?? 0).toString(), style: GoogleFonts.nunito(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),),
                                  Text("%", style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),),
                                  12.height,
                                  const LinearProgressIndicator(
                                    color: Colors.green,
                                    value: 0.75,
                                    backgroundColor: textSecondaryColor,
                                  )
                                ],
                              ).expand(),
                              SizedBox(width: size.width * 0.15,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Humidity", style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey.shade400),),
                                  16.height,
                                  Text((weatherDataModel!.current.humidity).toString(), style: GoogleFonts.nunito(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),),
                                  Text("%", style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),),
                                  12.height,
                                  const LinearProgressIndicator(
                                    color: Colors.redAccent,
                                    value: 0.9,
                                    backgroundColor: textSecondaryColor,
                                  )
                                ],
                              ).expand(),
                            ],
                          ),
                        ],
                      ).paddingAll(16),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _getCurrentAddress() async {
    var perms = await Geolocator.checkPermission();

    if(perms != LocationPermission.always && perms != LocationPermission.whileInUse){
      await Geolocator.requestPermission();
      _getCurrentAddress();
      return;
    }

    currentLocation ??= await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentLocation!.latitude, currentLocation!.longitude);
    if(placemarks.first.locality != null){
      print("calling bloc with ${placemarks.first.locality}");
      BlocProvider.of<WeatherBloc>(context)
          .add(GetWeatherEvent(locationName: placemarks.first.locality!));
    }else{
      toastLong("Unable to fetch location");
    }
  }
}

