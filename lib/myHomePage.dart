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
        Positioned(
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
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w200),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          top: 64,
        ),
        Container(child: SearchFeed()),
      ]),
    );
  }

  Widget _buildScaffoldBody() {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Image.network(
        "https://static.nike.com/a/images/f_auto/dpr_3.0/h_500,c_limit/g1ljiszo4qhthfpluzbt/nike-joyride.jpg",
        fit: BoxFit.fitHeight,
      ),
    );
  }

  appBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Container(
          child: Column(
            children: [
              Text(
                "MEN'S ORIGINAL",
                style: TextStyle(fontWeight: FontWeight.w100, fontSize: 14),
              ),
              Text(
                "sss",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F2F3E)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
