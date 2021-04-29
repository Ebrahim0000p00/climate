import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.location_city,
                    color: Colors.white,
                  ),
                  hintText: 'enter city name',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  setState(() {
                    cityName = value;
                  });
                },
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: null,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(cityName);
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
