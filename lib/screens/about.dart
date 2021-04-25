import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  bool showAll = true;
  String resultSearch = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                resultSearch = val;
              });
            },
          ),
        ),
      ),
      body: _buildSearch(),
    );
  }

  Widget _buildSearch() {
    return StreamBuilder<QuerySnapshot>(
      stream:
          // FirebaseFirestore.instance
          //     .collection('onGrass')
          //     .where("searchKey", arrayContains: resultSearch)
          //     .snapshots(),
          FirebaseFirestore.instance
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
                  return Card(
                    child: Row(
                      children: [
                        Image.network(
                          data.data()['image'],
                          width: 150,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        // Text(
                        //   data.data()['name'],
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.w700,
                        //     fontSize: 20,
                        //   ),
                        // ),
                        // Text(
                        //   data.data()['description'],
                        // ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text.rich(TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                      data.data()['description'].length > 60 &&
                                              !showAll
                                          ? data
                                                  .data()['description']
                                                  .substring(0, 60) +
                                              "..."
                                          : data.data()['description']),
                              data.data()['description'].length > 60
                                  ? WidgetSpan(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showAll = !showAll;
                                          });
                                        },
                                        child: Text(
                                          showAll ? 'read less' : 'read more!',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    )
                                  : TextSpan(),
                            ],
                          )),
                        ),
                      ],
                    ),
                  );
                },
              );
      },
    );
  }
}
