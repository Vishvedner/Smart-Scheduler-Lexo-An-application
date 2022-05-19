import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_scheduler_marked/provider/todos.dart';
import 'package:smart_scheduler_marked/Widget/todo_widget.dart';

import '../provider/user_simple_sharedPreferences.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class TodoListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;
    return todos.isEmpty
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(UserSimplePreferences.getMode() == 'dark')
            Text(
              'Create A Task',
              style: TextStyle(fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          if(UserSimplePreferences.getMode() == 'light')
            Text(
              'Create A Task',
              style: TextStyle(fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
        ],
      ),
    )
        : ListView.separated(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16),
      separatorBuilder: (context, index) => Container(height: 10),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoWidget(todo: todo);
      },
    );
  }
}