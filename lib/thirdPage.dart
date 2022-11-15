import 'package:flutter/material.dart';

class ThirdDetail extends StatelessWidget {
  const ThirdDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('오늘의 할일'),
      ),
      body: Container(
        child: Center(
          child: Text(args, style: TextStyle(fontSize: 30),)
        ),
      ),
    );
  }
}
