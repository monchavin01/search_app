import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_test/main.dart';

class Detail extends StatelessWidget {
  final DataModel data;
  Detail({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            appBar(context),
            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                alignment: Alignment.center,
                height: Get.height * 0.5,
                width: Get.width * 0.9,
                child: data.image != ""
                    ? Image.network(
                        data.image,
                        fit: BoxFit.fill,
                      )
                    : Text(
                        'No Image',
                        style: TextStyle(fontSize: 32),
                      ),
              ),
            ),
            description,
          ],
        ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back),
          ),
          Container(
            child: Column(
              children: [
                Text(
                  "MEN'S ORIGINAL",
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 14),
                ),
                Text(
                  data.name,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F2F3E)),
                ),
              ],
            ),
          ),
          Container(),
        ],
      ),
    );
  }

  var description = Container(
    child: Text(
      "A style icon gets some love from one of today's top "
      "trendsetters. Pharrell Williams puts his creative spin on these "
      "shoes, which have all the clean, classicdetails of the beloved Stan Smith.",
      textAlign: TextAlign.justify,
      style: TextStyle(height: 1.5, color: Color(0xFF6F8398)),
    ),
    padding: EdgeInsets.all(16),
  );
}
