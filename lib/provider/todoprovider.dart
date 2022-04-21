import 'package:flutter/cupertino.dart';

class Todoitem extends ChangeNotifier {
  List<String> _listtodo = [];

  List<String> get listtodo {
    return [..._listtodo];
  }

  void addTodo(String todoitem) {
    _listtodo.add(todoitem);
    notifyListeners();
  }

  void removeTodo(String todoItem) {
    _listtodo.remove(todoItem);
    notifyListeners();
  }
}
