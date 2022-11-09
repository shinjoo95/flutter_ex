import 'package:flutter/material.dart';
import '../animalItem.dart';

class SecondApp extends StatefulWidget {
  final List<Animal>? list;
  SecondApp({super.key, this.list});

  @override
  State<SecondApp> createState() => _SecondAppState();
}



class _SecondAppState extends State<SecondApp> {
  final nameController = TextEditingController();
  int? _radioValue = 0;
  bool? flyExist = false;
  String? _imagepath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Radio(value: 0, groupValue: _radioValue, onChanged: _radioChange), Text('양서류'),
                  Radio(value: 1, groupValue: _radioValue, onChanged: _radioChange), Text('파충류'),
                  Radio(value: 2, groupValue: _radioValue, onChanged: _radioChange), Text('포유류'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('날 수 있나요?'),
                  Checkbox(value: flyExist, onChanged: (bool? check){
                    setState(() {
                      flyExist = check;
                    });
                  })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    child: Image.asset('repo/images/cow.png', width: 80),
                    onTap: (){_imagepath = 'repo/images/cow.png';},
                  ),
                  GestureDetector(
                    child: Image.asset('repo/images/pig.png', width: 80),
                    onTap: (){_imagepath = 'repo/images/pig.png';},
                  ),
                  GestureDetector(
                    child: Image.asset('repo/images/bee.png', width: 80),
                    onTap: (){_imagepath = 'repo/images/bee.png';},
                  ),
                  GestureDetector(
                    child: Image.asset('repo/images/cat.png', width: 80),
                    onTap: (){_imagepath = 'repo/images/cat.png';},
                  ),
                ],
              ),
              ElevatedButton(onPressed: (){}, child: Text('동물 추가하기'))
            ],
          )
        ),
      ),
    );
  }
  _radioChange(int? value){
    setState(() {
      _radioValue = value;
    });
  }
}