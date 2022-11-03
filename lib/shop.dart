import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  getData() async {
    try {
      await auth.signInWithEmailAndPassword(
          email: 'shinjoo@naver.com', password: '123123');
    } catch (e) {
      print(e);
    }
    if(auth.currentUser?.uid == null) {
      print('로그인 안된 상태입니다.');
    }else{
      print('로그인 된 상태입니다.');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('샵페이지임123'),
    );
  }
}
