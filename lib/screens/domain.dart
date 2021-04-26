import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DomainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Model'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            _buildBackGround('assets/background.jpeg'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(16),
                width: Get.width * 0.99,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(spreadRadius: 0.01, blurRadius: 1),
                  ],
                ),
                child: Text(
                    '555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555'),
              ),
            )
          ],
        ),
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
}
