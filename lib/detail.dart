import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Detail extends StatelessWidget {
  var data;
  final String valueType;
  Detail({Key key, @required this.data, @required this.valueType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            appBar(context),
            _buildLayoutImage(),
            // data['image'] != ""
            //             ? ClipRRect(
            //                 borderRadius: BorderRadius.circular(100),
            //                 child: Image.network(
            //                   data['image'],
            //                   fit: BoxFit.cover,
            //                 ),
            //               )
            //             : ClipRRect(
            //                 borderRadius: BorderRadius.circular(100),
            //                 child: Image.network(
            //                   'http://teamtech24.com/foodhati/foodhatiAdmin/assets/img/foodimg/default-food-image.jpg',
            //                   fit: BoxFit.cover,
            //                 ),
            //               ),
            data['description'] != ""
                ? _buildLayoutDescription(data['description'])
                : _buildLayoutDescription('ไม่มีคำอธิบาย')
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
                  valueType ?? "onGrass",
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 14),
                ),
                Text(
                  data['name'],
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

  Widget _buildLayoutDescription(String value) {
    value = data['description'];
    return Container(
      child: Text(
        value,
        // textAlign: TextAlign.justify,
        style: TextStyle(height: 1.5, color: Color(0xFF6F8398), fontSize: 16),
      ),
      padding: EdgeInsets.all(16),
    );
  }

  Widget _buildLayoutImage() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        color: data['image'] != "" ? null : Colors.black,
        alignment: Alignment.center,
        height: Get.height * 0.5,
        width: Get.width * 0.9,
        child: data['image'] != ""
            ? ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  data['image'],
                  fit: BoxFit.cover,
                ),
              )
            : Text(
                'No Image',
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
      ),
    );
  }
}
