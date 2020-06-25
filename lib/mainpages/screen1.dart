
import 'package:WorkzApp_flutter/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  final List<String> kkk = new List();
  final List<String> titles = ['Alex B', 'Boris A', 'Olga I', 'Ilya K'];
  final List<String> subTitles = ['Driver', 'Doctor', 'Programmer', 'Teacher'];
  final List<String> images = ['https://picsum.photos/seed/picsum/200/300', 'https://picsum.photos/seed/picsum/200/300', 'https://picsum.photos/seed/picsum/200/300', 'https://picsum.photos/seed/picsum/200/300'];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.blue
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //avatar image
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                    child: CircleAvatar(backgroundImage: NetworkImage(images[index]), radius: 30,)
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  //user name and category
                  Container(
                    child: Column(
                      children: [
                        Container(
                          child: Text(titles[index], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(subTitles[index], style: TextStyle(color: Colors.redAccent),),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  //function buttons
                  Container(
                    child: Column(
                      children: [
                        Container(
                          height: 20,
                          child: FlatButton(
                            child: Text("Profile", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),),
                            onPressed: () {
                              print("selected user --> $titles");
                            },
                          ),
                        ),
                        Container(
                          height: 20,
                          padding: EdgeInsets.only(top: 5),
                          child: FlatButton(
                            child: Text("Appointment", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),),
                            onPressed: () {
                              print("selected user --> $subTitles");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            );
          },
        ),
      ),
    );
  }
  Future<Null> _refresh() async{
    print('refreshing stocks...');
  }
  Future getDocs() async {
  QuerySnapshot querySnapshot = await Firestore.instance.collection("USERS").getDocuments();
  for (int i = 0; i < querySnapshot.documents.length; i++) {
    var a = querySnapshot.documents[i];
    DocumentSnapshot result = await     Firestore.instance.collection('USERS').document(a.documentID).get();
    print(a.documentID);
    print(result.data['firstName']);
    titles.add(result.data["firstName"] + result.data["lastName"]);
    subTitles.add(result.data["job"]);
    images.add(result.data["profilePictureURL"]);
  }
}
}
