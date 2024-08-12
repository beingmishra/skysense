import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skysense/di.dart';
import 'package:skysense/src/presentation/bloc/weather_bloc.dart';
import 'package:skysense/src/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Position? currentLocation;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  LocationPermission permissionStatus = await Geolocator.checkPermission();
  if (permissionStatus != LocationPermission.always || permissionStatus != LocationPermission.whileInUse) {
    await Geolocator.requestPermission();
  }

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => serviceLocator<WeatherBloc>(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

    Geolocator.getPositionStream().listen((Position position) {
      currentLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const HomeScreen(),
    );
  }
}
