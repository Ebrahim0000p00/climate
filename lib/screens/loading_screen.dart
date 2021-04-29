import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  getLocation() async {
    var data = await WeatherModel().getWeatherData();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LocationScreen(data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SpinKitPouringHourglass(
      color: Colors.blue,
      size: 100,
    ));
  }
}
