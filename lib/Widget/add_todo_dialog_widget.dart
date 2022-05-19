import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:smart_scheduler_marked/Widget/todo_form_widget.dart';
import 'package:smart_scheduler_marked/api/notification_api.dart';
import 'package:smart_scheduler_marked/model/todo.dart';
import 'package:smart_scheduler_marked/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_scheduler_marked/provider/todos.dart';
import 'package:smart_scheduler_marked/provider/user_simple_sharedPreferences.dart';


List<String> lstOfTime = ['kl','kl1'];
var i = 0 ;
var flag = 0;
var dialogFlag = 0;
int toggle = 0;

class AddTodoDialogWidget extends StatefulWidget {
  const AddTodoDialogWidget({Key? key}) : super(key: key);

  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {

  final FlutterTts flutterTts = FlutterTts();
  speak( String txt) async{
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(txt);
  }

  @override
  void initState(){
    super.initState();
    lstOfTime = UserSimplePreferences.getListOfTime() ?? ['kl','kl1'];
  }


  final _formKey = GlobalKey<FormState>();
  String title ='';
  String description = '';
  String notifier = '';
  String time = '';

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        TodoFormWidget(
                          onChangedTitle: (title) => setState(() => this.title = title.toUpperCase()),
                          onChangedDescription: (description) =>
                              setState(() => this.description = description),
                          onChangedNotifier: (notifier) =>
                              setState(() => this.notifier = notifier.toUpperCase()),
                          onChangedTime: (time) => setState(() {

                              for (i = 0; i < lstOfTime.length; i++) {
                                if(time.toString() == lstOfTime[i]){
                                  flag = 1;
                                  if(dialogFlag == 0){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) => new AlertDialog(
                                          title: new Text('Warning'),
                                          content: new Text('The Time already Exists'),
                                          actions: <Widget>[
                                            new IconButton(
                                                icon: new Icon(Icons.close),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    flag = 0;
                                                    toggle = 0;
                                                  });
                                                })
                                          ],
                                        ));
                                  }
                                  print('time matched******************************************************************************');
                                }
                              }
                              if(flag == 0){
                                //lstOfTime.add(time.toString());
                                print(lstOfTime);
                                print('the time is added to list***************************************************************');
                                this.time = time.toString();
                                setState(() {
                                  toggle = 1;
                                });
                              }

                            else{
                              print('list matched to time*********************************************************************');
                            }
                          }),
                          onSavedTodo: addTodo,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
      ),
  );
  void addTodo() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    if(toggle == 0){
      showDialog(
          context: context,
          builder: (BuildContext context) => new AlertDialog(
            title: new Text('Warning'),
            content: new Text('The Time already Exists'),
            actions: <Widget>[
              new IconButton(
                  icon: new Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      flag = 0;
                    });
                  })
            ],
          ));
    }

      else {
      setState(() {
        flag = 0;
        dialogFlag = 0;
        lstOfTime.add(time.toString());
        UserSimplePreferences.setListOfTime(lstOfTime);
        UserSimplePreferences.setMode(UserSimplePreferences.getMode().toString());
      });
      
        final todo = Todo(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        notifier: notifier,
        time: time,
        createdTime: DateTime.now(),
      );

        if(notifier == 't' || notifier == 'v' || notifier == 'T' || notifier == 'V'){
          if(notifier == 't' || notifier == 'T'){
            NotificationApi.showNotification(
              title: '${title}',
              body: 'has been scheduled '+'${time.toString()}',
              payload: 'ash.abs',
            );
          }
          if(notifier == 'v' || notifier == 'V'){
            NotificationApi.showNotification(
              title: '${title}',
              body: 'has been scheduled '+'${time.toString()}',
              payload: 'ash.abs',
            );
            setState(() {
              speak('Task named ${title}'+'has been scheduled'+'${time.toString()}');
            });
          }
          print('ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt');
        }

      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.addTodo(todo);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }
}
