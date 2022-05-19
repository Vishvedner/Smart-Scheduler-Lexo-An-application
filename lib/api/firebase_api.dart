import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_scheduler_marked/model/todo.dart';
import 'package:smart_scheduler_marked/utils.dart';
import 'package:smart_scheduler_marked/authentication/authservice.dart';

class FirebaseApi {
  static Future<String> createTodo(Todo todo) async {
    final  uid = await AuthService().getCurrentUID();
   // final docTodo = FirebaseFirestore.instance.collection('todo').doc();
    final docTodo = FirebaseFirestore.instance.collection('userdata').doc(uid).collection('todo').doc();
    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());
    return docTodo.id;
  }

  //static Stream<List<Todo>> readTodos() => FirebaseFirestore.instance.collection('todo').orderBy(TodoField.createdTime, descending: true)
  static Stream<List<Todo>> readTodos() {
    String uid = (FirebaseAuth.instance.currentUser!).uid;
    return FirebaseFirestore.instance.collection('userdata').doc(uid).collection('todo').orderBy(TodoField.createdTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(Todo.fromJson));
  }

  static Future updateTodo(Todo todo) async {
    final  uid = await AuthService().getCurrentUID();
    //final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);
    final docTodo = FirebaseFirestore.instance.collection('userdata').doc(uid).collection('todo').doc(todo.id);
    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo) async {
    final  uid = await AuthService().getCurrentUID();
    //final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);
    final docTodo = FirebaseFirestore.instance.collection('userdata').doc(uid).collection('todo').doc(todo.id);
    await docTodo.delete();
  }

}