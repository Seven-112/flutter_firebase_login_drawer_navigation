import 'package:WorkzApp_flutter/auth/AuthScreen.dart';
import 'package:WorkzApp_flutter/mainpages/screen1.dart';
import 'package:WorkzApp_flutter/mainpages/screen2.dart';
import 'package:WorkzApp_flutter/mainpages/screen3.dart';
import 'package:WorkzApp_flutter/mainpages/screen4.dart';
import 'package:WorkzApp_flutter/mainpages/screen5.dart';
import 'package:WorkzApp_flutter/mainpages/screen6.dart';
import 'package:WorkzApp_flutter/mainpages/screen7.dart';
import 'package:WorkzApp_flutter/mainpages/screen8.dart';
import 'package:WorkzApp_flutter/model/user.dart';
import 'package:WorkzApp_flutter/utils/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';

class ExampleCustomMenu extends StatelessWidget {
  var appbarTitle = 'WorkzApp';
  var appbarColor = Colors.blue;
  final User user;

  ExampleCustomMenu({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleHiddenDrawer(
      menu: Menu(),
      screenSelectedBuilder: (position,controller) {
        Widget screenCurrent;
        switch(position){
          case 0 :
            screenCurrent = Screen1();
            appbarTitle = 'Providers';
            appbarColor = Colors.blue;
            break;
          case 1 :
            screenCurrent = Screen2();
            appbarTitle = 'Appointment';
            appbarColor = Colors.orange;
            break;
          case 2 :
            screenCurrent = Screen3();
            appbarTitle = 'Schedule';
            appbarColor = Colors.red;
            break;
          case 3 :
            screenCurrent = Screen4();
            appbarTitle = 'Message';
            appbarColor = Colors.yellow;
            break;
          case 4 :
            screenCurrent = Screen5();
            appbarTitle = 'Security';
            appbarColor = Colors.grey;
            break;
          case 5 :
            screenCurrent = Screen6();
            appbarTitle = 'Share';
            appbarColor = Colors.pink;
            break;
          case 6 :
            screenCurrent = Screen7();
            appbarTitle = 'Profile';
            appbarColor = Colors.purple;
            break;
          case 7 :
            screenCurrent = Screen8();
            appbarTitle = 'Log out';
            appbarColor = Colors.green;
            break;

        }

        return Scaffold(
          appBar: AppBar(
            title: Text(appbarTitle),
            backgroundColor: appbarColor,
            leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  controller.toggle();
                }),
          ),
          body: screenCurrent,
        );
      },
    );
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with TickerProviderStateMixin{
  AnimationController _animationController;
  bool initConfigState = false;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    confListenerState(context);

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.cyan,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            //todo; here origin background

            // child: Image.asset(
            //   "assets/splash4.jpg",
            //   fit: BoxFit.cover,
            // ),
            child: Image.network('https://picsum.photos/seed/picsum/200/300', fit: BoxFit.cover,),
          ),
          FadeTransition(
            opacity: _animationController,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 200.0,
                      child: RaisedButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0)
                          )
                        ),
                        onPressed: () {
                          SimpleHiddenDrawerProvider.of(context)
                              .setSelectedMenuPosition(0);
                        },
                        child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.group),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Providers'),
                              ],
                          ),
                      ),
                    ),
                    SizedBox(
                      width: 200.0,
                      child: RaisedButton(
                        color: Colors.orange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20.0)
                              )
                          ),
                          onPressed: () {
                            SimpleHiddenDrawerProvider.of(context)
                                .setSelectedMenuPosition(1);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.view_list),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Appointment'),
                              ],
                          ),
                          ),
                    ),
                    SizedBox(
                      width: 200.0,
                      child: RaisedButton(
                        color: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20.0)
                              )
                          ),
                          onPressed: () {
                            SimpleHiddenDrawerProvider.of(context)
                                .setSelectedMenuPosition(2);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.today),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Schedule'),
                              ],
                          ),
                          ),
                    ),
                    SizedBox(
                      width: 200.0,
                      child: RaisedButton(
                        color: Colors.yellow,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20.0)
                              )
                          ),
                          onPressed: () {
                            SimpleHiddenDrawerProvider.of(context)
                                .setSelectedMenuPosition(3);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.message),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Message'),
                              ],
                          ),
                          ),
                    ),
                    SizedBox(
                      width: 200.0,
                      child: RaisedButton(
                        color: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20.0)
                              )
                          ),
                          onPressed: () {
                            SimpleHiddenDrawerProvider.of(context)
                                .setSelectedMenuPosition(4);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.security),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Security'),
                              ],
                          ),
                          ),
                    ),
                    SizedBox(
                      width: 200.0,
                      child: RaisedButton(
                        color: Colors.pink,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20.0)
                              )
                          ),
                          onPressed: () {
                            SimpleHiddenDrawerProvider.of(context)
                                .setSelectedMenuPosition(5);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.share),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Share'),
                              ],
                          ),
                          ),
                    ),
                    SizedBox(
                      width: 200.0,
                      child: RaisedButton(
                        color: Colors.purple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20.0)
                              )
                          ),
                          onPressed: () {
                            SimpleHiddenDrawerProvider.of(context)
                                .setSelectedMenuPosition(6);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.settings),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Profile'),
                              ],
                          ),
                          ),
                    ),
                    SizedBox(
                      width: 200.0,
                      child: RaisedButton(
                        color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20.0)
                              )
                          ),
                          onPressed: () {
                            // SimpleHiddenDrawerProvider.of(context)
                            //     .setSelectedMenuPosition(7);
                            pushReplacement(context, new AuthScreen());
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.power_settings_new),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Log out'),
                              ],
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void confListenerState(BuildContext context) {
    if(!initConfigState){
      initConfigState = true;
      SimpleHiddenDrawerProvider.of(context).getMenuStateListener().listen((state){

        if(state == MenuState.open){
          _animationController.forward();
        }

        if(state == MenuState.closing){
          _animationController.reverse();
        }
      });
    }
  }


}

