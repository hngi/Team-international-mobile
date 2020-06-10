import 'package:TodoApp/UI/createtodo.dart';
import 'package:TodoApp/concept/concept.dart';
import 'package:TodoApp/db/dbhelper.dart';
import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoListState();
}

class TodoListState extends State {
  DbHelper helper = DbHelper();
  List<Todo> todos;
  int count = 0;
  double top = 0.0;

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
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                // print('constraints=' + constraints.toString());
                top = constraints.biggest.height;
                return FlexibleSpaceBar(
                    //centerTitle: true,
                    title: _appBarText(top),
                    background: Image.asset(
                      "assets/images/land.jpg",
                      fit: BoxFit.cover,
                    ));
              }),
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

  //AppBar custom text i.e Title and subtitle
  Widget _appBarText(double top) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          firstChild: const Text("Hi",
              style: TextStyle(
                fontSize: 28.0,
              )),
          secondChild: const Text("Todo",
              style: TextStyle(
                fontSize: 28.0,
              )),
          crossFadeState:
          top > 100.0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
        AnimatedOpacity(
          duration: Duration(milliseconds: 450),
          //opacity: top == 80.0 ? 1.0 : 0.0,
          opacity: top < 100.0 ? 0.0 : 1.0,
          child: Visibility(
            visible: top < 100.0 ? false : true,
            child: Text(
              "This is your todo list",
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ),
      ],
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
