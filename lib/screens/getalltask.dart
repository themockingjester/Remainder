import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder/screens/listtilemakerforgettingtaskinfo.dart';
import 'package:toast/toast.dart';


class GetAllTask extends StatefulWidget {
  @override
  _GetAllTaskState createState() => _GetAllTaskState();
}

class _GetAllTaskState extends State<GetAllTask> {
  final firestore = Firestore.instance;
  List<Widget> block3 = List();

  // function


   // function
  Future<List> getData() async{

    var snapshot = await Firestore.instance
        .collection('users')
        .document('routines')
        .collection('yashmathur123123')
        .snapshots();
    List<Widget> temp = List();
    snapshot.forEach((element) {

      element.documents.forEach((element) {

          temp.add(ListTileMakerForGettingTaskInfo(element.data['taskname'],element.data['frequency'].toString()));


      });
    });


    setState(() {
      block3=temp;

    });
    Toast.show("Completely fetched!!", context, duration:1, gravity:Toast.BOTTOM,backgroundColor: Colors.teal);



  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tasklist'),

        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50.0),
          physics: const AlwaysScrollableScrollPhysics(),
          children:block3






        )
    );;
  }
}
