import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:reminder/screens/userchoice.dart';
import 'package:toast/toast.dart';
import 'package:reminder/screens/cardforadd.dart';

class NewTaskList extends StatefulWidget {
  // factor = true when we have to delete collection and add new data while if factor= false append data to collection
  NewTaskList(this.factor);
  bool factor;
  @override
  _NewTaskListState createState() => _NewTaskListState();
}

class _NewTaskListState extends State<NewTaskList> {
  final firestore = Firestore.instance;

  int c=1;
  List<Widget> block = new List<Widget>();

  void listRefresher(Widget w){
    // This function will refresh the list after deleting the card
    setState(() {

      List<Widget> temp = new List<Widget>();
      for(int i=0;i<block.length-1;i++)
        {
          if (block[i]!=w){
            temp.add(block[i]);
          }



        }
      temp.add(addButtonAdder());

      block=temp;
      print(block.length);
    });
  }

  void initState(){
    super.initState();

    block.add(CardForAdd(block,listRefresher));
    block.add(addButtonAdder());



  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Add tasks here'),
          actions: <Widget>[
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
                  Icons.add,
                  color: Colors.white,

                ),
                onPressed: () {
                  print(block.hashCode);
                  c++;
                  // List<Widget> temp = new List<Widget>();


                  List<Widget> temp = new List<Widget>();
                  print(c);
                  for(int i=0;i<block.length-1;i++) {
                    print(block);
                    CardForAdd k = block[i];
                    print(k.taskname);
                    temp.add(block[i]);
                  }



                  setState(() {

                    block = temp;
                    block.add(CardForAdd(block,listRefresher));
                    block.add(addButtonAdder());

                  });


                },
              ),
            )
          ],
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50.0),
          // physics: const AlwaysScrollableScrollPhysics(),
          children:
            block,





        )
    );
  }
  Row addButtonAdder()
  {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
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

            onPressed: () {

              if(block.length>1)
                {
                  if(widget.factor==false)
                    {
                      // not implemented
                    }
                  for (int j = 0;j<block.length-1;j++)
                  {
                    CardForAdd k = block[j];
                    if (k.frequency==null || k.taskname==null){
                      Toast.show("Some details are left!!", context, duration:2, gravity:Toast.BOTTOM,backgroundColor: Colors.teal);

                      return ;
                    }
                    if (k.taskname!="" && k.frequency>-1){
                      print(k.taskname);
                      firestore.collection('users').document('routines').collection('yashmathur123123').document(k.taskname).setData(
                        {
                          'taskname':k.taskname,
                        'frequency':k.frequency
                      });
                      firestore.collection('users').document('dailyroutines').collection('yashmathur123123').document("fullrecord").collection(formattedDate).document(k.taskname).setData(
                          {
                            'taskname':k.taskname,
                            'frequency':k.frequency
                          });


                    }
                    else{
                      Toast.show("Some details are left!!", context, duration:2, gravity:Toast.BOTTOM,backgroundColor: Colors.teal);

                    }
                    Toast.show("Added Successfully!!", context, duration:2, gravity:Toast.BOTTOM,backgroundColor: Colors.teal);
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return UserChoice();
                    }));

                  }


                }
                else{
                  print("you havn't added any file till now");
                  Toast.show("Please add at least one task!!", context, duration:2, gravity:Toast.BOTTOM,backgroundColor: Colors.teal);

              }


            },

          ),
        )
      ],

    );

  }

}