import 'package:flutter/material.dart';

class SecondDetail extends StatefulWidget {
  const SecondDetail({Key? key}) : super(key: key);

  @override
  State<SecondDetail> createState() => _SecondDetail();
}

class _SecondDetail extends State<SecondDetail> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('할일 추가하기'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
            TextField(
              controller: controller,
              keyboardType : TextInputType.text,
            ),
            ElevatedButton(style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey),
              onPressed: (){
                Navigator.of(context).pop(controller.value.text);
              },child: Text('저장하기'),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
