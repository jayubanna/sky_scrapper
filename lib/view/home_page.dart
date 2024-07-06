import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_scrapper/controller/api_helper.dart';
import 'package:sky_scrapper/model/weather_model.dart';

import '../controller/home_provider.dart';
import '../controller/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final ApiService _apiService = ApiService();
  WeatherData? _weatherData;
  bool _isConnected = true;
  bool isvisible = true;
  ConnectivityResult con = ConnectivityResult.none;
  Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).checkingConnection();
    _searchWeather('Rajkot');
  }

  void checkCurrentConnection() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            result != ConnectivityResult.none ? "Connected" : "No Connection"),
        backgroundColor:
            result != ConnectivityResult.none ? Colors.green : Colors.red,
      ),
    );
  }

  void _searchWeather(String cityName) async {
    if (_isConnected) {
      var data = await _apiService.fetchWeather(cityName);
      setState(() {
        _weatherData = data;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No internet connection')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: "Enter city name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            _searchWeather(value);
                            _controller.clear();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a city name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Consumer<ThemeProvider>(
                        builder: (context, themeProvider, child) {
                          return IconButton(
                            icon: Icon(
                              themeProvider.isDarkMode
                                  ? Icons.light_mode_outlined
                                  : Icons.dark_mode_outlined,
                            ),
                            onPressed: () {
                              themeProvider.toggleTheme();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _weatherData != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                _weatherData!.name ?? '',
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: Text(
                                'Clouds',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${_weatherData!.temperature.current.toStringAsFixed(2)}°',
                              style: TextStyle(fontSize: 80),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildWeatherInfo(
                                  Icons.wind_power,
                                  '${_weatherData!.wind.speed.toStringAsFixed(2)} km/h',
                                ),
                                _buildWeatherInfo(
                                  Icons.water_drop,
                                  '${_weatherData!.humidity.toString()} %',
                                ),
                                _buildWeatherInfo(
                                  Icons.sunny_snowing,
                                  '${_weatherData!.minTemperature.toStringAsFixed(2)} °C',
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildWeatherInfo(
                                  Icons.sunny,
                                  '${_weatherData!.maxTemperature.toStringAsFixed(2)} °C',
                                ),
                                _buildWeatherInfo(
                                  Icons.air,
                                  '${_weatherData!.pressure} hPa',
                                ),
                                _buildWeatherInfo(
                                  Icons.leaderboard,
                                  '${_weatherData!.seaLevel}m',
                                ),
                              ],
                            ),
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 148,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.lightBlueAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildHourlyForecast('09 AM', '23°', Icons.wb_cloudy),
                    _buildHourlyForecast('10 AM', '18°', Icons.beach_access),
                    _buildHourlyForecast('11 AM', '20°', Icons.cloud_queue),
                    _buildHourlyForecast('12 PM', '22°', Icons.wb_sunny),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Visibility(
        visible: isvisible,
        child: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return SizedBox();
            }

            bool isConnection = snapshot.data != ConnectivityResult.none;
            if (isConnection) {
              if (con != snapshot.data) {
                Future.delayed(
                  Duration(seconds: 1),
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Connection"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                );
              }
              con = snapshot.data!;
              return SizedBox();
            } else {
              if (con != snapshot.data) {
                Future.delayed(
                  Duration(seconds: 1),
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("No Connection"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                );
              }
              con = snapshot.data!;
              return SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(IconData icon, String text) {
    return Column(
      children: [
        Icon(
          icon,
        ),
        SizedBox(height: 5),
        Text(text),
      ],
    );
  }

  Widget _buildHourlyForecast(String time, String temp, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Text(time,
              style: TextStyle(
                color: Colors.white,
              )),
          SizedBox(height: 10),
          Icon(icon, color: Colors.white),
          SizedBox(height: 10),
          Text(temp, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
