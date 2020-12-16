import 'package:eigital_app/weathermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherModel weather = WeatherModel();
  String temperature = '';
  String cityName = '';
  String weatherUrl = 'https://www.colorhexa.com/2e2e2e.png';
  String weatherBg = '2e2e2e';
  String typedCityName;
  String errorMsg = '';
  var msgController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await weather.getLocationWeather();
    setState(() {
      updateUI(weatherData);
    });
  }

  void getSearchData(String input) async {
    try {
      typedCityName = input.trim().toLowerCase();
      if (typedCityName != '') {
        var weatherData;
        weatherData = await weather.getCityWeather(typedCityName);
        setState(() {
          updateUI(weatherData);
        });
      }
    } catch (e) {
      setState(() {
        errorMsg = 'Sorry, we don\'t have data about this city.';
      });
    }
  }

  void updateUI(dynamic weatherData) {
    int condition = weatherData['weather'][0]['id'];
    double temp = weatherData['main']['temp'] - 273.1;
    cityName = weatherData['name'];
    temperature = temp.toStringAsFixed(1) + '°C';
    String weatherIcon = weather.getWeatherIcon(condition);
    weatherUrl =
        'https://www.metaweather.com/static/img/weather/png/64/$weatherIcon.png';
    weatherBg = weatherIcon;
    errorMsg = '';
    msgController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return temperature == ''
        ? Center(child: CircularProgressIndicator())
        : Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/$weatherBg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Center(
                        child: Image.network(weatherUrl),
                      ),
                      Center(
                        child: Text(
                          temperature,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(4.0, 2.0),
                                blurRadius: 5,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          cityName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(4.0, 2.0),
                                blurRadius: 5,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 20, left: 60, right: 60),
                          child: TextField(
                            controller: msgController,
                            onSubmitted: (String input) {
                              getSearchData(input);
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xF2e2e2e),
                              icon: Icon(Icons.location_city),
                              hintText: 'Enter City Name',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        errorMsg,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  getLocationData();
                },
                child: Icon(
                  Icons.near_me,
                  color: Color(0xFF2E2E2E),
                  size: 60,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          );
  }
}
