import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
      theme: style.theme,
      home: MyApp()
    )
  );
}
var a = TextStyle();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;
  var data = [];

  getData() async{
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    var result2 = jsonDecode(result.body);
    data = result2;
  }
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          IconButton(icon: Icon(Icons.add_box_outlined, color: Colors.black), onPressed: null,),
          IconButton(icon: Icon(Icons.favorite_border, color: Colors.black), onPressed: null),
          IconButton(icon: Icon(Icons.send, color: Colors.black ), onPressed: null)
        ],
        actionsIconTheme: IconThemeData(color: Colors.black38, size: 30.0),
      ),
      body:
        [Home(data : data), Text('샵')][tab],

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i){
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'home',
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: 'shop',
            icon: Icon(Icons.shopping_bag_outlined),
            )
        ],
      ),
    );
  }
}

//home 페이지
class Home extends StatelessWidget {
  const Home({Key? key, this.data}) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    if(data != null){
      return ListView.builder(itemCount: 3, itemBuilder: (c,i){
        return Column(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 600),
              padding: EdgeInsets.all(5),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(data[i]['image']),
                  Text('좋아요${data[i]['likes']}'),
                  Text(data[i]['user']),
                  Text(data[i]['content']),
                  Text(data[i]['date']),
                ],
              ),
            )
          ],

        );
      });
    }else {
      return Text('로딩중임');
    }
    }
  }

