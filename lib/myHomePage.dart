import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:search_test/addDataInDB.dart';
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
            ListTile(
              title: Text('Search for content'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchContentScreen()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Column(children: [
              SizedBox(
                height: Get.height * 0.1,
              ),
              appBar(context),
              _buildSearchLayout(),
              _buildResultSearch(),
              // SizedBox(
              //   height: 16,
              // )
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchLayout() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: Get.width * 0.6,
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

  Widget _buildTab(String text, builderRoute) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          child: Text(
            text,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => builderRoute));
          },
        ),
      ),
    );
  }

  Widget _buildResultSearch() {
    return Container(
      height: Get.height * 0.6,
      width: Get.width * 0.6,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("computer-repair")
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
                          title: Text(
                            data.data()['name'],
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             Detail(data: data.data())));
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
            _buildTextLogo('Shoes', Colors.blue),
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
}
