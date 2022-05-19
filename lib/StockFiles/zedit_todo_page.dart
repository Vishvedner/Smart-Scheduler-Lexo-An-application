import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_scheduler_marked/model/todo.dart';
import 'package:smart_scheduler_marked/provider/todos.dart';
import 'package:smart_scheduler_marked/Widget/todo_form_widget.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;

  const EditTodoPage({Key ?key, required this.todo}) : super(key: key);

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;
  late String notifier;
  late String time;

  @override
  void initState() {
    super.initState();
    title = widget.todo.title;
    description = widget.todo.description;
    notifier = widget.todo.notifier;
    time = widget.todo.time.toString();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.black,
      title: Text('Edit Todo'),
      actions: [
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            final provider =
            Provider.of<TodosProvider>(context, listen: false);
            provider.removeTodo(widget.todo);

            Navigator.of(context).pop();
          },
        )
      ],
    ),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: TodoFormWidget(
          title: title,
          description: description,
          notifier: notifier,
          onChangedTitle: (title) => setState(() => this.title = title),
          onChangedDescription: (description) =>
              setState(() => this.description = description),
          onChangedNotifier: (notifier) => setState(() => this.notifier = notifier),
          onChangedTime: (time) => setState(() => this.time = time.toString()),
          onSavedTodo: saveTodo,
        ),
      ),
    ),
  );

  void saveTodo() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<TodosProvider>(context, listen: false);

      provider.updateTodo(widget.todo, title, description, notifier, time as TimeOfDay);

      Navigator.of(context).pop();
    }
  }
}