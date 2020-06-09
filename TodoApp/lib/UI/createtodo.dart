import 'package:flutter/material.dart';
import 'package:TodoApp/concept/concept.dart';
import 'package:TodoApp/db/dbhelper.dart';
import 'package:intl/intl.dart'; //Allow to change date format

DbHelper helper = DbHelper();
final List<String> choices = const <String>[
  'Save Todo & Back',
  'Delete Todo',
  'Back to List'
];

const mnuSave = 'Save Todo & Back';
const mnuDelete = 'Delete Todo';
const mnuBack = 'Back to List';

class TodoDetail extends StatefulWidget {
  final Todo todo;
  TodoDetail(this.todo);

  @override
  State<StatefulWidget> createState() => TodoDetailState(todo);
}

class TodoDetailState extends State {
  Todo todo;
  TodoDetailState(this.todo);
  final _priorities = ["High", "Medium", "Low"];
  String _rank = "Low";
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = todo.title;
    descriptionController.text = todo.description;
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(todo.title),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: select,
              itemBuilder: (BuildContext context) {
                return choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    TextField(
                      controller: titleController,
                      style: textStyle,
                      onChanged: (value) => this.updateTitle(),
                      decoration: InputDecoration(
                          labelText: "Title",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextField(
                        controller: descriptionController,
                        style: textStyle,
                        onChanged: (value) => this.updateDescription(),
                        decoration: InputDecoration(
                            labelText: "Description",
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )),
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                      ),
                    ),
                    Text('Priority', style: TextStyle(fontSize: 16)),
                    ListTile(
                        title: DropdownButton<String>(
                      items: _priorities.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      style: textStyle,
                      value: retrieverank(todo.rank),
                      onChanged: (value) => updaterank(value),
                    )),
                    Container(
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.blueAccent,
                          onPressed: () {
                            save();
                          },
                          textColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: const Text('ADD ITEM', style: TextStyle(fontSize: 16))
                        ))
                  ],
                )
              ],
            )));
  }

  void select(String value) async {
    int result;
    switch (value) {
      case mnuSave:
        save();
        break;
      case mnuDelete:
        Navigator.pop(context, true);
        if (todo.id == null) {
          return;
        }
        result = await helper.deleteTodo(todo.id);
        if (result != 0) {
          AlertDialog alertDialog = AlertDialog(
            title: Text("Delete Todo"),
            content: Text("The Todo has been deleted"),
          );
          showDialog(context: context, builder: (_) => alertDialog);
        }
        break;
      case mnuBack:
        Navigator.pop(context, true);
        break;
      default:
    }
  }

  void save() {
    todo.date = new DateFormat.yMd().format(DateTime.now());
    if (todo.id != null) {
      helper.updateTodo(todo);
    } else {
      helper.insertTodo(todo);
    }
    Navigator.pop(context, true);
  }

  void updaterank(String value) {
    switch (value) {
      case "High":
        todo.rank = 1;
        break;
      case "Medium":
        todo.rank = 2;
        break;
      case "Low":
        todo.rank = 3;
        break;
    }
    setState(() {
      _rank = value;
    });
  }

  String retrieverank(int value) {
    return _priorities[value - 1];
  }

  void updateTitle() {
    todo.title = titleController.text;
  }

  void updateDescription() {
    todo.description = descriptionController.text;
  }
}
