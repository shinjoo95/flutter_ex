import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HttpApp(),
    );
  }
}
class HttpApp extends StatefulWidget {
  const HttpApp({super.key});


  @override
  State<StatefulWidget> createState() => _HttpApp();
}

class _HttpApp extends State<HttpApp> {
  String result = '';
  List? data;
  TextEditingController? _editingController;
  ScrollController? _scrollController;
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = List.empty(growable: true);
    _editingController = TextEditingController();
    _scrollController = ScrollController();

    _scrollController!.addListener(() {
      if(_scrollController!.offset >= _scrollController!.position.maxScrollExtent &&
          !_scrollController!.position.outOfRange){
        print('bottom');
        page++;
        getJSONData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: TextField(
          controller: _editingController,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: '검색어를 입력하세요'),
        ),
      ),
      body: Container(
        child: Center(
          child: data!.length == 0
              ? Text('검색해주세용', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,)
          :ListView.builder(itemBuilder: (context, index){
            return Card(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.network(
                      data![index]['thumbnail'],
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width - 150,
                          child: Text(
                            data![index]['title'].toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text('저자 : ${data![index]['authors'].toString()}'),
                        Text('가격 : ${data![index]['sale_price'].toString()}원'),
                        Text('재고 : ${data![index]['status'].toString()}'),
                      ],
                    )
                  ],
                ),
              ),
            );
          }, itemCount: data!.length, controller: _scrollController,
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {
          page = 1;
          data!.clear();
          getJSONData();
        }, child:  Icon(Icons.file_download, ),
      ),
    );
  }
  //데이터 불러오기
  Future<String> getJSONData() async{
    var url = 'http://dapi.kakao.com/v3/search/book?'
              'target=title&page=$page&query=${_editingController!.value.text}';
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "KakaoAK f896b1789f778fbaafe9512c75bdb7c5"});
    setState(() {
      var dataCovertedtoJSON = json.decode(response.body);
      List result = dataCovertedtoJSON['documents'];
      data!.addAll(result);
    });
    return "Sucessfull";
  }
}
