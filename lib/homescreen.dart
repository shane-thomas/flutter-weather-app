// ignore_for_file: prefer_const_constructors

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';

const String link = 'https://api.openweathermap.org/data/2.5/weather?';

const String api = '7fc14329c3d424c38e3a26b97321f443';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool isLoaded = false;
  num temperature = 0;
  num pressure = 0;
  num humidity = 0;
  num cover = 0;
  String city = '';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              // ignore: prefer_const_literals_to_create_immutables
              colors: [Color(0xff0093E9), Color(0xff80D0C7)],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Visibility(
            visible: isLoaded,
            replacement: Center(
              child: CircularProgressIndicator(),
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.06,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Center(
                    child: TextFormField(
                      onFieldSubmitted: (String s) {
                        setState(() {
                          city = s;
                          getCityWeather(city);
                          isLoaded = false;
                        });
                      },
                      controller: controller,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        // fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search city',
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          size: 30,
                          color: Colors.white.withOpacity(.5),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.pin_drop_outlined,
                        color: Color(0xff8B0000),
                        size: 40,
                      ),
                      Text(
                        city,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 29,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.12,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage('images/thermo.jpeg'),
                        height: MediaQuery.of(context).size.height * 0.075,
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Temperature: ${temperature.toStringAsFixed(2)} ºC',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),

                ///////////////////////////////

                Container(
                  //barometer
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.12,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage('images/baro.jpeg'),
                        height: MediaQuery.of(context).size.height * 0.075,
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Pressure: $pressure hpa',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  //barometer
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.12,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage('images/hum.jpeg'),
                        height: MediaQuery.of(context).size.height * 0.075,
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Humidity: $humidity%',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),

                ////////////////////////////////

                Container(
                  //barometer
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.12,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage('images/cc.jpeg'),
                        height: MediaQuery.of(context).size.height * 0.075,
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Cloud Cover: $cover%',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getCurrentLocation() async {
    var p = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        forceAndroidLocationManager: true);

    // ignore: unnecessary_null_comparison
    if (p != null) {
      // print('Lat: ${p.latitude}, Long: ${p.longitude}');
      getCurrentCityWeather(p);
    } else {
      ("Data unavailable");
    }
  }

  getCityWeather(String city) async {
    var client = http.Client();
    var uri = '${link}q=$city&appid=$api';
    // var uri for vellore = 'https://api.openweathermap.org/data/2.5/weather?lat=12.97&lon=79.16&appid=7fc14329c3d424c38e3a26b97321f443';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = json.decode(data);
      //print(data);
      updateUI(decodedData);
      setState(() {
        isLoaded = true;
      });
    } else {
      // ignore: avoid_print
      print(response.statusCode);
    }
  }

  getCurrentCityWeather(Position position) async {
    var client = http.Client();
    var uri =
        '${link}lat=${position.latitude}&lon=${position.longitude}&appid=$api';

    //vellore
    // var uri = 'https://api.openweathermap.org/data/2.5/weather?lat=12.97&lon=79.16&appid=7fc14329c3d424c38e3a26b97321f443';

    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = json.decode(data);
      //print(data);
      updateUI(decodedData);
      setState(() {
        isLoaded = true;
      });
    } else {
      // ignore: avoid_print
      print(response.statusCode);
    }
  }

  updateUI(var decodedData) {
    setState(() {
      if (decodedData == null) {
        temperature = 0;
        pressure = 0;
        humidity = 0;
        cover = 0;
        city = 'Not available';
      } else {
        temperature = decodedData['main']['temp'] - 273;
        pressure = decodedData['main']['pressure'];
        humidity = decodedData['main']['humidity'];
        cover = decodedData['clouds']['all'];
        city = decodedData['name'];
      }
    });
  }
}
