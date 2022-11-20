import 'package:flutter/material.dart';
import 'people.dart';
import 'secondPage.dart';
import 'intro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroPage(),
    );
  }
}

class AnimationApp extends StatefulWidget {
  const AnimationApp({Key? key}) : super(key: key);

  @override
  State<AnimationApp> createState() => _AnimationAppState();
}

class _AnimationAppState extends State<AnimationApp> {
  List<People> peoples = List.empty(growable: true);
  int current = 0;
  Color weightColor = Colors.blue;
  double _opacity = 1;

  @override
  void initState() {
    peoples.add(People('신주용', 173, 70));
    peoples.add(People('윤채린', 200, 50));
    peoples.add(People('신주봉', 80, 60));
    peoples.add(People('김기원', 190, 60));
    peoples.add(People('이형욱', 160, 80));
    peoples.add(People('채민호', 140, 90));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 1),
                child: SizedBox(
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                          width: 100,
                          child: Text('이름 : ${peoples[current].name}')),
                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        curve: Curves.bounceIn,
                        color: Colors.amber,
                        width: 50,
                        height: peoples[current].height,
                        child: Text('키 ${peoples[current].height}',
                            textAlign: TextAlign.center),
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        curve: Curves.easeInCubic,
                        color: weightColor,
                        width: 50,
                        height: peoples[current].weight,
                        child: Text('몸무게 : ${peoples[current].weight}',
                            textAlign: TextAlign.center),
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        curve: Curves.linear,
                        color: Colors.pinkAccent,
                        width: 50,
                        height: peoples[current].bmi,
                        child: Text(
                            'bmi : ${peoples[current].bmi.toString().substring(0, 2)}',
                            textAlign: TextAlign.center),
                      )
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (current < peoples.length - 1) {
                        current++;
                        _changeWeightColor(peoples[current].weight);
                      }
                    });
                  },
                  child: Text('다음')),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (current > 0) {
                        current--;
                        _changeWeightColor(peoples[current].weight);
                      }
                    });
                  },
                  child: Text('이전')),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _opacity == 1 ? _opacity = 0 : _opacity = 1;
                    });
                  },
                  child: Text('불투명도')),
              ElevatedButton(
                  onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondPage()));
                  },
                  child: SizedBox(
                    width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Hero(tag: 'detail', child: Icon(Icons.account_circle_outlined)),
                          Text('  이동하기')
                        ],
                      ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeWeightColor(double weight) {
    if (weight < 40) {
      weightColor = Colors.blueAccent;
    } else if (weight < 60) {
      weightColor = Colors.indigo;
    } else if (weight < 80) {
      weightColor = Colors.orange;
    } else {
      weightColor = Colors.red;
    }
  }
}
