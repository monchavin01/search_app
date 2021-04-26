import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:search_test/addDataInDB.dart';
import 'package:search_test/detail.dart';
import 'package:search_test/screens/about.dart';
import 'package:search_test/screens/domain.dart';
import 'package:search_test/screens/model.dart';
import 'package:search_test/screens/searchContentScreen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String resultSearch = "";
  bool showCancelIcon = false;
  TextEditingController _controller = TextEditingController();
  var _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(child: _buildTextLogo('Shoes', Colors.white)),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutScreen()));
              },
            ),
            ListTile(
              title: Text('Model'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ModelScreen()));
              },
            ),
            ListTile(
              title: Text('Domain'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DomainScreen()));
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          _buildBackGround('assets/background.jpeg'),
          Container(
            child: Column(
              children: [
                Column(children: [
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  appBar(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDropDown(),
                      _buildSearchLayout(),
                    ],
                  ),
                  _buildResultSearch(),
                  // SizedBox(
                  //   height: 16,
                  // )
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackGround(String url) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: Image.asset(
        url,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildSearchLayout() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: Get.width * 0.5,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
                suffixIcon: _controller.text != "" || resultSearch != ""
                    ? MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          child: Icon(Icons.cancel),
                          onTap: () {
                            _controller.clear();
                            resultSearch = "";
                          },
                        ),
                      )
                    : null,
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                resultSearch = val;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildResultSearch() {
    print(_chosenValue);
    return Container(
      height: Get.height * 0.5,
      width: Get.width * 0.85,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(_chosenValue ?? "onGrass")
            .where("searchKey", arrayContains: resultSearch)
            .snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.docs[index];
                    return Container(
                      color: Colors.white,
                      child: GestureDetector(
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                data.data()['image'],
                                width: Get.width * 0.15,
                                height: Get.width * 0.15,
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: Get.width * 0.58,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.data()['name'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        data
                                                    .data()['description']
                                                    .toString()
                                                    .length >
                                                60
                                            ? data
                                                    .data()['description']
                                                    .toString()
                                                    .substring(0, 60) +
                                                "..."
                                            : data.data()['description'],
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Detail(
                                        data: data.data(),
                                        valueType: _chosenValue,
                                      )));
                        },
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onLongPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDataInDB()),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextLogo('Shoes', Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildTextLogo(String text, textColor) {
    return Text(
      text,
      style: GoogleFonts.rubik().copyWith(
          fontSize: 64, color: textColor, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildDropDown() {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey),
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              // color: Colors.grey.withOpacity(0.5),

              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.001,
              // blurRadius: 00,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        width: Get.width * 0.35,
        // height: Get.height * 0.06,
        child: Center(
          child: DropdownButton<String>(
            focusColor: Colors.white,
            value: _chosenValue,
            //elevation: 5,
            style: TextStyle(color: Colors.white),
            iconEnabledColor: Colors.black,
            items: <String>[
              'onGrass',
              'running',
              'court',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
            hint: Text(
              "selected",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            onChanged: (String value) {
              setState(() {
                _chosenValue = value;
              });
            },
          ),
        ),
      ),
    );
  }
}

enum ListDropdown { onGrass, running, court }
