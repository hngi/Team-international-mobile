import 'package:TodoApp/concept/concept.dart';
import 'package:TodoApp/extra/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Class to display the To-do List
class TodoListState extends State<TodoList> {
  final _todoItems = <Todo>[];
  final _titleFont = const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildFakeTodoItem(),
    );
  }

  Widget _buildRow(Todo item, int index) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item.title + index.toString(),
            style: _titleFont,
          ),
          Text(
            item.description + index.toString(),
            style: TextStyle(fontSize: 12.0, color: Colors.black38),
          ),
        ],
      ),
      leading: Icon(
        Icons.restaurant,
        color: Colors.blue,
      ),
      trailing: Container(
//        color: Colors.pink,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              item.date,
              style: TextStyle(fontSize: 12.0, color: Colors.black38),
            ),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          //Todo: view the details of the todo item
        });
      },
    );
  }

  Widget _buildFakeTodoItem() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _todoItems.length) {
            _todoItems.addAll(generateFakeTodoItem().take(4));
          }
          return _buildRow(_todoItems[index], index);
        });
  }
}

class TodoList extends StatefulWidget {
  @override
  TodoListState createState() => TodoListState();
}
