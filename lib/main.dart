import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';

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

  addData(a){
    setState(() {
      data.add(a);
    });
  }

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
          IconButton(icon: Icon(Icons.add_box_outlined, color: Colors.black),
            onPressed: (){
              Navigator.push(context, 
                MaterialPageRoute(builder: (c) => Upload()));
          },),
          IconButton(icon: Icon(Icons.favorite_border, color: Colors.black), onPressed: null),
          IconButton(icon: Icon(Icons.send, color: Colors.black ), onPressed: null)
        ],
        actionsIconTheme: IconThemeData(color: Colors.black38, size: 30.0),
      ),
      body:
        [Home(data : data, addData : addData), Text('샵')][tab],

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
class Home extends StatefulWidget {
  const Home({Key? key, this.data, this.addData}) : super(key: key);
  final data;
  final addData;

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {

  var scroll = ScrollController();

  getMore() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
    var result2 = jsonDecode(result.body);
    widget.addData(result2);
  }

  @override
  void initState() {
    super.initState();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent){
        getMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(widget.data != null){
      return ListView.builder(itemCount: widget.data.length, controller: scroll, itemBuilder: (c,i){
        return Column(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 600),
              padding: EdgeInsets.all(5),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(widget.data[i]['image']),
                  Text('좋아요${widget.data[i]['likes']}'),
                  Text(widget.data[i]['user']),
                  Text(widget.data[i]['content']),
                  Text(widget.data[i]['date']),
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

class Upload extends StatelessWidget {
  const Upload({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('이미지업로드화면'),
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.close),)
        ],
      ),
    );
  }
}
