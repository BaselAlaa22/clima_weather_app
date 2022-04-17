import 'dart:async';

import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  int weatherCondition;
  String city;
  String currentTime;
  String currentDate;
  String imageURL;
  String description;
  double windSpeed;
  int minTemperature;
  int maxTemperature;
  String icon;
  String backgroundImage;
  Timer timer;
  var typedName;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
    currentDate = DateFormat.yMMMMd().format(DateTime.now());
    currentTime = DateFormat.jm().format(DateTime.now());
    //A timer to update the time every one second
    timer = Timer.periodic(
        Duration(seconds: 1), (timer) => getCurrentDateAndTime());
  }

  @override
  void dispose() {
    super.dispose();
    //to dispose of the timer
    timer.cancel();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      var temp = weatherData['main']['temp'];
      var tempWindSpeed = weatherData['wind']['speed'];
      var tempMin = weatherData['main']['temp_min'];
      var tempMax = weatherData['main']['temp_max'];
      weatherCondition = weatherData['weather'][0]['id'];
      city = weatherData['name'];
      icon = weatherData["weather"][0]["icon"];
      imageURL = "http://openweathermap.org/img/w/" + icon + ".png";
      description = weatherData['weather'][0]['description'];
      backgroundImage =
          WeatherModel.getWeatherBackground(weatherCondition, icon);

      temperature = temp.toInt();
      windSpeed = tempWindSpeed.toDouble();
      minTemperature = tempMin.toInt();
      maxTemperature = tempMax.toInt();
    });
  }

  void getCurrentDateAndTime() {
    setState(() {
      currentTime = DateFormat.jm().format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () async {
            typedName = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CityScreen(),
                ));
            if (typedName != null) {
              var weatherData = await WeatherModel.getCityWeather(typedName);
              updateUI(weatherData);
            }
          },
          icon: Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                var weatherData = await WeatherModel.getLocationWeather();
                updateUI(weatherData);
              },
              icon: Icon(Icons.near_me))
        ],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.7), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Text(
                              city,
                              style: kCityTextStyle,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    currentTime + ' - ' + currentDate,
                                    style: kDateAndTimeTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Text(
                            '${temperature.toInt()}°C',
                            style: kTempTextStyle,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              imageURL,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              description,
                              style: kDateAndTimeTextStyle,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Divider(
                      color: Colors.white,
                      indent: 30,
                      endIndent: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SafeArea(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BottomColumn(
                              title: 'Wind',
                              value: windSpeed.toString(),
                              unit: 'km/h',
                            ),
                            BottomColumn(
                              title: 'High',
                              value: maxTemperature.toString(),
                              unit: 'Celsius',
                            ),
                            BottomColumn(
                              title: 'Low',
                              value: minTemperature.toString(),
                              unit: 'Celsius',
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomColumn extends StatelessWidget {
  final String title;
  final String value;
  final String unit;

  BottomColumn({this.title, this.value, this.unit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: kDateAndTimeTextStyle),
        Text(value, style: kDateAndTimeTextStyle),
        Text(unit, style: kDateAndTimeTextStyle),
      ],
    );
  }
}

/*
Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await WeatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
* */
