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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 128),
      child: Container(
        child: FirestoreSearchScaffold(
          scaffoldBackgroundColor: Colors.black.withOpacity(0.3),
          searchBackgroundColor: Colors.white,
          appBarBackgroundColor: Colors.black.withOpacity(0.1),
          firestoreCollectionName: 'clients',
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
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Detail(data: data)),
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
                          ),
                        )
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
    );
  }
}
