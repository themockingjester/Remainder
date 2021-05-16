import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: must_be_immutable
class CardForAdd extends StatefulWidget {
  final customFunctionForUpdatingList;
  CardForAdd(this.block,this.customFunctionForUpdatingList);
  String taskname;
  int frequency;
  List <Widget> block;
  @override
  _CardForAddState createState() => _CardForAddState();
}

class _CardForAddState extends State<CardForAdd> {

  @override
  Widget build(BuildContext context) {
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

        padding: EdgeInsets.fromLTRB(25, 40, 25, 30),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Tooltip(
                message: "Remove card",
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
                      Icons.close,
                      color: Colors.grey,

                    ),
                    onPressed: () {
                      // print(widget.block.hashCode);


                        widget.customFunctionForUpdatingList(widget);




                          print(widget.block);

                    }
                ),
              ),
              Column(

                children: [
                  TextField(
                    cursorColor: Colors.green,
                    cursorHeight: 30,
                    onSubmitted: (String value) {
                      widget.taskname = value;



                    },
                    textAlign: TextAlign.center,
                    autofocus: false,
                    style: TextStyle(fontSize: 15.0),
                    decoration: InputDecoration(

                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(100.0),

                      ),

                      hintText: "enter task name",

                    ),

                  ),
                  Container(
                    height: 10.0,
                  ),
                  TextField(
                    cursorHeight: 30,
                    cursorColor: Colors.green,
                    onSubmitted: (String s){
                      widget.frequency = int.parse(s);
                    },

                    textAlign: TextAlign.center,
                    autofocus: false,
                    style: TextStyle(fontSize: 15.0),
                    decoration: InputDecoration(

                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(100.0),

                      ),
                      hintText: "enter task frequency(per day)",

                    ),

                  ),

                ],
              ),

            ]

        ),
      ),

    );
  }
}

