import 'package:flutter/material.dart';
import 'package:TodoApp/concept/concept.dart';
import 'package:TodoApp/db/dbhelper.dart';
import 'package:TodoApp/UI/createtodo.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoListState();
}

class TodoListState extends State {
  DbHelper helper = DbHelper();
  List<Todo> todos;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (todos == null) {
      todos = List<Todo>();
      getData();
    }
    return Scaffold(
      backgroundColor: Color(0xFF2B292A),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Hi, This is your todo list"),
                  background: Image.asset(
                    "assets/images/land.jpg",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Center(
          child: todoListItems(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Todo('', 3, ''));
        },
        tooltip: "Add new Todo",
        child: new Icon(Icons.add),
      ),
    );
  }
  //Listview

  ListView todoListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Container(
          height: 90,
          child: Card(
            semanticContainer: true,
             clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Colors.white,
            elevation: 6.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: getColor(this.todos[position].rank),
                child: Text(this.todos[position].rank.toString()),
              ),
              onTap: () {
                debugPrint("Tapped on " + this.todos[position].id.toString());
                navigateToDetail(this.todos[position]);
              },
              title: Text(this.todos[position].title),
              subtitle: Text(this.todos[position].date),
            ),
          ),
        );
      },
    );
  }

  void getData() {
    final dbFuture = helper.initializeDb();
    dbFuture.then((result) {
      final todosFuture = helper.getTodos();
      todosFuture.then((result) {
        List<Todo> todoList = List<Todo>();
        count = result.length;
        for (int i = 0; i < count; i++) {
          todoList.add(Todo.fromObject(result[i]));
          debugPrint(todoList[i].title);
        }
        setState(() {
          todos = todoList;
          count = count;
        });
      });
    });
  }

  void navigateToDetail(Todo todo) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoDetail(todo)),
    );
    if (result == true) {
      getData();
    }
  }

  Color getColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.blue;
        break;
      case 3:
        return Colors.green;
        break;

      default:
        return Colors.green;
    }
  }
}
