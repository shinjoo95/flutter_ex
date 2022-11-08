import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'calculator',
      home: WidgetApp(),
    );
  }
}
class WidgetApp extends StatefulWidget {
  const WidgetApp({super.key});

  @override
  State<WidgetApp> createState() => _WidgetAppState();
}

class _WidgetAppState extends State<WidgetApp> {

  //텍스트필드를 다루려면 TextEditingController를 설정해야함
  String sum = '';
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();

  //드롭다운에 들어갈 리스트
  final List _buttonList = ['더하기', '빼기', '곱하기', '나누기'];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = List.empty(growable: true);
  String? _buttonText;

  @override
  void initState() {
    super.initState();
    for(var item in _buttonList){
      _dropDownMenuItems.add(DropdownMenuItem(value: (item), child: Text(item)));
    }
    _buttonText = _dropDownMenuItems[0].value;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('계산기'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 15),
                  child: Text('결과           $sum',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),textAlign: TextAlign.center,),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, right: 25, bottom: 10),
                child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                    ),
                    autofocus: true,
                    style: TextStyle(color: Colors.black87,fontSize: 18),
                    cursorColor: Colors.black38,
                    keyboardType: TextInputType.number, controller: value1),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, right: 25, bottom: 10),
                child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                    ),
                    autofocus: true,
                    style: TextStyle(color: Colors.black87,fontSize: 18),
                    cursorColor: Colors.black38,
                    keyboardType: TextInputType.number, controller: value2),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey)),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                    Text('  $_buttonText'),
                    Icon(Icons.arrow_circle_right_outlined),
                  ],
                ),
                  onPressed: (){
                    setState(() {
                      var value1Int = double.parse(value1.value.text);
                      var value2Int = double.parse(value2.value.text);
                      var result;
                      if(_buttonText == '더하기'){
                        result = value1Int + value2Int;
                      }else if(_buttonText == '빼기'){
                        result = value1Int - value2Int;
                      }else if(_buttonText == '곱하기'){
                        result = value1Int * value2Int;
                      }else{
                        result = value1Int / value2Int;
                      }
                      sum = '$result';
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: DropdownButton(items: _dropDownMenuItems, onChanged: (String? value){
                  setState(() {
                    _buttonText = value;
                  });
                }, value: _buttonText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

