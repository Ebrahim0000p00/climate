import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final recievedData;
  LocationScreen(this.recievedData);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int tempreture;
  String weatherIcon;
  String cityName;
  String weatherMessage;

  @override
  void initState() {
    super.initState();
    updateUI(widget.recievedData);
  }

  void updateUI(data) {
    setState(() {
      if (data == null) {
        tempreture = 0;
        cityName = '';
        weatherMessage = 'error';
        weatherIcon = '';

        return;
      }
      print('$data ---------------------------------------------------');
      double temp = data['main']['temp'];
      tempreture = temp.toInt();
      cityName = data['name'];

      WeatherModel weatherModel = WeatherModel();
      weatherMessage = weatherModel.getMessage(tempreture);

      int condition = widget.recievedData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await WeatherModel().getWeatherData();

                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      String nameTyped = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));
                      var weatherData =
                          await WeatherModel().getCityWeather(nameTyped);
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '$tempreture°',
                        style: kTempTextStyle,
                      ),
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "$weatherMessage in $cityName!",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
