import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder/screens/userchoice.dart';
import 'package:toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteTask extends StatelessWidget {
  String taskname;
  BuildContext context;
  Card cardForUpdate(){

    return Card(
      margin: EdgeInsets.fromLTRB(20, 12, 20, 20),
      shadowColor: Colors.teal,
      elevation: 7,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
              topRight: Radius.circular(50)),
          side: BorderSide(width: 3, color: Colors.green)),
      child: Container(

        padding: EdgeInsets.fromLTRB(20, 40, 20, 30),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Column(

                children: [
                  TextField(
                    cursorColor: Colors.green,
                    cursorHeight: 30,
                    onSubmitted: (String value) {
                      this.taskname = value;



                    },
                    textAlign: TextAlign.center,
                    autofocus: false,
                    style: TextStyle(fontSize: 15.0),
                    decoration: InputDecoration(

                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(100.0),

                      ),

                      hintText: "enter name of task",

                    ),

                  ),



                ],
              ),

            ]

        ),
      ),

    );
  }
  Row addButtonAdder()
  {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    final firestore = Firestore.instance;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Container(
          height: 100.0,
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 95.0, vertical: 5.0),
          child: RaisedButton(

            child: Text(
              'Send',
              style: TextStyle(fontSize: 20.0),

            ),
            color: Colors.teal,
            onPressed: (){
              if(this.taskname!=null){
                  firestore.collection("users").document("routines").collection("yashmathur123123").document(this.taskname).delete();
                  firestore.collection("users").document("dailyroutines").collection("yashmathur123123").document("fullrecord").collection(formattedDate).document(this.taskname).delete();

                  Toast.show("Task "+this.taskname+" has been removed successfully!!", context, duration:2, gravity:Toast.BOTTOM,backgroundColor: Colors.teal);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return UserChoice();
                  }));
              }
              else{
                Toast.show("Something is left!!", context, duration:2, gravity:Toast.BOTTOM,backgroundColor: Colors.teal);

              }
            },

          ),
        )
      ],

    );

  }
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(

        title: Text('Remove task'),

      ),
      body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 50.0),
          // physics: const AlwaysScrollableScrollPhysics(),
          children: [cardForUpdate(),addButtonAdder()]
      ),
    );
  }
}

