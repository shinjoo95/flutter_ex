import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:instagram/notification.dart';
import 'package:instagram/shop.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';




void main() async{

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (c) => Store1()),
      ChangeNotifierProvider(create: (c) => Store2()),
    ],
    child: MaterialApp(theme: style.theme, home: MyApp()),
  ));
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
  var userImage;
  var userContent;



  //데이터 저장 함수
  saveData() async {
    var storage = await SharedPreferences.getInstance();
    storage.setString('name', 'shin');
    var result = storage.get('name');
    storage.remove('name'); //삭제
    print(result);
  }

  addMyData() {
    var myData = {
      "id": data.length,
      "image": userImage,
      "likes": 150,
      "date": "Oct 28",
      "content": "신주봉",
      "liked": false,
      "user": "Joo Bong"
    };
    setState(() {
      data.insert(0, myData); //List 맨앞에 자료 추가하는 법
    });
  }

  setUserContent(a) {
    setState(() {
      userContent = a;
    });
  }

  addData(a) {
    setState(() {
      data.add(a);
    });
  }

  getData() async {
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    var result2 = jsonDecode(result.body);
    data = result2;
  }


  @override
  void initState() {
    super.initState();
    initNotification(context);
    IOSNotificationDetails();
    getData();
    context.read<Store1>().getData();
  }

  @override
  Widget build(BuildContext context) {
    
    MediaQuery.of(context).size.width;
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Text('+'), onPressed: (){
        showNotification2();
      },),
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined, color: Colors.black),
            onPressed: () async {
              var picker = ImagePicker();
              var image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                setState(() {
                  userImage = File(image.path); //image가 null 일 가능 성이 있어서 if문으로
                });
              }
              // ignore: use_build_context_synchronously
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => Upload(
                          userImage: userImage,
                          setUserContent: setUserContent,
                          addMyData: addMyData)));
            },
          ),
          IconButton(
              icon: Icon(Icons.favorite_border, color: Colors.black),
              onPressed: null),
          IconButton(
              icon: Icon(Icons.send, color: Colors.black), onPressed: null)
        ],
        actionsIconTheme: IconThemeData(color: Colors.black38, size: 30.0),
      ),
      body: [ Home(data: data, addData: addData), Shop()][tab],
        //MediaQuery.of(context).size.width >  600 ? HomeLarge() :
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i) {
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
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
    var result2 = jsonDecode(result.body);
    widget.addData(result2);
  }

  @override
  void initState() {
    super.initState();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        getMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data != null) {
      return ListView.builder(
          itemCount: widget.data.length,
          controller: scroll,
          itemBuilder: (c, i) {
            return Column(
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.data[i]['image'].runtimeType == String
                          ? Image.network(widget.data[i]['image'])
                          : Image.file(widget.data[i]['image']),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: GestureDetector(
                          child: Text(
                            widget.data[i]['user'],
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) => Profile(),
                                    transitionsBuilder: (c, a1, a2, child) =>
                                        SlideTransition(
                                          position: Tween(
                                            begin: Offset(1.0, 0.0),
                                            end: Offset(0.0, 0.0),
                                          ).animate(a1),
                                          child: child,
                                        )));
                          },
                        ),
                      ),
                      Text('좋아요${widget.data[i]['likes']}'),
                      Text(widget.data[i]['content']),
                      Text(widget.data[i]['date'],
                          style: TextStyle(fontSize: 10)),
                    ],
                  ),
                )
              ],
            );
          });
    } else {
      return Text('로딩중임');
    }
  }
}

class Upload extends StatelessWidget {
  const Upload({Key? key, this.userImage, this.setUserContent, this.addMyData})
      : super(key: key);
  final userImage;
  final setUserContent;
  final addMyData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              addMyData();
            },
            icon: Icon(Icons.send),
            color: Colors.black,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(userImage),
          Text('이미지업로드화면'),
          TextField(
            onChanged: (text) {
              setUserContent(text);
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          )
        ],
      ),
    );
  }
}

class Store1 extends ChangeNotifier {
  var follower = 350;
  var friend = false;
  var follow = '팔로우';
  var profileImage = [];

  getData() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    var result2 = jsonDecode(result.body);
    profileImage = result2;
    notifyListeners();

  }


  // var name = 'shinjoo';
  // changeName() {
  //   name = 'jooBong';
  //   notifyListeners();
  // }
  addFollower() {
    if (friend == false) {
      follower++;
      follow = '팔로우 취소';
      friend = true;
    } else {
      follower--;
      follow = '팔로우';
      friend = false;
    }
    notifyListeners();
  }
}



class Store2 extends ChangeNotifier {
  var name = 'joobong';
}


class Profile extends StatefulWidget {
  const Profile({Key? key,}) : super(key: key);


  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(context.watch<Store2>().name),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: ProfileHeader(),
              expandedHeight: 100,
            ),
            SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (c,i) =>
                      Image.network(context.watch<Store1>().profileImage[i]),
                  childCount: context.watch<Store1>().profileImage.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2)
            ),
          ],
        )
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            //동그란 이미지
            radius: 30,
            backgroundImage: AssetImage('images/main2.jpeg'),
          ),
          Text('팔로워  ${context.watch<Store1>().follower}명', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
          ElevatedButton(
              onPressed: () {
                context.read<Store1>().addFollower();
              },
              child: Text(context.watch<Store1>().follow)),
        ],
      ),
    );
  }
}
