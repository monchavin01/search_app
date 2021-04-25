import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_test/detail.dart';

class SearchContentScreen extends StatefulWidget {
  @override
  _SearchContentScreenState createState() => _SearchContentScreenState();
}

class _SearchContentScreenState extends State<SearchContentScreen> {
  var _chosenValue;
  String resultSearch = "";
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search For Content'),
      ),
      body: Container(
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
    return Container(
      height: Get.height * 0.5,
      width: Get.width * 0.85,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('onGrass')
            .where("description", isGreaterThanOrEqualTo: resultSearch)
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
                        child: Row(children: [
                          Image.network(
                            data.data()['image'],
                            width: Get.width * 0.3,
                            height: Get.width * 0.25,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Text(
                                data['description'].toString().length > 60
                                    ? data['description']
                                            .toString()
                                            .substring(0, 60) +
                                        "..."
                                    : data['description'],
                              ),
                            ),
                          )
                        ]),
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

  Widget appBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTextLogo('Shoes', Colors.blue),
        ],
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
