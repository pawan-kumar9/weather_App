//ignore_for_file: prefer_const_constructors,unnecessary_new,no_logic_in_create_state,avoid_unnecessary_containers,sized_box_for_whitespace
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherForecast extends StatefulWidget {
  final String? location;
  const WeatherForecast({Key? key, @required this.location}) : super(key: key);

  @override
  _WeatherForecastState createState() {
    return _WeatherForecastState(location);
  }
}

class _WeatherForecastState extends State<WeatherForecast> {
  String? location;
  _WeatherForecastState(this.location);
  Map mapResponse = {};
  Map forecastResponse = {};
  List forecastdayResponse = [];
  Map firstdayResponse = {};
  Map dayResponse = {};
  Map conditionResponse = {};
  Map astroResponse = {};
  List temperatureResponse = [];
  List hourResponse = [];
  List iconResponse = [];
  List timeResponse = [];

  Map firstdayResponse1 = {};
  Map dayResponse1 = {};
  Map conditionResponse1 = {};
  Map astroResponse1 = {};
  List temperatureResponse1 = [];
  List hourResponse1 = [];
  List iconResponse1 = [];
  List timeResponse1 = [];

  Map firstdayResponse2 = {};
  Map dayResponse2 = {};
  Map conditionResponse2 = {};
  Map astroResponse2 = {};
  List temperatureResponse2 = [];
  List hourResponse2 = [];
  List iconResponse2 = [];
  List timeResponse2 = [];

  Map firstdayResponse3 = {};
  Map dayResponse3 = {};
  Map conditionResponse3 = {};
  Map astroResponse3 = {};

  Future apicall(String val1) async {
    String url =
        "http://api.weatherapi.com/v1/forecast.json?key=5a9ad6ebbc2846b6aec154836221101&q=$location&days=10&aqi=no&alerts=no";
    http.Response response;
    response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        forecastResponse = mapResponse['forecast'];
        forecastdayResponse = forecastResponse['forecastday'];
        firstdayResponse = forecastdayResponse[0];
        dayResponse = firstdayResponse['day'];
        astroResponse = firstdayResponse['astro'];
        conditionResponse = dayResponse['condition'];
        hourResponse = firstdayResponse['hour'];
        for (var i = 0; i < hourResponse.length; i++) {
          Map tempResponse = hourResponse[i];
          String dateTime = tempResponse['time'].toString();
          List dateTimelist = dateTime.split(" ");
          timeResponse.add(dateTimelist[1].toString());
          Map tempCondition = tempResponse['condition'];
          iconResponse.add("http:" + tempCondition['icon'].toString());
          temperatureResponse.add(tempResponse['temp_c'].toString() + "°C");
        }
        firstdayResponse1 = forecastdayResponse[1];
        dayResponse1 = firstdayResponse1['day'];
        astroResponse1 = firstdayResponse1['astro'];
        conditionResponse1 = dayResponse1['condition'];
        hourResponse1 = firstdayResponse1['hour'];
        for (var i = 0; i < hourResponse1.length; i++) {
          Map tempResponse = hourResponse1[i];
          String dateTime = tempResponse['time'].toString();
          List dateTimelist = dateTime.split(" ");
          timeResponse1.add(dateTimelist[1].toString());
          Map tempCondition = tempResponse['condition'];
          iconResponse1.add("http:" + tempCondition['icon'].toString());
          temperatureResponse1.add(tempResponse['temp_c'].toString() + "°C");
        }

        firstdayResponse2 = forecastdayResponse[2];
        dayResponse2 = firstdayResponse2['day'];
        astroResponse2 = firstdayResponse2['astro'];
        conditionResponse2 = dayResponse2['condition'];
        hourResponse2 = firstdayResponse2['hour'];
        for (var i = 0; i < hourResponse2.length; i++) {
          Map tempResponse = hourResponse2[i];
          String dateTime = tempResponse['time'].toString();
          List dateTimelist = dateTime.split(" ");
          timeResponse2.add(dateTimelist[1].toString());
          Map tempCondition = tempResponse['condition'];
          iconResponse2.add("http:" + tempCondition['icon'].toString());
          temperatureResponse2.add(tempResponse['temp_c'].toString() + "°C");
        }
      });
    }
  }

  @override
  void initState() {
    apicall(location!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: (mapResponse.isEmpty)
          ? Center(child: CircularProgressIndicator.adaptive())
          : Container(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 70.0),
              decoration: BoxDecoration(
                // color: Colors.green.shade200,
                image: DecorationImage(
                    image: AssetImage("assets/walls2.jpg"),
                    fit: BoxFit.fitHeight),
              ),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(location!),
                  // Text(firstdayResponse['date'].toString()),
                  // Text(dayResponse['maxtemp_c'].toString()),
                  // Text(dayResponse['mintemp_c'].toString()),
                  // Text(conditionResponse['text'].toString()),
                  // Image.network("http:" + conditionResponse['icon']),
                  // Text(astroResponse['sunrise']),
                  // Text(astroResponse['sunset'])
                  cardWidget(
                      location!,
                      firstdayResponse['date'],
                      conditionResponse['text'],
                      "http:" + conditionResponse['icon'],
                      dayResponse['maxtemp_c'].toString(),
                      dayResponse['mintemp_c'].toString(),
                      temperatureResponse,
                      iconResponse,
                      timeResponse),
                  cardWidget(
                      location!,
                      firstdayResponse1['date'],
                      conditionResponse1['text'],
                      "http:" + conditionResponse1['icon'],
                      dayResponse1['maxtemp_c'].toString(),
                      dayResponse1['mintemp_c'].toString(),
                      temperatureResponse1,
                      iconResponse1,
                      timeResponse1),
                  cardWidget(
                      location!,
                      firstdayResponse2['date'],
                      conditionResponse2['text'],
                      "http:" + conditionResponse2['icon'],
                      dayResponse2['maxtemp_c'].toString(),
                      dayResponse['mintemp_c'].toString(),
                      temperatureResponse2,
                      iconResponse2,
                      timeResponse2),
                ],
              )),
            ),
    );
  }
}

Widget cardWidget(String location, String date, String desc, String url,
    String maxtemp, String mintemp, List list1, List list2, List list3) {
  return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
      width: 360,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(date), Text(desc)],
              ),
              Image(image: NetworkImage(url)),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text(maxtemp), Text(mintemp)],
              )
            ],
          ),
          Divider(
            color: Colors.black,
            thickness: 1.0,
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 24,
                itemBuilder: (context, int index) {
                  return ForecastTile(
                    temp: list1[index],
                    icon: list2[index],
                    time: list3[index],
                  );
                },
              ),
            ),
          ),
        ],
      ));
}

class ForecastTile extends StatelessWidget {
  final String? temp, icon, time;
  const ForecastTile(
      {Key? key, @required this.temp, @required this.icon, @required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      child: Column(
        children: [Text(temp!), Image.network(icon!), Text(time!)],
      ),
    );
  }
}
