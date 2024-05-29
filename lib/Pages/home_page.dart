// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/weather.dart';
import 'package:weather_forcast_app/Pages/Prediction.dart';
import 'package:weather_forcast_app/Widget/Bold_Text.dart';
import 'package:weather_forcast_app/Widget/myTextField.dart';
import 'package:weather_forcast_app/Widget/only_text.dart';
import 'package:weather_forcast_app/const_key.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? w;
  String location = 'Hyderabad';
  List<Weather> forecast = [];
  List<Weather> BeforeSearch = [];
  bool result = false;

  @override
  void initState() {
    super.initState();
    getValue();
    wf.currentWeatherByCityName(location).then((value) {
      setState(() {
        w = value;
      });
    });
    wf.fiveDayForecastByCityName(location).then((value) {
      setState(() {
        forecast = value;
      });
    });
  }

  var searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Center(child: BoldText('Weather Forcast App', Colors.white, 20)),
        backgroundColor: Colors.grey[500],
      ),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: myTextField(
                        'Search', searchcontroller, TextInputType.name),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 70,
                    width: 100,
                    child: ElevatedButton(
                        onPressed: () async {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setString(
                              'location', searchcontroller.text.toString());
                          getValue();
                          searchcontroller.clear();
                          wf.currentWeatherByCityName(location).then((value) {
                            setState(() {
                              w = value;
                            });
                          });
                          wf.fiveDayForecastByCityName(location).then((value) {
                            setState(() {
                              forecast = value;
                            });
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFBDBDBD)!),
                        ),
                        child: BoldText('Find', Color(0xFFFFFFFF), 18)),
                  )
                ],
              ),
              w == null
                  ? const Expanded(
                      child: Center(child: CircularProgressIndicator()))
                  : Column(
                      children: [
                        const SizedBox(height: 20),
                        _MainContainer(context),
                        const SizedBox(height: 10),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: BoldText('Prediction', Colors.black, 30)),
                        const SizedBox(height: 10),
                        Prediction(forecast: forecast),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void getValue() async {
    var prefs = await SharedPreferences.getInstance();

    var getlocation = prefs.getString('location');

    setState(() {
      location = getlocation!;
    });
  }

  Container _MainContainer(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 370,
      decoration: BoxDecoration(
          color: Colors.grey[500], borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: BoldText(location, Colors.white, 20),
            ),
            _dateTimeinfo(),
            _wetherIcon(),
            _celsiusandtype(),
          ],
        ),
      ),
    );
  }

  Column _celsiusandtype() {
    return Column(
      children: [
        Row(
          children: [
            BoldText('${w!.temperature!.celsius!.toStringAsFixed(0)}°',
                Colors.white, 40),
            BoldText('C', Colors.yellow, 40),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: BoldText(w!.weatherDescription.toString(), Colors.white, 25),
        ),
      ],
    );
  }

  Container _wetherIcon() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://openweathermap.org/img/wn/${w!.weatherIcon}@4x.png",
                  scale: 1))),
    );
  }

  Widget _dateTimeinfo() {
    DateTime now = w!.date!;
    return Row(
      children: [
        onlyText('${DateFormat('EEEE').format(now)} , ', Colors.white, 15),
        onlyText(DateFormat('h:mm a').format(now).toString(), Colors.white, 15),
      ],
    );
  }
}
