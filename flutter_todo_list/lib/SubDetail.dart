import 'package:flutter/material.dart';

class SubDetail extends StatefulWidget {
  const SubDetail({Key? key}) : super(key: key);

  @override
  State<SubDetail> createState() => _SubDetail();
}

class _SubDetail extends State<SubDetail> {
  List<String> todoList = List.empty(growable: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoList.add('주봉이 목욕시키기');
    todoList.add('밥먹기');
    todoList.add('산책 시키기');
    todoList.add('방 청소하기');
    todoList.add('헬스장 가기');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Todo List'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return SizedBox(
          height: 50,
          child: Card(
            child: InkWell(
              child: Text(
                todoList[index], style: TextStyle(fontSize: 25,),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(
                    '/third', arguments: todoList[index]);
              },
            ),
          ),
        );
      },itemCount: todoList.length,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: (){
          _addNavigation(context);
        }, child: Icon(Icons.add),
      ),
    );
  }
  void _addNavigation(BuildContext context) async{
    final result = await Navigator.of(context).pushNamed('/second');
    setState(() {
      todoList.add(result as String);
    });
  }
}
