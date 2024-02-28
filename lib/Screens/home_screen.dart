import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/Screens/login_screen.dart';
import 'package:weather_app/Screens/search_screen.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:weather_app/const.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather;
  String city = "Delhi", weather_description = "";
  var temperature, wind_speed, humidity;
  String? weatherIconUrl;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    try {
      _weather = await _wf.currentWeatherByCityName(city);
      setState(() {
        city = _weather?.areaName ?? "";
        weather_description = _weather?.weatherDescription ?? "";
        temperature = _weather?.temperature?.celsius?.toStringAsFixed(0) ?? "";
        wind_speed = _weather?.windSpeed ?? "";
        humidity = _weather?.humidity ?? "";
        weatherIconUrl = _weather?.weatherIcon ?? "";
      });
    } catch (error) {
      Utils().toastMessage("City is not valid");
    }
  }

  void _navigateToSearchScreen() async {
    final cityName = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => SearchScreen(onSearch: handleSearch)),
    );
    if (cityName != null) {
      city = cityName;
      fetchWeatherData();
    }
  }

  void handleSearch(String cityName) {
    setState(() {
      city = cityName;
    });
    fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212F3C),
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Color(0xff212F3C),
          color: Color(0xff2E4053),
          animationDuration: Duration(milliseconds: 300),
          height: 50,
          onTap: (index) async {
            if (index == 0) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
            } else if (index == 1) {
              _navigateToSearchScreen();
            } else {
              await FirebaseAuth.instance.signOut();
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            }
          },
          items: [
            Icon(Icons.home, color: Colors.orange),
            Icon(Icons.search, color: Colors.orange),
            Icon(Icons.logout, color: Colors.orange),
          ]),
      appBar: AppBar(
        backgroundColor: Color(0xff212F3C),
        title: Text("Weather", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 30)),
        centerTitle: true,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Color(0xff2E4053),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(width: 30),
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: (weatherIconUrl != null)
                              ? Image.network(
                            "http://openweathermap.org/img/wn/${weatherIconUrl}.png",
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                            color: Colors.orange,
                          )
                              : Icon(Icons.error, size: 75),
                        ),
                        SizedBox(width: 50),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("$weather_description", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 18)),
                            Text("$city", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 18))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 255,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xff2E4053),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.thermostat, size: 40, color: Colors.orange),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("$temperature", style: TextStyle(color: Colors.orange, fontSize: 100, fontWeight: FontWeight.bold)),
                            Text("°C", style: TextStyle(color: Colors.orange, fontSize: 50, fontWeight: FontWeight.bold))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xff2E4053)),
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.air, color: Colors.orange),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("$wind_speed", style: TextStyle(color: Colors.orange, fontSize: 60, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("m/s", style: TextStyle(color: Colors.orange, fontSize: 16, fontWeight: FontWeight.bold)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xff2E4053)),
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.water_drop, color: Colors.orange),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("$humidity", style: TextStyle(color: Colors.orange, fontSize: 60, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Percent", style: TextStyle(color: Colors.orange, fontSize: 16, fontWeight: FontWeight.bold)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
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
}
