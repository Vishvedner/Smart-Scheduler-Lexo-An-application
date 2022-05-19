import 'package:flutter/material.dart';
import 'package:smart_scheduler_marked/api/firebase_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_scheduler_marked/model/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  // to call the data from firebase and to show locally

  void setTodos(List<Todo> todos) =>
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _todos = todos;
        notifyListeners();
      });

  void addTodo(Todo todo) => FirebaseApi.createTodo(todo);

  //local storage
  //{ _todos.add(todo);
   // notifyListeners();}

  void removeTodo(Todo todo) => FirebaseApi.deleteTodo(todo);

  //_todos.remove(todo);
  //notifyListeners();

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);
    return todo.isDone;
  }
  //local storage
  // todo.isDone = !todo.isDone;
  //notifyListeners();
  //return todo.isDone;

  void updateTodo(Todo todo, String title, String description, String notifier, TimeOfDay time){
    todo.title = title;
   todo.description = description;
   todo.notifier = notifier;
   todo.time = time.toString();
   FirebaseApi.updateTodo(todo);
  }
  //local storage
  //{todo.title = title;
   // todo.description = description;
    //notifyListeners();
  //}

}