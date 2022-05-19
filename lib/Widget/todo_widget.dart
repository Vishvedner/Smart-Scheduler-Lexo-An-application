import 'package:smart_scheduler_marked/pages/edit_todo_page.dart';
import 'package:smart_scheduler_marked/provider/todos.dart';
import 'package:flutter/material.dart';
import 'package:smart_scheduler_marked/model/todo.dart';
import 'package:provider/provider.dart';
import 'package:smart_scheduler_marked/provider/user_simple_sharedPreferences.dart';

import '../utils.dart';


List<String> lstOfTimeQ = [];
List<String> lstOfTimeQCompare = [];
List<String> lstOfTimeUnique = [];
int i =0;

class TodoWidget extends StatelessWidget {
  final Todo todo;

   TodoWidget({
    required this.todo,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: buildTodo(context),
      );

  Widget buildTodo(BuildContext context) => GestureDetector(
    onTap: () => editTodo(context, todo),
    child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.only(left:0, right:5),
          child: Column(
            children: [
              if(UserSimplePreferences.getMode() == 'dark')
                Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    activeColor: Colors.black,
                    checkColor: Colors.white,
                    value: todo.isDone,
                    onChanged: (_) {
                        final provider = Provider.of<TodosProvider>(
                            context, listen: false);
                        final isDone = provider.toggleTodoStatus(todo);
                        if(todo.isDone == true){
                          lstOfTimeQCompare = UserSimplePreferences.getListOfTime() ?? ['jk'];
                          lstOfTimeQ.add(todo.time);
                          lstOfTimeUnique = lstOfTimeQ.where((item) => !lstOfTimeQCompare.contains(item)).toList();
                          UserSimplePreferences.setListOfTime(lstOfTimeUnique);
                          print(lstOfTimeUnique);
                          print('the unique list after the set time to complete');
                        }
                        if(todo.isDone == false){
                          lstOfTimeUnique = new List.from(lstOfTimeQCompare)..addAll(lstOfTimeQ);
                          UserSimplePreferences.setListOfTime(lstOfTimeUnique);
                          lstOfTimeQ.remove(todo.time);
                          print(lstOfTimeUnique);
                        }
                          print('888888888888888888888888888888888');
                          print(lstOfTimeQ);
                          print('888888888888888888888888888888888');
                          Utils.showSnackBar(context,
                              isDone ? 'Task completed' : 'Task is Incomplpete');

                    }
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text(
                                todo.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            if (todo.description.isNotEmpty)
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                child: Text(
                                  todo.description,
                                  style: TextStyle(fontSize: 12, height: 1.5, color: Colors.blue),
                                ),
                              ),
                          ],
                        ),
                        Expanded(flex: 1,child: Text(''),),

                        if (todo.time.length>10)
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(
                            todo.time.toString().substring(10,15),
                            style: TextStyle(fontSize: 12, height: 1.5, color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (todo.time.isEmpty)
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            child: Text(
                              'NOTE',
                              style: TextStyle(fontSize: 12, height: 1.5, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),


                            SizedBox(width: 20,),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text(':',style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                            ),
                            SizedBox(width: 20,),

                            if (todo.notifier.isNotEmpty)
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(
                            todo.notifier,
                            style: TextStyle(fontSize: 12, height: 1.5, color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (todo.notifier.isEmpty)
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            child: Text(
                              'NA',
                              style: TextStyle(fontSize: 12, height: 1.5, color: Colors.blue, fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if(UserSimplePreferences.getMode() == 'light')
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Checkbox(
                          activeColor: Colors.white,
                          checkColor: Colors.black,
                          value: todo.isDone,
                          onChanged: (_) {
                            final provider = Provider.of<TodosProvider>(
                                context, listen: false);
                            final isDone = provider.toggleTodoStatus(todo);
                            if(todo.isDone == true){
                              lstOfTimeQCompare = UserSimplePreferences.getListOfTime() ?? ['jk'];
                              lstOfTimeQ.add(todo.time);
                              lstOfTimeUnique = lstOfTimeQ.where((item) => !lstOfTimeQCompare.contains(item)).toList();
                              UserSimplePreferences.setListOfTime(lstOfTimeUnique);
                              print(lstOfTimeUnique);
                              print('the unique list after the set time to complete');
                            }
                            if(todo.isDone == false){
                              lstOfTimeUnique = new List.from(lstOfTimeQCompare)..addAll(lstOfTimeQ);
                              UserSimplePreferences.setListOfTime(lstOfTimeUnique);
                              lstOfTimeQ.remove(todo.time);
                              print(lstOfTimeUnique);
                            }
                            print('888888888888888888888888888888888');
                            print(lstOfTimeQ);
                            print('888888888888888888888888888888888');
                            Utils.showSnackBar(context,
                                isDone ? 'Task completed' : 'Task is Incomplpete');

                          }
                      ),
                    ),



                    SizedBox(width: 20),
                    Expanded(
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                child: Text(
                                  todo.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              if (todo.description.isNotEmpty)
                                Container(
                                  margin: EdgeInsets.only(top: 4),
                                  child: Text(
                                    todo.description,
                                    style: TextStyle(fontSize: 12, height: 1.5, color: Colors.blue),
                                  ),
                                ),
                            ],
                          ),
                          Expanded(flex: 1,child: Text(''),),

                          if (todo.time.length>10)
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text(
                                todo.time.toString().substring(10,15),
                                style: TextStyle(fontSize: 12, height: 1.5, color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                            ),
                          if (todo.time.isEmpty)
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text(
                                'NOTE',
                                style: TextStyle(fontSize: 12, height: 1.5, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),


                          SizedBox(width: 20,),
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            child: Text(':',style: TextStyle(
                              fontWeight: FontWeight.bold,
                               color: Colors.white,
                            ),),
                          ),
                          SizedBox(width: 20,),

                          if (todo.notifier.isNotEmpty)
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text(
                                todo.notifier,
                                style: TextStyle(fontSize: 12, height: 1.5, color: Colors.blue, fontWeight: FontWeight.bold),
                              ),
                            ),
                          if (todo.notifier.isEmpty)
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text(
                                'NA',
                                style: TextStyle(fontSize: 12, height: 1.5, color: Colors.blue, fontWeight: FontWeight.bold),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

              SizedBox(
                height: 10,
              ),
              if(UserSimplePreferences.getMode() == 'dark')
                Container(
                  width: 500,
                  height: 0.5,
                  color: Colors.black,
                ),
              if(UserSimplePreferences.getMode() == 'light')
              Container(
                width: 500,
                height: 0.5,
                color: Colors.white,
              )
            ],
          ),
        ),
  );
}

void doNothing(BuildContext context) {}
void deleteTodo(BuildContext context, Todo todo) {
  final provider = Provider.of<TodosProvider>(context, listen: false);
  provider.removeTodo(todo);

  Utils.showSnackBar(
      context, 'Deleted the task');
}

void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => EditTodoPage(todo: todo),
  ),
);
