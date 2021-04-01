import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel {
  final String name;
  final String searchKey;
  final String image;
  final String description;

  DataModel({this.name, this.searchKey, this.image, this.description});

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold

  List<DataModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap = snapshot.data();

      return DataModel(
        name: dataMap['name'],
        searchKey: dataMap['searchKey'],
        image: dataMap['image'],
        description: dataMap['description'],
      );
    }).toList();
  }
}
