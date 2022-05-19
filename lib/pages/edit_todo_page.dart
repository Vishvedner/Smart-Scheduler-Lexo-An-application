import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_scheduler_marked/model/todo.dart';
import 'package:smart_scheduler_marked/provider/todos.dart';
import 'package:smart_scheduler_marked/Widget/todo_form_widget.dart';
import 'package:smart_scheduler_marked/provider/user_simple_sharedPreferences.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;

  const EditTodoPage({Key? key, required this.todo}) : super(key: key);

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();

  List<String> lstOfTimeEdit = [];
  late String time;

  @override
  void initState() {
    super.initState();
    lstOfTimeEdit = UserSimplePreferences.getListOfTime() ?? ['kl','kl1'];
    time = widget.todo.time.toString();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            height: 500,
            width: 500,
            color: Colors.transparent,
            child: Center(
              child: GestureDetector(
                  onTap: () {
                    final provider =
                        Provider.of<TodosProvider>(context, listen: false);
                    provider.removeTodo(widget.todo);
                    lstOfTimeEdit.remove(time);
                    UserSimplePreferences.setListOfTime(lstOfTimeEdit);
                    Navigator.of(context).pop();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(UserSimplePreferences.getMode() == 'dark')
                      Icon(
                        Icons.delete,
                        size: 70,
                        color: Colors.white,
                      ),
                      if(UserSimplePreferences.getMode() == 'light')
                        Icon(
                          Icons.delete,
                          size: 70,
                          color: Colors.white,
                        ),
                    ],
                  )),
            ),
          ),
        ),
      );
}
