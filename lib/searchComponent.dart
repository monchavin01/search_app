import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_test/dataModel.dart';
import 'package:search_test/detail.dart';

class SearchFeed extends StatefulWidget {
  @override
  _SearchFeedState createState() => _SearchFeedState();
}

class _SearchFeedState extends State<SearchFeed> {
  String _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 56),
          child: Container(
            child: FirestoreSearchScaffold(
              scaffoldBackgroundColor: Colors.black.withOpacity(0.3),
              searchBackgroundColor: Colors.white,
              appBarBackgroundColor: Colors.black.withOpacity(0.1),
              firestoreCollectionName: _chosenValue ?? "onGrass",
              searchBy: 'name',
              dataListFromSnapshot: DataModel().dataListFromSnapshot,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<DataModel> dataList = snapshot.data;
                  return ListView.builder(
                      itemCount: dataList?.length ?? 0,
                      itemBuilder: (context, index) {
                        final DataModel data = dataList[index];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _buildListLayout(
                                    context, data, _chosenValue))
                          ],
                        );
                      });
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
        _buildDropDown(),
      ],
    );
  }

  Widget _buildListLayout(BuildContext context, data, String valueType) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Detail(data: data, valueType: valueType)),
        );
      },
      child: Container(
        width: Get.width,
        height: Get.height * 0.05,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${data?.name ?? ''}'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropDown() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        left: 10,
        right: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
            ),
          ],
        ),
        width: Get.width,
        height: Get.height * 0.045,
        child: Center(
          child: DropdownButton(
            value: _chosenValue,
            style: TextStyle(color: Colors.white),
            iconEnabledColor: Colors.grey,
            items: [
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
              "Please choose type shoe",
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
