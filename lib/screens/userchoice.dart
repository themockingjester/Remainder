import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminder/screens/listtilemaker.dart';
import 'package:reminder/screens/updatetask.dart';
import 'package:reminder/screens/newtasklist.dart';
import 'package:reminder/screens/getalltask.dart';
import 'package:reminder/screens/deletetask.dart';
import 'package:intl/intl.dart';
//for notifications
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class UserChoice extends StatefulWidget {
  @override
  _UserChoiceState createState() => _UserChoiceState();
}


class _UserChoiceState extends State<UserChoice> {
  final firestore = Firestore.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool ifreadyfornotification = false;
  List<Widget> block2 = List();


  Future<void> scheduleNotification() async {
    var scheduledNotificationDateTime =
    DateTime.now().add(Duration(hours:4));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'themockingjester',
      'reminder',
      'channel description',
      // icon: '../images/close.png',
      // largeIcon: DrawableResourceAndroidBitmap('../images/close.png'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
      0,
      'Hey!!',
      'check for remaining tasks',
      scheduledNotificationDateTime,
      platformChannelSpecifics,


      payload: 'Default_Sound',

    );

  }
  void listRefresherforshow(Widget w,bool factor){


    // if factor==True then add 1 otherwise subtract 1
    print("refreshing");
    List<Widget> temp = List();
    List<Widget> secondary = block2;
    // print(block2);
      block2.clear();


    for(int i=0;i<secondary.length;i++)
    {
      if (secondary[i]!=w){

          temp.add(secondary[i]);


      }
      else{

        ListTileMaker k = secondary[i];
        ListTileMaker l = w;
        if(factor==true)
        {

          setState(() {
            temp.add(ListTileMaker(l.itemname, (int.parse(l.frequency)+1).toString(), Icons.close, Colors.red, l.block2, l.customFunctionForUpdatingListatshow));



          });

        }
        else{
          if(int.parse(l.frequency)-1==-1 || int.parse(l.frequency)-1==0 )
          {
            setState(() {
              temp.add(ListTileMaker(l.itemname, '0', Icons.check, Colors.teal, l.block2, l.customFunctionForUpdatingListatshow));

            });

          }
          else{

            setState(() {

              temp.add(ListTileMaker(l.itemname, (int.parse(l.frequency)-1).toString(), Icons.close, Colors.red, l.block2, l.customFunctionForUpdatingListatshow));

              
            });

          }

        }



      }



    }
    setState(() {

      block2=temp;
    });
    // print(block2);



  }

  Future<bool> checkExist(String docID) async {
    bool exists = true;

      var snapshot = await Firestore.instance.collection("users").document("dailyroutines").collection("yashmathur123123").document("fullrecord").collection(docID).getDocuments();
    if (snapshot.documents.length == 0) {
      exists=false;
    }
    return exists;
  }

  Future<List> addDataToServerForNewDay(String day) async{

    var snapshot = await Firestore.instance
        .collection('users')
        .document('routines')
        .collection('yashmathur123123')
        .snapshots();
    List<Widget> temp = List();
    snapshot.forEach((element) {

      element.documents.forEach((element) {

        firestore.collection('users').document('dailyroutines').collection('yashmathur123123').document("fullrecord").collection(day).document(element.data['taskname']).setData(
            {
              'taskname':element.data['taskname'],
              'frequency':element.data['frequency'].toString()
            });

      });
    });

  }

  Future<List> getData() async{
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    bool ifexists = await checkExist(formattedDate);
    if(ifexists==true){
      // do nothing
    }
    else{

      addDataToServerForNewDay(formattedDate);
    }

    var snapshot = await Firestore.instance
        .collection('users')
        .document('dailyroutines')
        .collection('yashmathur123123')
        .document("fullrecord")
        .collection(formattedDate)
        .snapshots();
    List<Widget> temp = List();
    snapshot.forEach((element) {

      element.documents.forEach((element) {
        if (element.data['frequency']!=0)
        {
          // print(element.data['frequency']);

          temp.add(ListTileMaker(element.data['taskname'],element.data['frequency'].toString(),Icons.close,Colors.red,block2,listRefresherforshow));

        }
        else{

          temp.add(ListTileMaker(element.data['taskname'],element.data['frequency'].toString(),Icons.check,Colors.teal,block2,listRefresherforshow));

        }
      });
    });


    setState(() {

      block2=temp;

    });


  }
  // Image getImage(path){
  //   return Image(
  //     image: AssetImage(path),
  //     height: 100,
  //     width: 100,
  //   );
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = IOSInitializationSettings();
    var initSettings = InitializationSettings(android: android,iOS: ios);
    flutterLocalNotificationsPlugin.initialize(initSettings,onSelectNotification: onSelectNotification);

    getData();



  }
  Future onSelectNotification(String payload){
    // showDialog(context: context,builder: (_)=>AlertDialog(
    //   title: Text('notification'),
    //   content: Text('$payload'),
    // ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Reminder'),
        actions: <Widget>[

          Tooltip(

            message: "Update a task",
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient:
              const LinearGradient(colors: <Color>[Colors.black45, Colors.black45]),
            ),
            height: 20,
            padding: const EdgeInsets.all(8.0),
            preferBelow: false,

            showDuration: const Duration(seconds: 2),
            waitDuration: const Duration(seconds: 1),
            child: IconButton(
              icon: Icon(
                Icons.update,
                color: Colors.white,

              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateTask();
                }));
              },

            ),
          ),
          Tooltip(

            message: "Add new item",
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient:
              const LinearGradient(colors: <Color>[Colors.black45, Colors.black45]),
            ),
            height: 20,
            padding: const EdgeInsets.all(8.0),
            preferBelow: false,

            showDuration: const Duration(seconds: 2),
            waitDuration: const Duration(seconds: 1),
            child: IconButton(
              icon: Icon(
                Icons.add_to_photos_outlined,
                color: Colors.white,

              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NewTaskList(true);
                }));
              },

            ),
          ),
          Tooltip(

            message: "Remove a task",
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient:
              const LinearGradient(colors: <Color>[Colors.black45, Colors.black45]),
            ),
            height: 20,
            padding: const EdgeInsets.all(8.0),
            preferBelow: false,

            showDuration: const Duration(seconds: 2),
            waitDuration: const Duration(seconds: 1),
            child: IconButton(
              icon: Icon(
                Icons.remove_circle_outline_outlined,
                color: Colors.white,

              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DeleteTask();
                }));
              },

            ),
          ),
          Tooltip(

            message: "Check current task list",
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient:
              const LinearGradient(colors: <Color>[Colors.black45, Colors.black45]),
            ),
            height: 20,
            padding: const EdgeInsets.all(8.0),
            preferBelow: false,

            showDuration: const Duration(seconds: 2),
            waitDuration: const Duration(seconds: 1),
            child: IconButton(
              icon: Icon(
                Icons.playlist_add_check_sharp,
                color: Colors.white,

              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return GetAllTask();
                }));
              },
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          var now = new DateTime.now();
          var formatter = new DateFormat('yyyy-MM-dd');
          String formattedDate = formatter.format(now);

          var snapshot = Firestore.instance
              .collection('users')
              .document('dailyroutines')
              .collection('yashmathur123123')
              .document("fullrecord")
              .collection(formattedDate)
              .snapshots();
          List<Widget> temp = List();
          snapshot.forEach((element) {

            element.documents.forEach((element) {
              if (element.data['frequency']!=0)
              {
                // print(element.data['frequency']);

                print(element.data['frequency']);
                temp.add(ListTileMaker(element.data['taskname'],element.data['frequency'].toString(),Icons.close,Colors.red,block2,listRefresherforshow));
                if(ifreadyfornotification==false){
                  ifreadyfornotification=true;
                  scheduleNotification();

                }
              }
              else{

                temp.add(ListTileMaker(element.data['taskname'],element.data['frequency'].toString(),Icons.check,Colors.teal,block2,listRefresherforshow));

              }
              setState(() {

                block2=temp;
              });


            });
          });

        },
        child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 50.0),
        // physics: const AlwaysScrollableScrollPhysics(),
        children: block2
        ),
    ),
    );
  }
}
