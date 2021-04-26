import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDataInDB extends StatefulWidget {
  @override
  _AddDataInDBState createState() => _AddDataInDBState();
}

class _AddDataInDBState extends State<AddDataInDB> {
  final firestoreInstance = FirebaseFirestore.instance;
  TextEditingController keyController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageURLController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  List<String> resultFormatKey;

  var _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 64),
          child: Column(
            children: [
              _buildDropDown(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: keyController,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Key Search',
                    border: OutlineInputBorder(),
                    hintText: 'Enter Key Search',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: nameController,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    hintText: 'Enter Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: priceController,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                    hintText: 'Enter Price',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: descriptionController,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                    hintText: 'Enter Description',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: imageURLController,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Image URL',
                    border: OutlineInputBorder(),
                    hintText: 'Enter URL',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                  onPressed: () => {
                    _onPressed(context),
                  },
                  child: Text('Add'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  validateNotNull(value) {
    if (value == null || value.isEmpty) {
      return 'โปรดกรอกข้อมูล';
    }
    return null;
  }

  test() {
    String number = keyController.text;
    List<String> listnumber = number.split("");
    List<String> output = [];
    for (int i = 0; i < listnumber.length; i++) {
      if (i != listnumber.length - 1) {
        output.add(listnumber[i].toString());
      }
      List<String> temp = [listnumber[i]];
      for (int j = i + 1; j < listnumber.length; j++) {
        temp.add(listnumber[j]);
        output.add(temp.join().toString());
      }
    }
    return resultFormatKey = output;
  }

  void _onPressed(BuildContext context) {
    test();
    firestoreInstance.collection(_chosenValue).add({
      "searchKey": resultFormatKey,
      "name": nameController.text,
      "price": priceController.text,
      "description": descriptionController.text,
      "image": imageURLController.text,
    }).then((value) {
      _showMyDialog(context);
    });
  }

  Future _showMyDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('เพิ่มข้อมูลเรียบร้อย'),
          actions: <Widget>[
            TextButton(
              child: Text('ตกลง'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDropDown() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
            ),
          ],
        ),
        width: Get.width,
        height: Get.height * 0.06,
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
              "Please choose type",
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
