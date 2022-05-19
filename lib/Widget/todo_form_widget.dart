import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter/material.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:smart_scheduler_marked/api/notification_api.dart';
import 'package:smart_scheduler_marked/provider/user_simple_sharedPreferences.dart';

import '../utils.dart';

TimeOfDay _time = TimeOfDay.now().replacing(hour: 00, minute: 00);
bool iosStyle = true;

class TodoFormWidget extends StatefulWidget {
  final String title;
  final String description;
  final String notifier;
  final TimeOfDay time;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedNotifier;
  final ValueChanged<TimeOfDay> onChangedTime;
  final VoidCallback onSavedTodo;

  const TodoFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    this.notifier = '',
    this.time = const TimeOfDay(hour: 00, minute: 00),
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedNotifier,
    required this.onChangedTime,
    required this.onSavedTodo,
  }) : super(key: key);

  @override
  State<TodoFormWidget> createState() => _TodoFormWidgetState();
}

class _TodoFormWidgetState extends State<TodoFormWidget> {


  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              timePicker(),
              if(UserSimplePreferences.getMode() == 'dark')
                Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: buildTitle(),
                ),
              if(UserSimplePreferences.getMode() == 'light')
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: buildTitleDark(),
                ),
              if(UserSimplePreferences.getMode() == 'dark')
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: buildDescription(),
              ),
              if(UserSimplePreferences.getMode() == 'light')
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: buildDescriptionDark(),
                ),
              if(UserSimplePreferences.getMode() == 'dark')
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: buildNotifier(),
              ),
              if(UserSimplePreferences.getMode() == 'light')
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: buildNotifierDark(),
                ),
                const SizedBox(height: 40),
              if(UserSimplePreferences.getMode() == 'dark')
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                child: buildButton(),
              ),
              if(UserSimplePreferences.getMode() == 'light')
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                child: buildButtonDark(),
              ),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        cursorColor: Colors.blue,
        maxLines: 1,
        initialValue: widget.title,
        onChanged: widget.onChangedTitle,
        style: TextStyle(color: Colors.black),
        validator: (title) {
          if (title!.isEmpty) {
            return 'The title cannot be empty';
          }
          return null;
        },
        decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            labelText: 'TITLE',
            labelStyle: TextStyle(
              color: Colors.black,
              letterSpacing: 5,
            )),
      );


  Widget buildTitleDark() => TextFormField(
    cursorColor: Colors.blue,
    maxLines: 1,
    initialValue: widget.title,
    style: TextStyle(color: Colors.white),
    onChanged: widget.onChangedTitle,
    validator: (title) {
      if (title!.isEmpty) {
        return 'The title cannot be empty';
      }
      return null;
    },
    decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        labelText: 'TITLE',
        labelStyle: TextStyle(
          letterSpacing: 5,
          color: Colors.blue,
        )),
  );

  Widget buildDescription() => TextFormField(
        cursorColor: Colors.blue,
        maxLines: 2,
        initialValue: widget.description,
    style: TextStyle(color: Colors.black),
    onChanged: widget.onChangedDescription,
        decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            labelText: 'DESCRIPTION',
            labelStyle: TextStyle(
              color: Colors.black,
              letterSpacing: 5,
            )),
      );

  Widget buildDescriptionDark() => TextFormField(
    cursorColor: Colors.blue,
    maxLines: 2,
    initialValue: widget.description,
    onChanged: widget.onChangedDescription,
    style: TextStyle(color: Colors.white),
    decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        labelText: 'DESCRIPTION',
        labelStyle: TextStyle(
          color: Colors.blue,
          letterSpacing: 5,
        )),
  );

  Widget buildNotifier() => TextFormField(
        cursorColor: Colors.blue,
        maxLines: 1,
        initialValue: widget.notifier,
    style: TextStyle(color: Colors.black),
    onChanged: widget.onChangedNotifier,
        validator: (notifier) {
          if (notifier != '') {
            {
              if ((notifier != 'T') &&
                  (notifier != 'V') &&
                  (notifier != 't') &&
                  (notifier != 'v')) {
                return 'Please Enter Either T:Text or V:Voice';
              }
              return null;
            }
          }
        },
        decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            labelText: 'NOTIFIER',
            labelStyle: TextStyle(
              color: Colors.black,
              letterSpacing: 5,
            )),
      );

  Widget buildNotifierDark() => TextFormField(
    cursorColor: Colors.blue,
    maxLines: 1,
    initialValue: widget.notifier,
    onChanged: widget.onChangedNotifier,
    style: TextStyle(color: Colors.white),
    validator: (notifier) {
      if (notifier != '') {
        {
          if ((notifier != 'T') &&
              (notifier != 'V') &&
              (notifier != 't') &&
              (notifier != 'v')) {
            return 'Please Enter Either T:Text or V:Voice';
          }
          return null;
        }
      }
    },
    decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        labelText: 'NOTIFIER',
        labelStyle: TextStyle(
          color: Colors.blue,
          letterSpacing: 5,
        )),
  );

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
      print('*********************************************************');
      print('*********************************************************');
      print(_time);
      print('*********************************************************');
      print('*********************************************************');
    });
  }

  Widget timePicker() => Container(
        width: 500,
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Render inline widget
            createInlinePicker(
              //sunAsset: Image(image: AssetImage('assets/robot.png')),
              //moonAsset: Image(image: AssetImage('assets/robot.png')),
              dialogInsetPadding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
              elevation: 5,
              value: widget.time,
              onChange: widget.onChangedTime,
              minuteInterval: MinuteInterval.ONE,
              iosStylePicker: iosStyle,
              minHour: 00,
              maxHour: 23,
              cancelText: '',
              is24HrFormat: false,
            ),
          ],
        ),
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: SizedBox(
          height: 45,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
            onPressed: widget.onSavedTodo,
            child: const Text(
              'SAVE',
              style: TextStyle(color: Colors.white,letterSpacing: 5,),
            ),
          ),
        ),
      );

  Widget buildButtonDark() => SizedBox(
    width: double.infinity,
    child: SizedBox(
      height: 45,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        onPressed: widget.onSavedTodo,
        child: const Text(
          'SAVE',
          style: TextStyle(color: Colors.blue,letterSpacing: 5,),
        ),
      ),
    ),
  );
}
