import 'package:flutter/material.dart';

final borderRadius = 10.0;

const kCityTextStyle = TextStyle(
  fontFamily: 'Lato',
  fontSize: 35,
  fontWeight: FontWeight.bold,
);

const kDateAndTimeTextStyle = TextStyle(
  fontFamily: 'Lato',
  fontSize: 20,
);

const kTempTextStyle = TextStyle(
  fontFamily: 'Lato',
  fontSize: 80,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Lato',
  fontSize: 35.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Lato',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

//const doesn't work with outline input border
InputDecoration kTextFieldInputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.grey,
    icon: Icon(
      Icons.location_city,
      color: Colors.white,
    ),
    hintText: 'Enter city name',
    hintStyle: TextStyle(
      color: Colors.black,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(borderRadius),
    ));
