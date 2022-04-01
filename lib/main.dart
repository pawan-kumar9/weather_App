//ignore_for_file: prefer_const_constructors,unnecessary_new,unnecessary_import
import 'dart:convert';
import 'dart:ui';

import 'package:weather_app/forecast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String loc = "Delhi";

  Map mapResponse = {};
  Map dataResponse = {};
  Map currentResponse = {};
  Map conditionResponse = {};
  Future apicall(String val1) async {
    String url =
        "http://api.weatherapi.com/v1/current.json?key=5a9ad6ebbc2846b6aec154836221101&q=$loc&aqi=no";
    http.Response response;
    response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        dataResponse = mapResponse['location'];
        currentResponse = mapResponse['current'];
        conditionResponse = currentResponse['condition'];
      });
    }
  }

  @override
  void initState() {
    apicall(loc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/Sunsetting.jpg"))),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    height: 800,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/walls.jpg"))),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 70,
                          ),
                          TextField(
                            controller: myController,
                            decoration: InputDecoration(
                                hintText: "Enter you City",
                                fillColor: Colors.white,
                                filled: true,
                                suffixIcon: Icon(Icons.search),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )),
                            cursorHeight: 30.0,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            dataResponse['name'].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 60.0),
                          ),
                          Text(
                            dataResponse['region'].toString() +
                                ", " +
                                dataResponse['country'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            dataResponse['localtime'].toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            currentResponse['temp_c'].toString() + " °C",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 50.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(conditionResponse['text'].toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  fontStyle: FontStyle.italic)),
                          Image.network(
                            "https:" + conditionResponse['icon'],
                            width: 100,
                            height: 100,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              loc = myController.text;
                              apicall(loc);
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: Text("Get Weather Report"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WeatherForecast(
                                            location: loc,
                                          )));
                            },
                            child: Text("Get Weather Forecast"),
                          ),
                        ],
                      ),
                    ),
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
