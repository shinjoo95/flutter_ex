import 'package:flutter/material.dart';
import '../animalItem.dart';

class SecondApp extends StatelessWidget {
  final List<Animal>? list;
  const SecondApp({super.key, this.list});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('두번째 페이지'),
        ),
      ),
    );
  }
}