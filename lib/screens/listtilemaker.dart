import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
//for notifications
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ListTileMaker extends StatefulWidget {
  ListTileMaker(this.itemname,this.frequency,this.iconimage,this.iconcolor,this.block2,this.customFunctionForUpdatingListatshow);
  final customFunctionForUpdatingListatshow;
  var tilecolor = Colors.grey.shade300;
  String itemname;
  String frequency;
  IconData iconimage;
  Color iconcolor;

  List <Widget> block2;
  @override
  _ListTileMakerState createState() => _ListTileMakerState();
}

class _ListTileMakerState extends State<ListTileMaker> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final firestore = Firestore.instance;



  // Method 2
  Future _showNotificationWithDefaultSound(String mainmsg,String secondarymsg) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'themockingjester', 'reminder', 'your channel description',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      mainmsg,
      secondarymsg,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = IOSInitializationSettings();
    var initSettings = InitializationSettings(android: android,iOS: ios);
    flutterLocalNotificationsPlugin.initialize(initSettings,onSelectNotification: onSelectNotification);

  }
  Future onSelectNotification(String payload){
    // showDialog(context: context,builder: (_)=>AlertDialog(
    //   title: Text('notification'),
    //   content: Text('$payload'),
    // ));
  }
  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return Container(

      padding: EdgeInsets.fromLTRB(60, 20, 60, 20),
      child: GestureDetector(
        onDoubleTap: (){
          if(int.parse(widget.frequency)-1==-1) {
            firestore.collection("users").document("dailyroutines").collection("yashmathur123123").document("fullrecord").collection(formattedDate).document(widget.itemname).updateData({
              'frequency': 0
            }
            );
          }
          else{
            if(int.parse(widget.frequency)==1){
              _showNotificationWithDefaultSound("Congratulations!!","Task "+widget.itemname+" completed");
            }
            firestore.collection("users").document("dailyroutines").collection("yashmathur123123").document("fullrecord").collection(formattedDate).document(widget.itemname).updateData({
              'frequency': int.parse(widget.frequency)-1

            }
            );
          }


          widget.customFunctionForUpdatingListatshow(widget,false);



        },



        child: Card(
          shadowColor: Colors.teal,
          elevation: 20,


          shape: RoundedRectangleBorder(

              side: BorderSide(width: 3, color: Colors.black45)),
          child: ListTile(

            contentPadding: EdgeInsets.symmetric(vertical:5,horizontal: 20),

            trailing: CircleAvatar(

              backgroundColor: Colors.grey.shade100,
              child: Text(
                widget.frequency,
                style: TextStyle(fontSize: 30.0,color: Colors.teal),
              ),
            ),
            leading: Icon(
              widget.iconimage,
              color: widget.iconcolor,
            ),

            title: Text(
              widget.itemname,

              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.teal),
            ),
            subtitle: Text(
              'Left to Done',
              textAlign: TextAlign.center,
            ),
            onTap: () {

              firestore.collection("users").document("dailyroutines").collection("yashmathur123123").document("fullrecord").collection(formattedDate).document(widget.itemname).updateData({
                'frequency': int.parse(widget.frequency)+1
              }
              );

                widget.customFunctionForUpdatingListatshow(widget,true);



            },

            tileColor: widget.tilecolor,
          ),
        ),
      ),
    );;
  }
}
