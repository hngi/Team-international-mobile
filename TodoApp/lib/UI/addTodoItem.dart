import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Class to create a new to-do item

class AddTodoItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add todo"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38),
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(35)),
                ),
                child: Icon(
                  Icons.restaurant,
                  size: 30,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 20),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                ),
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: () {},
                  textColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: const Text('ADD ITEM', style: TextStyle(fontSize: 16)),
                ),
              ),

              //TODO add calender picker for date and time picker for time
//              Text('Reminder')
            ],
          ),
        ),
      ),
    );
  }
}
