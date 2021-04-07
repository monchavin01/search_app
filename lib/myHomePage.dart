import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_test/addDataInDB.dart';
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
      appBar: AppBar(
        title: Container(
          width: Get.width,
          child: GestureDetector(
            onDoubleTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddDataInDB()),
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
      ),
      body: Stack(children: [
        _buildScaffoldBody(),
        Container(child: SearchFeed()),
      ]),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
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
}
