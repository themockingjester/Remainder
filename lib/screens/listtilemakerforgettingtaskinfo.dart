import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListTileMakerForGettingTaskInfo extends StatefulWidget {
  ListTileMakerForGettingTaskInfo(this.taskname,this.frequency);
  String frequency;
  String taskname;

  @override
  _ListTileMakerForGettingTaskInfoState createState() => _ListTileMakerForGettingTaskInfoState();
}

class _ListTileMakerForGettingTaskInfoState extends State<ListTileMakerForGettingTaskInfo> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      child: ListTile(

        contentPadding: EdgeInsets.symmetric(vertical:5,horizontal: 20),
        trailing: CircleAvatar(

          backgroundColor: Colors.grey.shade100,
          child: Text(
            widget.frequency,


            style: TextStyle(fontSize: 30.0,color: Colors.teal),
          ),
        ),

        title: Text(
          widget.taskname,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.teal),
        ),
        subtitle: Text(
          'frequency(per day)',
          textAlign: TextAlign.center,
        ),


        tileColor: Colors.grey.shade300,
      ),
    );
  }
}
