import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sjop_app/search%20country.dart';

class Weather extends StatefulWidget {
  final String? value;

  const Weather({this.value});

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
    GlobalKey<FormState> form = GlobalKey();

  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  var country;
  var timezone;
  int _selectedIndex = 0;

    void _onTappedBar(int valu) {
      setState(() {
        _selectedIndex = valu;
      });

      if(_selectedIndex==0){Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Search()),
      );} else if (_selectedIndex==1){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Weather(value:widget.value,))
          ,
        );
      }
    }

  Future getWeather() async {

      var url = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=${widget.value}&&units=metric&appid=38d7c7247f1c9fac385bcd950cadd2f4");
      http.Response re = await http.get(url);
      var res = json.decode(re.body);
      setState(() {
        this.temp = res['main']['temp'];
        this.description = res['weather'][0]['description'];
        this.currently = res['weather'][0]['main'];
        this.humidity = res['main']['humidity'];
        this.windSpeed = res['wind']['speed'];
        this.country = res['name'];
        this.timezone = res['timezone'];
      });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(20),
             ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("image/unsplash.jpg"),fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                      country != null
                          ? "Currently in  " + country.toString()
                          : "???",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ),
                Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                      temp != null ? temp.toString() + "\u00B0" : "0",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w600)),
                )),
                Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                      currently != null ? currently.toString() : "???",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ))
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView(
                children: [
                  ListTile(
                    title: Text("Country"),
                    leading: FaIcon(FontAwesomeIcons.flag),
                    trailing: Text(country!=null?country.toString():"???"),
                  ),
                  ListTile(
                    title: Text("Temperature"),
                    leading: FaIcon(FontAwesomeIcons.thermometerFull),
                    trailing: Text(
                        temp != null ? temp.toString() + "\u00B0" : "0"),
                  ),
                  ListTile(
                    title: Text("Weather"),
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    trailing: Text(description != null
                        ? description.toString()
                        : "???"),
                  ),
                  ListTile(
                    title: Text("TemperaHumidity"),
                    leading: FaIcon(FontAwesomeIcons.sun),
                    trailing: Text(
                        humidity != null ? humidity.toString() : "0"),
                  ),
                  ListTile(
                    title: Text("Wind Speed"),
                    leading: FaIcon(FontAwesomeIcons.wind),
                    trailing: Text(
                        humidity != null ? humidity.toString() : "0"),
                  ),
                  ListTile(
                    title: Text("Time Zone"),
                    leading: FaIcon(FontAwesomeIcons.flag),
                    trailing: Text(
                        timezone != null ? timezone.toString() : "0"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),bottomNavigationBar: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.search), title: Text('Search')),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.cloud), title: Text('Weather')),

      ],
      unselectedItemColor: Colors.blue,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,    currentIndex: _selectedIndex,    onTap: _onTappedBar,


    ),

    );
  }
}
