import 'dart:math';

import 'package:TodoApp/concept/concept.dart';

//Utility functions to help in development

//Function to create fake to do items
List<Todo> generateFakeTodoItem([int todoNumber = 10]) {
  final _tempFakeItems = <Todo>[];
  final _fakeDateList = <String>[
    '5:00am',
    '10:30am',
    '2:55pm',
    'Tommorrow',
    'Jun 13'
  ];
  final _random = new Random();
  for (int i = 0; i < todoNumber; i++) {
    _tempFakeItems.add(Todo(
      "Fake title ",
      _random.nextInt(4) + 1, //rank range 1-5
      _fakeDateList[_random.nextInt(5)],
      "content for item ",
    ));
  }
  return _tempFakeItems;
}
