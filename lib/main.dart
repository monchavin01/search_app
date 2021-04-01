import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_test/addData.dart';
import 'package:search_test/detail.dart';
import 'package:search_test/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        _buildScaffoldBody(),
        Positioned(
          child: Container(
            width: Get.width,
            child: GestureDetector(
              onDoubleTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddData()),
                );
              },
              child: Text(
                'SHOES',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w200),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          top: 64,
        ),
        Container(child: SearchFeed()),
      ]),
    );
  }

  Widget _buildScaffoldBody() {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Image.network(
        "https://static.nike.com/a/images/f_auto/dpr_3.0/h_500,c_limit/g1ljiszo4qhthfpluzbt/nike-joyride.jpg",
        fit: BoxFit.fitHeight,
      ),
    );
  }

  appBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Container(
          child: Column(
            children: [
              Text(
                "MEN'S ORIGINAL",
                style: TextStyle(fontWeight: FontWeight.w100, fontSize: 14),
              ),
              Text(
                "sss",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F2F3E)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
