import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  final List<String> titles = ['Boris A', 'Ilya K'];
  final List<String> subTitles = ['Doctor', 'Teacher'];
  final List<String> images = ['assets/splash.jpg', 'assets/splash.jpg'];
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
                      color: Colors.orange.withOpacity(0.5),
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
                        child: CircleAvatar(backgroundImage: AssetImage(images[index]), radius: 30,)
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
                            child: Text(subTitles[index]),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //function buttons
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: FlatButton(
                              child: Icon(Icons.list),
                              onPressed: () {
                                print("selected user --> $subTitles");
                              },
                            ),
                          ),
                          Container(
                            child: FlatButton(
                              child: Icon(Icons.message),
                              onPressed: () {
                                print("selected user --> $titles");
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
}
