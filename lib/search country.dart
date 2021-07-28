import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sjop_app/weather.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final form = GlobalKey<FormState>();
Color color=Colors.white;
  String? value;
  int _selectedIndex = 0;

  void _onTappedBar(int valu) {
    setState(() {
      _selectedIndex = valu;
    });
    if (_selectedIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Search()),
      );
    } else if (_selectedIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Weather(value: value)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("image/3075993.jpg"), fit: BoxFit.fill)),
          ),
          Center(
            child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Form(
                  key: form,
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        labelText: "Search",
                        labelStyle: TextStyle(color: Colors.blue),
                        hintText: "Search City ",
                        hintStyle: TextStyle(color: Colors.red),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 1.7),
                            borderRadius: BorderRadius.circular(20))),
                    validator: (String? val) {
                      return val!.isEmpty ? 'please enter the country' : null;
                    },
                    onSaved: (String? val) {
                      this.value = val;
                    },
                  ),
                )),
          ),
          Positioned(
              bottom: MediaQuery.of(context).size.height * 0.5 - 100,
              left: MediaQuery.of(context).size.width * 0.46,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              if (form.currentState!.validate()) {
                                form.currentState!.save();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Weather(
                                            value: value,
                                          )),
                                );
                              }
                            },
                            icon: Icon(
                              Icons.search_sharp,
                              color: Colors.white,
                            ),
                          ),
                        ))
                  ])),
          Positioned(
              left: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.15,
              right:  MediaQuery.of(context).size.width * 0.1,
              child: DefaultTextStyle(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold
                ),
                child: AnimatedTextKit(
                  onFinished: (){

                  },
                  animatedTexts: [
                    WavyAnimatedText('You are Welcome'),
                    WavyAnimatedText('Weather World'),
                  ],
                  isRepeatingAnimation: true,

                ),
              ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.search), title: Text('search')),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.cloud), title: Text('weather')),
        ],
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.blue,
        currentIndex: _selectedIndex,
        onTap: _onTappedBar,
      ),
    );
  }
}
