//Shane Shaji Thomas 22BCE3649
import 'package:flutter/material.dart';
import 'homescreen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Weather App',
    // ignore: prefer_const_constructors
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.green),
  ));
}
