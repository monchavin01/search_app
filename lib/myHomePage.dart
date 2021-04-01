import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_test/addData.dart';
import 'package:search_test/searchComponent.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        _buildScaffoldBody(),
        appBar(context),
        Container(child: SearchFeed()),
      ]),
    );
  }

  Widget _buildScaffoldBody() {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Image.asset(
        "assets/background.jpeg",
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Positioned(
      child: Container(
        width: Get.width,
        child: GestureDetector(
          onDoubleTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddData()),
            );
          },
          child: Text(
            'SHOES',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w200),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      top: 64,
    );
  }
}
