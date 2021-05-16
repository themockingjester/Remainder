import 'package:reminder/screens/userchoice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text('Reminder'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              CircleAvatar(
                radius: 60.0,

                backgroundColor: Colors.teal,
                backgroundImage: AssetImage('images/star.png'),
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(

                padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 0),
                child: TextField(
                  obscureText: true,
                  style: TextStyle(fontSize: 28.0,
                  fontFamily: 'Pacifico',
                      ),

                  decoration: new InputDecoration.collapsed(hintText: "Enter Security Code"),
                  onChanged: (String text) {
                    print("text => $text");
                  },
                ),
              ),
              Container(
                height: 50.0,
              ),
              RaisedButton(
                child: Text(
                  'Go',
                  style: TextStyle(fontSize: 20.0),

                ),
                color: Colors.orangeAccent,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return UserChoice();
                  }));
                },
              ),
              SizedBox(
                height:80,
              )
            ],
          ),
        ),
      ),
    );
  }
}
