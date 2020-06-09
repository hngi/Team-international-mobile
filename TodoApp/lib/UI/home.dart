import 'package:TodoApp/UI/addTodoItem.dart';
import 'package:TodoApp/UI/todoListView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: _appBarText(),
                  background: Image.network(
                    "https://i.ibb.co/YWmH6Jr/download2.png",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Center(
          child: TodoList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTodoItem()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

//AppBar custom text i.e Title and subtitle
Widget _appBarText() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      Text("Hi",
          style: TextStyle(
            fontSize: 28.0,
          )),
      Visibility(
        visible: true,
        child: Text(
          "This is your todo list",
          style: TextStyle(fontSize: 14.0),
        ),
      ),
    ],
  );
}